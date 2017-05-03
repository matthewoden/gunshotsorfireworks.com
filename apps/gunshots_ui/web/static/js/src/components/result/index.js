import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import { MapIcon } from './icon'
import moment from 'moment'
import Reveal from '../reveal/'
import * as actions from '../../redux/actions/records'

const coerceResult = (isGunshots) => isGunshots ? 'GUNSHOTS' : 'FIREWORKS'

class Result extends Component {

  componentDidMount() {
    this.props.dispatch(actions.fetchRecordsIfNeeded())
  }

  resultText(results = []) {
    const gunshots = results.filter((result) => result.gunshots)
    const fireworks = results.filter((result) => result.fireworks)

    const single = gunshots.length === 1
    const numberOrNo = (list) => list.length ? list.length : 'no'
    const wasWere = single ? 'was' : 'were'
    const reports = single ? 'report' : 'reports'

    return `In the past 15 minutes, there ${wasWere} ${numberOrNo(gunshots)} ${reports} of gunfire and ${numberOrNo(gunshots)} ${reports} of fireworks in your area.`
  }

  render() {
    console.log(this.props)
    const resultType = coerceResult(this.props.gunshots.length > 0)
    const results = this.props.records ? this.props.records.filter(({recent}) => recent) : []
    const time = moment(this.props.lastFetched);
    const outOfBoundsResult = (
      <span>
        You're not currently in St. Louis. <br className="Result-mobile-only"/> Could be anything!
      </span>
    )

    return (
      <div className="Result">
        <Reveal
          showAfter={this.props.revealResultAfter || 0}
          className={"Overall"}
        >
          <div className="Result-inner">
            <div className="Result-text">
              <div className="Result-title">{resultType}!</div>
              <div className="Result-probs">
                <Reveal
                  showAfter={this.props.revealMaybeAfter}
                  className={"Maybe"}
                >
                  ...Maybe
                </Reveal>
              </div>

              <div className="Result-results">
                <Reveal
                  showAfter={this.props.revealDetailsAfter}
                  className={"Results"}
                >
                  {this.props.isValid
                   ? this.resultText(results)
                   : outOfBoundsResult
                  }<br/>
                </Reveal>
                <Reveal
                  showAfter={this.props.revealDetailsAfter}
                  className={"Time"}
                >
                  <span title={this.props.lastFetched} >
                    Last checked: {time.format('h:mma')}, {time.fromNow()}.
                  </span>
                </Reveal>
                <Reveal
                  showAfter={this.props.revealMapAfter}
                  className={"Explore"}
                >
                  <Link to="/map"> <MapIcon/> Explore event map </Link>
                </Reveal>
              </div>
            </div>
          </div>
        </Reveal>
      </div>
    );
  }
}


const mapStateToProps = ({records, location}) => {

  return {
    ...records,
    isValid: location.isValid
  }
}

Result.defaultProps = {
  gunshots: [],
  fireworks: [],
  isValid: false,
  revealResultAfter: 250,
  revealMaybeAfter: 500,
  revealDetailsAfter: 1000,
  revealMapAfter: 1500
}

export default connect(mapStateToProps)(Result)
export { Result }
