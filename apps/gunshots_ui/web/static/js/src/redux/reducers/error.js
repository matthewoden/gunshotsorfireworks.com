const initialState = {
  errors: []
}



errorReducer = (state = initialState, action) => {
  switch (action.type) {
    case action.NEW_ERROR:
      return {
         ...state,
         errors: state.errors.concat(action.error)
       }

    default:
      return state
  }


}
