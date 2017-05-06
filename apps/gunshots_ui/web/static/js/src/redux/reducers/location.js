import { actions } from '../actions/location'

function safeGetLocation() {
  try {
    const position = sessionStorage.getItem('locationData') || {}
    return JSON.parse(position)
  } catch (err) {
    return { isValid: null, expires: null, position: null }
  }
}

function isExpired(time) {
  return time < new Date().getTime()
}


const initialState = () => {
  const { isValid, expires, position } = safeGetLocation()


  return {
    isFetching: false,
    error: null,
    didInvalidate: isExpired(expires),
    position,
    expires,
    isValid
  }

}

export default function locationReducer (state = initialState(), action) {
  switch(action.type) {

    case actions.FETCH_LOCATION:

      return {
        ...state,
        isFetching: true
      }

    case actions.LOCATION_FETCHED:


      return {
        ...state,
        isFetching: false,
        didInvalidate: false,
        position: action.position || {},
        expires: action.expires,
        isValid: action.isValid
      }
    case actions.FETCH_LOCATION_FAILED:
      return {
        ...state,
        isFetching: false,
        didInvalidate: false,
        error: "Sorry, we were unable to fetch your location. Please make sure geolocation is enabled."
      }

    default:
      return state
  }
}
