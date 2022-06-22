import { useState } from "react";
import {
  FaLongArrowAltRight,
  FaDirections,
  FaBus,
  FaHourglassStart,
  FaHourglassEnd
} from "react-icons/fa";
import './Slot.css'

export default function Slot({
  src_name,
  src_town,
  des_name,
  des_town,
  distance,
  inter_towns,
  brand,
  chair_count,
  ac,
  start_time,
  duration,

  expanded,
  toggle,
  onButtonClick,
  buttonText
}) {
  return (
    <div className="card" onClick={toggle}>
      <div className="column">
        <div className="row r">
            <div className="column f1">
            <div className="t">SOURCE</div>
            <div className="b">{src_name}</div>
            <div>{src_town}</div>
            </div>
            <FaLongArrowAltRight className="icon"/>
            <div className="column f1">
            <div className="t">DESTINATION</div>
            <div className="b">{des_name}</div>
            <div>{des_town}</div>
            </div>
        </div>
        <div className="icon-text r">
          <FaDirections className="icon"/>
          <span>
            {distance} KM, via {inter_towns}
         </span>
        </div>
        <div className="icon-text r">
          <FaBus className="icon"/>
          <span>
            {brand}, {chair_count} seater, {ac===0?'Non-AC':'AC'}
          </span>
        </div>
        <div className="row r">
          <div className="icon-text">
            <FaHourglassStart className="icon"/>
            <span>
              {start_time}
            </span>
          </div>
          <div className="spacer"></div>
          <div className="icon-text">
            <FaHourglassEnd className="icon"/>
            <span>
              {duration}
            </span>
          </div>
        </div>
        <button className={expanded?'inner':'closed'} onClick={onButtonClick}>{buttonText}</button>
      </div>
    </div>
  );
}
