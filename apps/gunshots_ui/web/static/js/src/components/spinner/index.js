import React, { Component } from 'react';

class Spinner extends Component {
  render() {
    // Eventually, switch out the map icon, with a ! icon
    return (
      <div className="Spinner">
          <div className="Spinner-icon">
            <svg viewBox="0 0 24 24">
              <path d="M12,11.5A2.5,2.5 0 0,1 9.5,9A2.5,2.5 0 0,1 12,6.5A2.5,2.5 0 0,1 14.5,9A2.5,2.5 0 0,1 12,11.5M12,2A7,7 0 0,0 5,9C5,14.25 12,22 12,22C12,22 19,14.25 19,9A7,7 0 0,0 12,2Z" />
            </svg>
          </div>
        <div className="Spinner-container">
          <div className="Spinner-inner2"/>
          <div className="Spinner-inner1"/>
        </div>
        <div className="Spinner-text">Fetching Location... </div>
      </div>
    );
  }
}


export default Spinner;
