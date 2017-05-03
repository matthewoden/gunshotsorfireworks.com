import React from 'react'
import moment from 'moment'

const GunIcon = ({classNames}) => {
  return (
  <svg className={"EventIcon EventIcon--Gun"} viewBox="0 0 24 24">
    <path d="M7,5H23V9H22V10H16A1,1 0 0,0 15,11V12A2,2 0 0,1 13,14H9.62C9.24,14 8.89,14.22 8.72,14.56L6.27,19.45C6.1,19.79 5.76,20 5.38,20H2C2,20 -1,20 3,14C3,14 6,10 2,10V5H3L3.5,4H6.5L7,5M14,12V11A1,1 0 0,0 13,10H12C12,10 11,11 12,12A2,2 0 0,1 10,10A1,1 0 0,0 9,11V12A1,1 0 0,0 10,13H13A1,1 0 0,0 14,12Z" />
  </svg>
)}

const FireworkIcon = () => (
    <svg className={"EventIcon EventIcon--FireworkIcon"} viewBox="0 0 24 24">
      <path d="M2.2,16.06L3.88,12L2.2,7.94L6.26,6.26L7.94,2.2L12,3.88L16.06,2.2L17.74,6.26L21.8,7.94L20.12,12L21.8,16.06L17.74,17.74L16.06,21.8L12,20.12L7.94,21.8L6.26,17.74L2.2,16.06M4.81,9L6.05,12L4.81,15L7.79,16.21L9,19.19L12,17.95L15,19.19L16.21,16.21L19.19,15L17.95,12L19.19,9L16.21,7.79L15,4.81L12,6.05L9,4.81L7.79,7.79L4.81,9Z" />
    </svg>
  )

const UserIcon = () => (
  <svg className="EventIcon EventIcon--User" viewBox="0 0 24 24">
    <path d="M12,4A4,4 0 0,1 16,8A4,4 0 0,1 12,12A4,4 0 0,1 8,8A4,4 0 0,1 12,4M12,14C16.42,14 20,15.79 20,18V20H4V18C4,15.79 7.58,14 12,14Z" />
  </svg>
)

const Tooltip = (props) => (
  <div className="EventTooltip">
    <div className="EventTooltip-type">{props.type}</div>
    <div className="EventTooltip-time">{moment(props.time).format('MMM DD, h:mma')}</div>
  </div>

)

export const EventMarker = ({gunshots, nearby, active, time, type, onMouseEnter, onMouseLeave, onClick}) => {
  const activeClass = active ? 'Event--active' : ''
  const nearbyClass = nearby ? 'Event--nearby' : ''
  const classes = `${nearbyClass} ${activeClass}`

  return (
    <div className={`Event ${classes}`}>
      { active && <Tooltip time={time} type={type}/> }
      <div className="EventMarker" onMouseEnter={onMouseEnter} onMouseLeave={onMouseLeave} onClick={onClick}>
       { gunshots ? <GunIcon /> : <FireworkIcon  /> }
      </div>
    </div>
  )
}




export const UserMarker = () =>
  <div className="UserMarker">
    <UserIcon/>
  </div>
