import React, { Component } from 'react';
import { connect } from 'react-redux'
import Spinner from '../../components/spinner/'
import Result from '../../components/result/'
import ErrorDisplay from '../../components/error/'
import * as actions from '../../redux/actions/location'

class Outcome extends Component {

  componentDidMount() {
    this.props.dispatch(actions.fetchLocationIfNeeded())
  }

  render() {


    return (
      <main className="Home">
        <ErrorDisplay errors={ this.props.errors} />
        { this.props.isLoading &&  <Spinner/> }
        { this.props.location.position ?  <Result /> : null }
      </main>
    );
  }
}

Outcome.defaultProps = {
  errors: []
}

//TODO refactor to be more dry WRT maps
const mapStateToProps= ({ location, records}) => {
  const {position} = location
  const errors = [location.error, records.error].filter(item => item)
  const isLoading = !(errors.length || location.position)

  return { isLoading, errors, location, records }
}

export default connect(mapStateToProps)(Outcome);
