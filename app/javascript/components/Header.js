import React, { useState, useEffect } from "react";
import IngredientsInput from "../components/IngredientsInput";

export default function Header({passIncludedIngredients, passExcludedIngredients, passIncludedPhrase,
    passSetIncludedIngredients, passSetExcludedIngredients, passSetIncludedPhrase, passHandleSearch}) {
    
    const [ingredients, setIngredients] = useState([]);

    useEffect(()=> {
        fetch("/api/v1/ingredients/index")
        .then((response)=>response.json()
        .then((json)=>setIngredients(json)))
    }, []);
    
    function handleIncludedPhrase(event) {
        passSetIncludedPhrase(event.target.value)
    }

    const handleOptionsUpdate = (action, selectedValue) => {
        if(action === 'selectOption') {
            setIngredients(ingredients
                .filter(ingredient => ingredient !== selectedValue))
        } else if(action === 'removeOption') {
            setIngredients([selectedValue, ...ingredients])
        }
    }
  
    const onIncludedIngredients = (valArray, action, selectedValue) => {
        handleOptionsUpdate(action, selectedValue);
        passSetIncludedIngredients(valArray);
    }
  
    const onExcludedIngredients = (valArray, action, selectedValue) => {
        handleOptionsUpdate(action, selectedValue);
        passSetExcludedIngredients(valArray);
    }

    return <div className="header">
        <div className="header_content">
            <div className="titleHaederDiv">
                <h1><a href="/">Receptų filtras</a></h1>
            </div>
            <div className="searchBarArea">
                <div className="muiAutocompleteInput">
                    <div className="searchAreaPhraseWrapper">
                        <input type="text" placeholder=" " onChange={handleIncludedPhrase} value={passIncludedPhrase} name="phrase" ></input>
                        <span>Frazė</span>
                    </div>
                </div>
                <div className="muiAutocompleteInput" >
                    <IngredientsInput
                        label="Yra" 
                        selectedIngredients={passIncludedIngredients} 
                        setSelectedIngredients={onIncludedIngredients} 
                        ingredientOptions={ingredients} 
                    />
                </div>
                <div className="muiAutocompleteInput" >
                    <IngredientsInput
                    label="Nėra" 
                    selectedIngredients={passExcludedIngredients} 
                    setSelectedIngredients={onExcludedIngredients} 
                    ingredientOptions={ingredients} 
                    />
                </div>
                <button onClick={passHandleSearch} className="filterButton">Ieškoti</button>
            </div>
        </div>
    </div>
}