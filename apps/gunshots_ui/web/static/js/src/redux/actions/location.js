import geolib from 'geolib'

export const actions = {
  FETCH_LOCATION: "FETCH_LOCATION",
  LOCATION_FETCHED: "LOCATION_FETCHED",
  FETCH_LOCATION_FAILED: "FETCH_LOCATION_FAILED",

  VALIDATE_LOCATION: "VALIDATE_LOCATION",
  LOCATION_VALIDATED: "LOCATION_VALID",
  VALIDATE_LOCATION_FAILED: "VALIDATE_LOCATION_FAILED",
}

const boundingBox = [
  {latitude: 38.774349, longitude: -90.166409}, //NE
  {latitude: 38.774349, longitude: -90.320515}, //NW
  {latitude: 38.531852, longitude: -90.320515}, //SW
  {latitude: 38.531852, longitude: -90.166409}, //SE
]

function locationPromise () {
  return new Promise((resolve, reject) => {
    if ("geolocation" in navigator) {

      const geoSuccess = (position) => resolve(position.coords)
      const geoFailure = (error) => reject(error)

      const geoOptions = {
        enableHighAccuracy: false,
        maximumAge        : 30000,
        timeout           : 27000
      }

       navigator
        .geolocation
        .getCurrentPosition(geoSuccess, geoFailure, geoOptions);

    } else {
      return reject(new Error("Geolocation not available"))
    }
  })
}

export function fetchLocation() {
  return (dispatch, getState) => {
    dispatch({type: actions.FETCH_LOCATION})

    return locationPromise()
    .then((coords) => {
      requestAnimationFrame(() => {

        const position = { latitude: coords.latitude, longitude: coords.longitude }
        const expires = new Date().getTime() + 1000*60*5
        const isValid = geolib.isPointInside(position, boundingBox)
        const session = JSON.stringify({ position, expires, isValid })

        sessionStorage.setItem('locationData', session)

        dispatch({
            type: actions.LOCATION_FETCHED,
            position,
            expires,
            isValid
          })
      })

    })
    .catch((error) => {
      console.error(error)
       dispatch({
        type: actions.FETCH_LOCATION_FAILED,
        error: error
      })
    })
  }
}


function shouldFetchLocation(state) {
  if (state.isFetching) {
    return false
  } else if (!state.position || state.expires < new Date().getTime()) {
    return true
  } else {
    return state.didInvalidate
  }
}

export function fetchLocationIfNeeded() {
  return (dispatch, getState) => {
    const { location } = getState()

    if (shouldFetchLocation(location)) {
      return dispatch(fetchLocation())
    }
  }
}
