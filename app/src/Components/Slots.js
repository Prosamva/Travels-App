import { useState } from "react";
import Slot from "./Slot";

export default function Slots({ data, handleButtonClick, buttonText }) {
  const [currentlyExpanded, setCurrentlyExpanded] = useState(-1);
  const toggle = (i)=>{
    i===currentlyExpanded
      ? setCurrentlyExpanded(-1)
      : setCurrentlyExpanded(i);
  }
  return <div className="slots">
    {data.map((item, i)=>(<Slot {...item.value} key={item.key} toggle={()=>toggle(i)} buttonText={buttonText} expanded={i===currentlyExpanded} onButtonClick={()=>handleButtonClick(item)}/>))}
  </div>;
}
