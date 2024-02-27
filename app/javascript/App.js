import React from "react";
import Recipe from "./pages/Recipe";
import About from "./pages/About";
import RecipesRefractored from "./pages/RecipesRefractored";
import { Route, Routes, Navigate } from "react-router-dom";
import { useSelector } from "react-redux";
import '../assets/stylesheets/application.css';

function App() {
  const siteIdentifiers = useSelector(state => state.siteIdentifiers)
  const mainUrl = "/recipes/" + siteIdentifiers[siteIdentifiers.length-1][0]['identifier']
  return (
    <>
      <div className="container">
        <Routes>
          <Route path="/" element={<Navigate to={mainUrl} replace={true} />} />
          <Route path="/recipes/:identifier" element={<RecipesRefractored />} />
          <Route path="/recipe/:id" element={<Recipe />} />
          <Route path="/about" element={<About />}/>
        </Routes>
      </div>
    </>
  )
}

export default App
