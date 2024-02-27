import React from "react"
import ReactDOM from "react-dom/client"
import App from "./App"
import { BrowserRouter } from "react-router-dom"
import { Provider } from "react-redux"
import { createStore } from "redux"
import filterqueryApp from "./store/filterquery/filterqueries"

const store = createStore(filterqueryApp)

const root = ReactDOM.createRoot(document.getElementById("root"))

root.render(
  <>
    <React.StrictMode>
      <Provider store={store}>
        <BrowserRouter>
          <App />
        </BrowserRouter>
      </Provider>
    </React.StrictMode>
  </>
)
