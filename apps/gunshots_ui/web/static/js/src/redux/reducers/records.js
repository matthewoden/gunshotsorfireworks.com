import { actions } from '../actions/records'

const initialState = {
  isFetching: false,
  didInvalidate: true,
  onlyRecent: true,
  gunshots: [],
  fireworks: [],
  nearby: [],
  records: [],
  lastFetched: "",
  error: null
}


initialState
const recordsReducer = (state = initialState, action) => {
  switch(action.type) {
    case actions.FETCH_RECORDS:
      return {
        ...state,
        isFetching: true
      }

    case actions.RECORDS_FETCHED:

      return {
        ...state,
        isFetching: false,
        didInvalidate: false,
        items: action.records,
        lastFetched: action.lastFetched,
      }

    case actions.FETCH_RECORDS_FAILED:
      return {
        ...state,
        isFetching: false,
        didInvalidate: false,
        error: "Sorry, we were unable to fetch reports near your location."
      }

    default:
      return state

  }
}

export default recordsReducer

