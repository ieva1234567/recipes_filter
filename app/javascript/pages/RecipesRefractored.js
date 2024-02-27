import React, { useState, useRef, useCallback } from "react";
import useRecipesSearch from "./useRecipesSearch";
import { useParams } from "react-router-dom";
import PseudNavbar from "../components/PseudNavbar";
import RecipesList from "../components/RecipesList";
import Header from "../components/Header";

export default function RecipesRefractored() {

  const [includedIngredients, setIncludedIngredients] = useState([]);
  const [excludedIngredients, setExcludedIngredients] = useState([]);
  const [includedPhrase, setIncludedPhrase] = useState("");
  const [finalQuery, setFinalQuery] = useState({});
  const [pageNumber, setPageNumber] = useState(1);
  const params = useParams();

  const {
    recipes,
    hasMore,
    loading,
    error
  } = useRecipesSearch(pageNumber, finalQuery, params.identifier);

  const observer = useRef();
  const lastrecipeElementRef = useCallback(node => {
    if (loading) return
    if (observer.current) observer.current.disconnect()
    observer.current = new IntersectionObserver(entries => {
      if (entries[0].isIntersecting && hasMore) {
        setPageNumber(prevPageNumber => prevPageNumber + 1)
      }
    })
    if (node) observer.current.observe(node)
  }, [loading, hasMore])

  function handleSearch(e) {
    setFinalQuery({included: includedIngredients, excluded: excludedIngredients, 
      includedPhrase: includedPhrase})
    setPageNumber(1)
  }

  return <>
    <Header passIncludedIngredients={includedIngredients}
        passExcludedIngredients={excludedIngredients} 
        passIncludedPhrase={includedPhrase}
        passSetIncludedIngredients={setIncludedIngredients}
        passSetExcludedIngredients={setExcludedIngredients}
        passSetIncludedPhrase={setIncludedPhrase}
        passHandleSearch={handleSearch}/>
    <div className="headerLine"></div>
    <div className="headerLine"></div>
    <div className="headerLine"></div>
    <PseudNavbar/>
    <div className="headerLine"></div>
    <div className="headerLine"></div>
    <div className="headerLine"></div>
    <RecipesList recipes={recipes} lastrecipeElementRef={lastrecipeElementRef} />
    <div>{loading && 'Loading...'}</div>
    <div>{error && 'Error'}</div>
  </>
}
