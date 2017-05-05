import React, { Component } from 'react';
import { connect } from 'react-redux'
import Spinner from '../../components/spinner/'
import EventMap from '../../components/events/'
import ErrorDisplay from '../../components/error/'
import * as actions from '../../redux/actions/location'

class MapView extends Component {

  componentDidMount() {
    this.props.dispatch(actions.fetchLocationIfNeeded())
  }

  render() {
    return (
      <main className="Home">
        <ErrorDisplay errors={ this.props.errors } />
        { this.props.isLoading && <Spinner/> }
        { this.props.position ? <EventMap {...this.props.records}/> : null }
      </main>
    );
  }
}

MapView.defaultProps = {
  errors: []
}

//TODO refactor to be more dry WRT outcome
const mapStateToProps= ({ location, records}) => {
  const {position} = location
  const errors = [location.error, records.error].filter(item => item)
  const isLoading = !(errors.length || position)

  return { isLoading, errors, position, records }
}

export default connect(mapStateToProps)(MapView);
