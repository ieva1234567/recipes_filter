import React, { useEffect, useState } from "react"
import { useParams } from "react-router-dom"
import { Helmet, HelmetProvider } from 'react-helmet-async';

export default function Recipe() {
  const id = useParams().id
  const url = "/api/v1/recipe/" + id
  const [recipe, setRecipe] = useState({})
  useEffect(()=> {
    fetch(url)
    .then((response)=>response.json()
    .then((json)=>setRecipe(json)))
  }, [])
  return <>
    <HelmetProvider context={{}}>
      <Helmet>
        <link rel="canonical" href="https://receptufiltras.eu"/>
      </Helmet>
    </HelmetProvider>
    <div>
      <h1>{recipe.title}</h1>
      <div className="headerLine">  </div>
      <div className="headerLine">  </div>
      <div className="headerLine">  </div>
      <br></br>
      <div className="blackContentContainer">
        <div className="whiteContentContainer">
            <div className="recipeContent">
                <div className="leftRecipeShowDiv">
                <img src={recipe.image} alt={recipe.title} className="thumbnail_img_image" 
                    style={{height: "200px"}}></img>
                </div>

                <div className="rightRecipeShowDiv"
                dangerouslySetInnerHTML={{__html: recipe.ingredients}}>
                </div>
            </div>
            <div style={{clear:"both"}} className="recipeContent">
                <br/>
                <div dangerouslySetInnerHTML={{__html: recipe.steps}}></div>
                <br/>
                <p>Originali nuoroda: <a target="_blank" href={recipe.url}>{recipe.title}</a></p>
            </div>
        </div>
      </div>
    </div>
  </>
}

