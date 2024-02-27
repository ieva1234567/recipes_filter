import React from "react";

export default function RecipesList({recipes, lastrecipeElementRef}) {
    return <>
        {recipes.map((recipe, index) => {
            if (recipes.length === index + 1) {
            return <div className="blackRecipesContainer" ref={lastrecipeElementRef} key={recipe.title} style={{display: "inline-block"}}>
                <a href={"/recipe/"+recipe.slug} className="thumbnail_img_title" target="_blank">
                    {recipe.title}
                    <br></br>
                </a>
            </div>
            } else {
            return <div className="blackRecipesContainer" key={recipe.title} style={{display: "inline-block"}}>
                <a href={"/recipe/"+recipe.slug} className="thumbnail_img_title" target="_blank">
                    {recipe.title}
                    <br></br>
                </a>
            </div>
            }
        })}
    </>
}