import { createStore, applyMiddleware, combineReducers, compose } from  'redux'
import reduxThunk from 'redux-thunk'
import records from './reducers/records'
import location from './reducers/location'

const reducer = combineReducers({ records, location })
const maybeDevtools = window.devToolsExtension ? window.devToolsExtension() : (f) => f
const middleware = compose(applyMiddleware(reduxThunk), maybeDevtools)
const store = createStore(reducer, {}, middleware )

export default store
