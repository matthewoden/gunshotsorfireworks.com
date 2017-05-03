import agent from 'superagent'
import geolib from 'geolib'


export const actions = {
  FETCH_RECORDS: "FETCH_RECORDS",
  RECORDS_FETCHED: "RECORDS_FETCHED",
  FETCH_RECORDS_FAILED: "FETCH_RECORDS_FAILED",
  MARK_RECORD_ACTIVE: "MARK_RECORD_ACTIVE"
}

const mileInMeters = 1609.34

function labelRecordsRelativeToUser (records, userLocation, type) {
  return records.map(record => {

    const nearby = geolib.isPointInCircle(record.coordinates, userLocation, mileInMeters)
    const recent = type === 'recent'

    return { ...record, nearby, recent }
  })
}


function fetchRecords(type) {
  return (dispatch, getState) => {
    dispatch({ type: actions.FETCH_RECORDS })

    return agent
      .get(`/api/records`)
      .query({type})
      .then(({body}) => {

        const { location } = getState()

        return dispatch({
          type: actions.RECORDS_FETCHED,
          records: labelRecordsRelativeToUser(body.records, location.position, type),
          lastFetched: body.last_fetched
        })
      })
      .catch(error => {
        console.error(error)

        return dispatch({
          type: actions.FETCH_RECORDS_FAILED,
          payload: error
        })
      })
  }
}

function shouldFetchRecords(records, location, type) {
  if (records.isFetching) {
    return false
  } else if (location.isValid || type === 'all')  {
    return true
  } else {
    return records.didInvalidate
  }
}


export function fetchRecordsIfNeeded(type) {
  return (dispatch, getState) => {
    const { records, location } = getState()

    if (shouldFetchRecords(records, location)) {
      return dispatch(fetchRecords(type))
    }
  }
}

