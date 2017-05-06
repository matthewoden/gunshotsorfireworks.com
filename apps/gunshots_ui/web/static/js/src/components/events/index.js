import React, { Component } from 'react';
import ReactDOM from 'react-dom'
import { connect } from 'react-redux'
import * as actions from '../../redux/actions/records'
import moment from 'moment'
import GoogleMapReact from 'google-map-react';
import {EventMarker, UserMarker} from './eventIcon'

const API_KEY = 'AIzaSyAyv9Y3B9BlvfkzwAzL9Kgz3ZYeZrRjOPs'

const options = {
  styles: [{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]
}

class EventMap extends Component {

  constructor(props){
    super(props)
    this.handleMouseEnter = this.handleMouseEnter.bind(this)
    this.handleSidebarSelect = this.handleSidebarSelect.bind(this)
    this.toggleSidebar = this.toggleSidebar.bind(this)
    this.revealOnMap = this.revealOnMap.bind(this)
    this.revealInSidebar = this.revealInSidebar.bind(this)

    this.state = { center: null, activeId: null, sidebarActive: true }
  }

  static defaultProps = {
    items: [],
    center: {},
    defaultCenter: {lat: 38.616082, lng: -90.211687},
    defaultZoom: 17
  }

  componentDidMount(){
    this.props.dispatch(actions.fetchRecordsIfNeeded('all'))
  }

  handleMouseEnter(item) {
    this.setState({ activeId: item.id })
  }

  handleSidebarSelect(item) {
    this.setState({ sidebarActive: false })
    this.revealOnMap(item.coordinates)
  }

  toggleSidebar() {
    this.setState({ sidebarActive: !this.state.sidebarActive })
  }

  revealOnMap({latitude, longitude}) {
    const center = {lat: latitude, lng: longitude}
    this.setState({ center })
  }

  revealInSidebar(id) {
    const node =  this.refs[id]

    node.scrollIntoViewIfNeeded ? node.scrollIntoViewIfNeeded() : node.scrollIntoView()
  }




  render() {
    const markers = this.props.items.length ?
                    [].concat(<UserMarker {...this.props.center} key={this.props.center} />)
                      .concat(
                        this.props.items.map((item) =>
                          <EventMarker
                            key={item.id}
                            {...item}
                            active={this.state.activeId === item.id}
                            onMouseEnter={() => this.handleMouseEnter(item)}
                            onClick={() => this.revealInSidebar(item)}
                            lat={item.coordinates.latitude}
                            lng={item.coordinates.longitude}
                            />))
                  : null

    const sidebarClasses = this.state.sidebarActive ? 'EventMap-sidebar--active' : ''

    return(
      <div className="EventMap">
        <div className="EventMap-inner">
          <aside className={`EventMap-sidebar ${sidebarClasses}`}>
            <div className="EventMap-menu" onClick={this.toggleSidebar}>
              Event List{' '}
              <small>(Last 24 hours)</small>
              <div className="EventMap-menu-icon EventMap-menu-icon-up">
                <svg viewBox="0 0 24 24">
                  <path d="M7.41,15.41L12,10.83L16.59,15.41L18,14L12,8L6,14L7.41,15.41Z" />
                </svg>
              </div>
              <div className="EventMap-menu-icon EventMap-menu-icon-down ">
                <svg viewBox="0 0 24 24">
                  <path d="M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z" />
                </svg>
              </div>
            </div>
            <div className="EventMap-item-list">
              {this.props.items.length > 0 && this.props.items.map((item) => {
                 const activeClass = this.state.activeId === item.id
                                   ? 'EventMap-item--active'
                                   : ''
                 return (
                   <div
                     className={`EventMap-item ${activeClass}`}
                     key={`aside-${item.id}`}
                     ref = {item.id}
                     onMouseEnter={() => this.handleMouseEnter(item)}
                     onClick={() => this.handleSidebarSelect(item)}
                   >
                     <div className="EventMap-item-type">{item.type}</div>
                     <div className="EventMap-item-location">@{item.location.toLowerCase()}</div>
                     <div className="EventMap-item-time">{moment(item.time).format('h:mma')} ({moment(item.time).fromNow()})</div>
                     <div className="EventMap-item-id">{item.id}</div>

                   </div>
                 )
              })
              }
              {this.props.items.length < 1 && (
                 <div className="EventMap-item">No records available.</div>
              )}
            </div>

          </aside>

          <section className="EventMap-map">
            <div className="Map-inner">
              <GoogleMapReact
                bootstrapURLKeys={{key: API_KEY}}
                defaultZoom={this.props.defaultZoom}
                defaultCenter={this.props.defaultCenter}
                center={this.state.center || this.props.center}
                options={options}
              >
                {markers}
              </GoogleMapReact>
            </div>
          </section>
        </div>
      </div>
    )
  }
}

const mapStateToProps = ({records, location}) => {

  const locationAsCenter = location.position ? { lat: location.position.latitude, lng: location.position.longitude } : {}
  return {
    items: records.items,
    center: locationAsCenter
  }
}


export default connect(mapStateToProps)(EventMap)
