require("dotenv").config();
const express = require("express");
const cors = require("cors");
const mysql = require("mysql");
const bodyParser = require("body-parser");
const multer = require("multer");
const commands = require("./sqlCommands");
const { config, Rekognition } = require("aws-sdk");
config.update({ region: process.env.AWSR_REGION });

const upload = multer();
const app = express();
const rekognition = new Rekognition();

app.use(cors());
app.listen(process.env.PORT);
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

console.log(`Server running on port ${process.env.PORT}...`);

function makeConnection() {
  const dbConnection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });
  dbConnection.connect((e) =>
    console.log(`CONNECTION MADE: ${dbConnection.threadId}`)
  );
  return dbConnection;
}

function endConnection(dbConnection) {
  dbConnection.end((err) =>
    console.log(
      `CONNECTION CLOSED: ${dbConnection.threadId}${
        err == null ? "" : "\n" + err
      }`
    )
  );
}

function handleError(err, res) {
  console.log(err, err.stack);
  res.status(406);
  res.json(err);
}

function handle(err, data, res) {
  if (err) {
    handleError(err, res);
  } else {
    console.log(data);
    res.json(data);
  }
}

function register(res, customerCommand, customerParams, regParams){
  const dbConnection = makeConnection();
  dbConnection.query(
    customerCommand,
    customerParams,
    (err)=>{
      if (err) {
        handleError(err, res);
        return;
      }
      const dbConnection = makeConnection();
      dbConnection.query(
        commands.register, regParams,
        (err, result) => handle(err, result, res)
      );
      endConnection(dbConnection);
    });
  endConnection(dbConnection);
}

app.get("/", (req, res) => {
  res.json({ message: "Hi from Summer Clouds Travels Server!" });
});

app.get("/towns", (req, res) => {
  const dbConnection = makeConnection();
  dbConnection.query(commands.towns, (err, result) => {
    if (err) console.log(err);
    res.json(result);
  });
  endConnection(dbConnection);
});

app.get("/info", (req, res) => {
  const params = [req.query.src, req.query.des, req.query.ac];
  const sstrs = ["SRC.town_located", "DES.town_located", "B.ac"];
  const resultStrs = [];
  const dbConnection = makeConnection();
  for (var i = 0; i < params.length; ++i) {
    if (params[i].toUpperCase() != "ANY")
      resultStrs.push(`${sstrs[i]}=${dbConnection.escape(params[i])}`);
  }
  dbConnection.query(
    resultStrs.length == 0
      ? commands.info("")
      : commands.info(`WHERE ${resultStrs.join(" AND ")}`),
    (err, result) => handle(err, result, res)
  );
  endConnection(dbConnection);
});

app.post("/register", upload.single("face"), (req, res) => {
  console.log(req.file);
  console.log(req.body);

  const params = {
    CollectionId: process.env.FACE_COLLECTION_ID,
    Image: { Bytes: req.file.buffer },
  };
  const { bus_id, email, name, phone } = req.body;
  rekognition.searchFacesByImage(
    { ...params, FaceMatchThreshold: process.env.FACE_MATCH_THRESHOLD },
    (err, data) => {
      if (err) {
        handleError(err, res);
        return;
      }

      const faceMatches = data.FaceMatches;
      if (faceMatches != null && faceMatches.length > 0) {
        const face_id = faceMatches[0].Face.FaceId;
        register(res, commands.updateCustomer, [email, name, phone, face_id], [face_id, bus_id]);
      } else {
        rekognition.indexFaces(params, (err, data) => {
          if (err) {
            handleError(err, res);
            return;
          }
          const faceRecords = data.FaceRecords;
          if (faceRecords.length == 0) {
            res.json({ message: "No face detected!" });
            return;
          }
          const face_id = faceRecords[0].Face.FaceId;
          register(res, commands.addCustomer, [face_id, email, name, phone], [face_id, bus_id]);
        });
      }
    }
  );
});

app.post("/verify", upload.single("face"), (req, res) => {
  const params = {
    CollectionId: process.env.FACE_COLLECTION_ID,
    Image: { Bytes: req.file.buffer },
    FaceMatchThreshold: process.env.FACE_MATCH_THRESHOLD,
  };

  rekognition.searchFacesByImage(params, (err, data) => {
    console.log(err, data);
    if (err) {
      handleError(err, res);
      return;
    }
    const faceMatches = data.FaceMatches;
    if (faceMatches == null || faceMatches.length == 0) {
      handleError({ message: "No matching face data found!" }, res);
      return;
    }
    const face_id = faceMatches[0].Face.FaceId;
    const dbConnection = makeConnection();
    dbConnection.query(
      commands.info(`JOIN Registrations R2 on B.id = R2.bus_id
      WHERE R2.face_id=?`),
      [face_id],
      (err, result) => {
        if (err) {
          handleError(err, res);
          return;
        }
        const dbConnection = makeConnection();
        dbConnection.query(commands.customer, [face_id], (err, result1) => {
          if (err) {
            handleError(err, res);
            return;
          }
          console.log({ registrations: result, customer: result1[0] });
          res.json({ registrations: result, customer: result1[0] });
        });
        endConnection(dbConnection);
      }
    );
    endConnection(dbConnection);
  });
});

app.post("/authorize", (req, res) => {
  console.log(req.body);
  const { face_id, bus_id } = req.body;
  const dbConnection = makeConnection();
  dbConnection.query(commands.authorize, [face_id, bus_id], (err, result) =>
    handle(err, result, res)
  );
  endConnection(dbConnection);
});

app.post("/remove", (req, res) => {
  console.log(req.body);
  const { face_id } = req.body;
  rekognition.deleteFaces(
    {
      CollectionId: process.env.FACE_COLLECTION_ID,
      FaceIds: [face_id],
    },
    (err) => {
      if (err) {
        handleError(err, res);
        return;
      }
      const dbConnection = makeConnection();
      dbConnection.query(commands.removeRegistrations, [face_id], (err) => {
        if (err) {
          handleError(err, res);
          return;
        }
        const dbConnection = makeConnection();
        dbConnection.query(commands.removeCustomer, [face_id], (err, result) =>
          handle(err, result, res)
        );
        endConnection(dbConnection);
      });
      endConnection(dbConnection);
    }
  );
});
