import { fetchRecordsIfNeeded, actions } from '../records'


jest.mock('superagent')


let state;
const getState = () => state

const dispatch = (action) => {
  if (typeof action === 'function') {
    return action(dispatch, getState)
  } else {
    return action
  }
}

it('returns a function to fetch gunshots if never fetched', done => {
  state = {
    gunshots: {
      isFetching: false,
      records: [],
      didInvalidate: false
    },
    location: {
      isValid: true
    }
  }

  return fetchGunshotsIfNeeded()(dispatch, getState)
    .then(action => {
      expect(action).toMatchObject({
        type: 'RECORDS_FETCHED',
        records: []
      })

      done()
    })
})


it("returns undefined if nothing needs to happen", () => {

  state = {
    gunshots: {
      isFetching: false,
      records: [],
      didInvalidate: false
    },
    location: {
      isValid: false
    }
  }

  const result = fetchGunshotsIfNeeded()(dispatch, getState)

  expect(result).toBeUndefined()
})
