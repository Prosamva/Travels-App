import "./RegisterForm.css";
import Camera from "./Camera";
import { useState } from "react";
import Slots from "./Slots";
import axios from "axios";
import Empty from "./Empty";
import { serverUrl, turnKeyed } from "../utils";
import ProgressBar from "./ProgressBar";

export default function VerifyFragment({ onClose }) {
  const [stage, setStage] = useState(0);
  const [userData, setUserData] = useState({});
  const [photo, setPhoto] = useState(null);

  const verify = () => {
    if (photo == null) {
      alert("Capture image to proceed.");
      return;
    }
    setStage(1);
    axios
      .post(
        `${serverUrl}/verify/`,
        { face: photo },
        {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        }
      )
      .then((res) => {
        setUserData(res.data);
        console.log(res.data);
        setStage(2);
      })
      .catch((error) => {
        alert(error.response.data.message);
        setStage(0);
      });
  };

  const authorize = (item) => {
    setStage(1);
    axios
      .post(`${serverUrl}/authorize`, {
        face_id: userData.customer.face_id,
        bus_id: item.value.bus_id,
      })
      .then((res) => {
        alert("Booking authenicated successfully!");
        onClose();
      })
      .catch((error) => {
        alert("Something went wrong while trying to authorize! : " + error);
        onClose();
      });
  };

  const remove = () => {
    if (
      window.confirm(
        "Are you sure that you want to remove complete data related this ID? This cannot be undone."
      )
    ) {
      setStage(1);
      axios
        .post(`${serverUrl}/remove`, { face_id: userData.customer.face_id })
        .then((res) => {
          alert("Removed all data successfully!");
          onClose();
        })
        .catch((error) => {
          alert(
            "Something went wrong while trying to remove this data! : " + error
          );
          onClose();
        });
    }
  };

  return (
    <div className="form-container column">
      <div className="row">
        {stage === 2 ? (
          <button className="prev" onClick={() => setStage(0)}>
            🡰
          </button>
        ) : (
          <></>
        )}
        <h3>Verify</h3>
        <button type="button" className="close" onClick={onClose}>
          ✕
        </button>
      </div>
      {
        [
          // 0
          <>
            <Camera setPhoto={setPhoto} />
            <button onClick={verify}>Verify</button>
          </>,

          // 1
          <ProgressBar />,

          // 2
          userData == null ? (
            <Empty />
          ) : (
            <Details
              userData={userData}
              authorize={authorize}
              remove={remove}
            />
          ),
        ][stage]
      }
    </div>
  );
}

function Details({ userData, authorize, remove }) {
  return (
    <>
      <div className="row">
        <span>Name:</span>
        <span>{userData.customer.name}</span>
      </div>
      <div className="row">
        <span>E-mail:</span>
        <span>{userData.customer.email}</span>
      </div>
      <div className="row">
        <span>Phone No.:</span>
        <span>{userData.customer.phone}</span>
      </div>
      <div className="row">
        <button id="delete-info" onClick={remove}>
          DELETE INFO
        </button>
      </div>
      <h3>Bookings</h3>
      {userData.registrations.length === 0 ? (
        <Empty />
      ) : (
        <Slots
          data={turnKeyed(userData.registrations)}
          buttonText="AUTHORIZE"
          handleButtonClick={authorize}
        />
      )}
      <div className="vertical-spacer"></div>
    </>
  );
}
