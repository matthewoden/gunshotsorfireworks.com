import React, { Component } from 'react';
import {Link} from 'react-router-dom'


// menu is closed, display list.
const MenuIsClosed = () =>
  (<svg className="Navigation-menu-icon" viewBox="0 0 24 24">
    <path d="M19,6.41L17.59,5L12,10.59L6.41,5L5,6.41L10.59,12L5,17.59L6.41,19L12,13.41L17.59,19L19,17.59L13.41,12L19,6.41Z" />
  </svg>)

const MenuIsOpen = () =>
  (<svg className="Navigation-menu-icon" viewBox="0 0 24 24" >
    <path d="M3,6H21V8H3V6M3,11H21V13H3V11M3,16H21V18H3V16Z" />
  </svg>)

const MenuIcon = (props) =>
  props.open ? <MenuIsClosed/> : <MenuIsOpen/>


class Navigation extends Component {
  constructor(props) {
    super(props)
    this.state = {show: false}
    this.toggleMenu = this.toggleMenu.bind(this)
  }

  toggleMenu() {
    this.setState({show: !this.state.show})
  }

  render() {
    const menuToggleClasses =
      this.state.show ? "Navigation-menu-show" : ''

    return (
      <nav className="Navigation">
        <div className="Navigation-menu-header">
          <div className="Navigation-menu-button" onClick={this.toggleMenu}>
            <MenuIcon open={this.state.show }/>
          </div>
          <Link to="/" className="Navigation-brand" onClick={()=>this.setState({show: false})}>
            Gunshots or Fireworks?
          </Link>
        </div>
        <div className={`Navigation-menu ${menuToggleClasses}`}>
          <Link to="/map" className="Navigation-item" onClick={this.toggleMenu}>
            Map
          </Link>
          <Link to="/about" className="Navigation-item" onClick={this.toggleMenu}>
            About
          </Link>
          <a href="https://twitter.com/matthewoden" target="_blank" onClick={this.toggleMenu} className="Navigation-item">
            <svg className="Navigation-twitter-icon desktop-only" viewBox="0 0 24 24">
              <path d="M17.71,9.33C18.19,8.93 18.75,8.45 19,7.92C18.59,8.13 18.1,8.26 17.56,8.33C18.06,7.97 18.47,7.5 18.68,6.86C18.16,7.14 17.63,7.38 16.97,7.5C15.42,5.63 11.71,7.15 12.37,9.95C9.76,9.79 8.17,8.61 6.85,7.16C6.1,8.38 6.75,10.23 7.64,10.74C7.18,10.71 6.83,10.57 6.5,10.41C6.54,11.95 7.39,12.69 8.58,13.09C8.22,13.16 7.82,13.18 7.44,13.12C7.81,14.19 8.58,14.86 9.9,15C9,15.76 7.34,16.29 6,16.08C7.15,16.81 8.46,17.39 10.28,17.31C14.69,17.11 17.64,13.95 17.71,9.33M12,2A10,10 0 0,1 22,12A10,10 0 0,1 12,22A10,10 0 0,1 2,12A10,10 0 0,1 12,2Z" />
            </svg>
            <span className="mobile-only">@MatthewOden</span>
          </a>
        </div>
      </nav>
    );
  }
}

export default Navigation;
