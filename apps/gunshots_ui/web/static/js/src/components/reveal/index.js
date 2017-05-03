import React, { Component } from 'react'
import CSSTransitionGroup from 'react-transition-group/CSSTransitionGroup'
class Reveal extends Component {
  constructor(props) {
    super(props)
    this.state = {show: false}
    this.setChildTimeout = this.setChildTimeout.bind(this)
    this._timeout = null
  }


  componentDidMount(){
    this.setChildTimeout(this.props)
  }

  componentWillReceiveProps(newProps) {
    this.setChildTimeout(newProps)
  }

  setChildTimeout(props) {
    clearTimeout(this._timeout)
    if (props.children) {
      setTimeout(() => { this.setState({show: true}) }, this.props.showAfter)
    }
  }


  componentWillUnmount(){
    clearTimeout(this._timeout)
  }

  render() {
    return (
      <CSSTransitionGroup
        transitionName={this.props.className}
        transitionEnterTimeout={this.props.enterTimeout}
        transitionLeaveTimeout={this.props.leaveTimeout}
      >
        { this.state.show &&
          <div className={`${this.props.className}-item`}>
            {this.props.children}
          </div>
        }
      </CSSTransitionGroup>
    )

  }
}

Reveal.defaultProps = {
  showAfter: 250,
  enterTimeout: 250,
  leaveTimeout: 300
}

export default Reveal
