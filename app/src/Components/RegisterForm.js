import Camera from "./Camera";
import "./RegisterForm.css";
import { useState } from "react";
import axios from "axios";
import { serverUrl } from "../utils";
import { FaUser, FaEnvelope, FaPhone, FaPhoneAlt } from "react-icons/fa";

export default function RegisterForm({ onClose, slot }) {
  const [photo, setPhoto] = useState(null);

  const submit = (form) => {
    form.preventDefault();
    if(photo==null){
        alert("Capture image to proceed.");
        return;
    }
    const formData = new FormData(form.target);
    formData.append("bus_id", slot.value.bus_id);
    formData.append("face", photo);
    axios
      .post(`${serverUrl}/register/`, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      })
      .then(res => {
          alert("Registration successful!");
      })
      .catch(error => {
        alert(error.response.data.message);
      });
      onClose();
  };

  return (
    <form className="form-container column" onSubmit={submit} method="POST">
      <div className="row">
        <h3>Register/Book Slot</h3>
        <button type="button" className="close" onClick={onClose}>✕</button>
      </div>
      <div className="row">
        <label htmlFor="name" className="f1"><FaUser className="i"/> Name</label>
        <input className="f2" name="name" id="name" required/>
      </div>
      <div className="row">
        <label htmlFor="email" className="f1"><FaEnvelope className="i"/> Email</label>
        <input name="email" className="f2" type="email" id="email" required/>
      </div>
      <div className="row">
        <label htmlFor="phone" className="f1"><FaPhoneAlt className="i"/> Phone</label>
        <input
          name="phone"
          className="f2"
          maxLength={10}
          pattern="^[0-9]{10}$"
          id="phone"
          required
        />
      </div>
      <Camera setPhoto={setPhoto}/>
      <button type="submit">Register</button>
    </form>
  );
}
