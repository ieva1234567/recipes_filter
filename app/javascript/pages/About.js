import React, {useState} from "react";
import ContactForm from "../components/ContactForm";

export default function About() {

    return <>
        <div className="header">
            <div className="header_content">
                <div className="titleHaederDiv">
                    <h1><a href="/">Receptų filtras</a></h1>
                </div>
            </div>
        </div>
        <div className="blackContentContainer">
            <div className="whiteContentContainer">
                <div>
                    <div className="leftAboutDiv" >
                        <p>Hipoalerginė dieta? Eliminacinė dieta? Negalite vartoti tam tikrų produktų? 
                        Alergija maistui ar maisto netoleravimas? Receptų filtras buvo sukurtas siekiant atsekti produktus kuriems 
                        organizmas yra alergiškas. </p>
                        <p>Receptų Filtras yra unikali internetinė svetainė, kuri leidžia jums rasti idealų 
                        receptą pagal jūsų pageidavimus! Su šia svetaine galite lengvai atrinkti norimus produktus, 
                        nurodyti produktus, kurių receptuose neturėtų būti, ir naudoti specifinę frazę.</p>
                        <p>Pavyzdžiui jeigu norite moliūgų sriubos be bulvių ties "yra" pasirinkite moliūgus ties "nėra" bulves
                        "frazėje" įveskite "sriuba" ir spauskite "ieškoti".</p>
                        <p>Norite "nufiltruoti" savo svetainę esančią šiame puslapyje? Susisiekite ! </p>
                    </div>
                    <div className="rightAboutDiv">
                        <ContactForm/>
                    </div>
                    <br style={{"clear":"both"}}/>
                </div>
            </div>
        </div>
    </>
}
