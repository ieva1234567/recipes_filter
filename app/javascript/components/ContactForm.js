import React, { useState } from "react";

export default function ContactForm() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [message, setMessage] = useState("");
  const [validationErrors, setValidationErrors] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    fetch("/api/v1/mailings/send_please_contact_me_mail?email="+email+"&name="+name+"&message="+message,
    {
      headers: {
        "Authorization": process.env.REACT_APP_CONTACT_FORM_TOKEN
      }
    })
    .then( (response)=>response.json() )
    .then( (json)=> { 
      if (typeof(json.errors) != "undefined") {
        setValidationErrors(json.errors);
      } else {
        setValidationErrors({});
        setName("");
        setEmail("");
        setMessage("");
        if (json.message == "email shipping sheduled") {
          alert("Žinutė išsiųsta!");
        }
      }
    } )
    
  }

  return (
    <form onSubmit={handleSubmit}>
      <label className="contactInputLabel">Vardas
        <input 
          className="contactInput "
          type="text" 
          value={name}
          onChange={(e) => setName(e.target.value)}
          name="contactInputName"
        />
      </label>
      <label className={"contactInputLabel " + (validationErrors.email ? "hasError" : "")} >El. paštas
        <input 
          className={ "contactInput "  + (validationErrors.email ? "hasError" : "") }
          type="text" 
          value={email}
          name="contactInputEmail"
          onChange={(e) => setEmail(e.target.value)}
        />
        <p style={{"display": validationErrors.email ? "block" : "none" }} className="validationErrorText">{validationErrors.email}</p>
      </label>
      <label className={"contactInputLabel " + (validationErrors.message ? "hasError" : "")}>Žinutė
        <textarea 
          rows="4" 
          cols="50"
          className={ "contactInputTextArea "  + (validationErrors.message ? "hasError" : "") }
          type="text" 
          value={message}
          name="contactInputTextArea"
          onChange={(e) => setMessage(e.target.value)}
        />
        <p style={{"display": validationErrors.email ? "block" : "none" }} className="validationErrorText">{validationErrors.message}</p>
      </label>
      <input type="submit" className="submitMessageButton" value="Siųsti"/>
    </form>
  )
}