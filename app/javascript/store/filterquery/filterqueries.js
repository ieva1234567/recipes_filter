import { combineReducers } from "redux";
const ADD_QUERY = "ADD_QUERY";
const ADD_SITE_IDENTIFIERS = "ADD_SITE_IDENTIFIERS";

export function addQuery(filterquery) {
  return {
    type: ADD_QUERY,
    filterquery
  }
}

const defaultFilterquery = [{
  included: [],
  excluded: []
}]

function filterqueries(state=defaultFilterquery, action) {
  switch (action.type) {
    case ADD_QUERY:
      return [
        ...state,
        { 
          included: action.filterquery.included,
          excluded: action.filterquery.excluded
        }
      ];
    default:
      return state;
  }
}

export function addSiteIdentifiers(siteIdentifiers) {
  return {
    type: ADD_SITE_IDENTIFIERS,
    siteIdentifiers
  }
}

const defaulSiteIdentifiers = [[{id: 0, title: "La Maistas", identifier: "la_maistas"}]]

function siteIdentifiers(state=defaulSiteIdentifiers, action) {
  switch (action.type) {
    case ADD_SITE_IDENTIFIERS:
      return [
        ...state,
        action.siteIdentifiers
      ];
    default:
      return state;
  }
}

const filterqueryApp = combineReducers({
  filterqueries,
  siteIdentifiers
});

export default filterqueryApp;