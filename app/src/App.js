import "./App.css";
import CitySelector from "./Components/CitySelector";
import Slots from "./Components/Slots";
import { useState, useEffect } from "react";
import axios from "axios";
import RegisterForm from "./Components/RegisterForm";
import { FaCloud, FaBars } from "react-icons/fa";
import VerifyFragment from "./Components/VerifyFragment";
import ProgressBar from "./Components/ProgressBar";
import Empty from "./Components/Empty";
import { serverUrl, defCities, wildSelector, turnKeyed } from "./utils";

function App() {
  const [cities, setCities] = useState(defCities);
  const [slots, setSlots] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [currentP, setCurrentP] = useState(0);
  const [source, setSource] = useState(wildSelector);
  const [destination, setDestination] = useState(wildSelector);
  const [chosenSlot, setChosenSlot] = useState(null);
  const [showMore, setShowMore] = useState(false);

  function Popup({ type }) {
    switch (type) {
      case 1:
        return <RegisterForm onClose={closePopup} slot={chosenSlot} />;
      case 2:
        return <VerifyFragment onClose={closePopup} state={currentP} />;
      default:
        <></>;
    }
  }

  const closePopup = () => {
    setChosenSlot(null);
    setCurrentP(0);
  };

  const getCities = () => {
    axios
      .get(serverUrl + "/towns")
      .then((res) => {
        var cs = defCities.concat(
          res.data.map((item, i) => ({ name: item.name, key: i + 1 }))
        );
        setCities(cs);
      })
      .catch((error) =>
        alert("Something went wrong while trying to fetch cities! " + error)
      );
  };
  useEffect(getCities, []);

  const updateSlots = () => {
    setIsLoading(true);
    axios
      .get(`${serverUrl}/info`, {
        params: { src: source, des: destination, ac: "ANY" },
      })
      .then((res) => {
        console.log(res.data);
        setSlots(turnKeyed(res.data));
        setIsLoading(false);
      })
      .catch((error) => {
        alert("Something went wrong while trying to fetch data! " + error);
        setIsLoading(false);
      });
  };
  useEffect(updateSlots, [source, destination]);

  const register = (data) => {
    setChosenSlot(data);
    setCurrentP(1);
  };

  return (
    <div className="App">
      <header>
        <div className="row">
          <h1 className="item">
            <FaCloud /> Summer Clouds Travels
          </h1>
          <button className="item menu" onClick={() => setShowMore(!showMore)}>
            <FaBars />
          </button>
        </div>
        <div className={`row more ${showMore ? "show" : ""}`}>
          <div className="selectors">
            <CitySelector
              id="src"
              cities={cities}
              label="Source"
              value={source}
              onChanged={(e) => setSource(e.target.value)}
            />
            <CitySelector
              id="dst"
              cities={cities}
              label="Destination"
              value={destination}
              onChanged={(e) => setDestination(e.target.value)}
            />
          </div>
          <div className="item">
            <button className="inner" onClick={() => setCurrentP(2)}>
              Verify
            </button>
          </div>
        </div>
      </header>
      <div className={currentP === 0 ? "popup gone" : "popup visible"}>
        <Popup type={currentP} />
      </div>
      <div className="container">
        {isLoading ? (
          <ProgressBar />
        ) : slots == null || slots.length === 0 ? (
          <Empty />
        ) : (
          <Slots
            data={slots}
            handleButtonClick={register}
            buttonText="BOOK NOW"
          />
        )}
      </div>
    </div>
  );
}

export default App;
