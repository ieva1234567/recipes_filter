import React, { useEffect, useState } from "react"
import { Link } from "react-router-dom"
import { useSelector, useDispatch } from "react-redux"
import { addSiteIdentifiers } from "../store/filterquery/filterqueries"
import { NavLink } from "react-router-dom"

const pathNameLastWord = window.location.pathname.slice(-1)[0]

export default function PseudNavbar() {
    const dispatch = useDispatch()
    useEffect(()=> {
        fetch("/api/v1/site_identifiers/index")
            .then((response)=>response.json()
            .then((json)=>dispatch(addSiteIdentifiers(json))));
        //updateMenuList();
    }, [])

    const siteIdentifiers = useSelector(state => state.siteIdentifiers);
    const menuListArray = siteIdentifiers[siteIdentifiers.length-1].map(d=> (<li key={d.identifier}><NavLink key={d.identifier} to={"/recipes/"+d.identifier}>{d.title}</NavLink></li>));
    menuListArray.push((<li key="about"><NavLink to="/about">Apie</NavLink></li>));

    return <>
        <nav className="nav">
            <ul>
                {menuListArray}
            </ul>
        </nav>
    </>

}