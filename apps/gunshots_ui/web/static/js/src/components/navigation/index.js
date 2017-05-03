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
            Contact
          </a>
          <a href="https://github.com/matthewoden" target="_blank" onClick={this.toggleMenu} className="Navigation-item">
            Source
          </a>
        </div>
      </nav>
    );
  }
}

export default Navigation;
