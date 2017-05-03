import React, { Component } from 'react';
import Reveal from '../reveal/'

class ErrorDisplay extends Component {

  render() {
    const errors = this.props.errors.filter((item) => item).join(<br/>)
    return (
      <div className="Error">
        <Reveal showAfter={this.props.showAfter} className="Error">
          {
            errors.length && (
              <div className="Error-inner">
                <div className="Error-text">
                  { errors }
                </div>
              </div>
            )
          }
      </Reveal>
    </div>
    );
  }
}

ErrorDisplay.defaultProps = {
  showAfter: 250
}


export default ErrorDisplay;
