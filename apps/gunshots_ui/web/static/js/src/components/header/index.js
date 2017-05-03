import React, { Component } from 'react';
import Navigation from '../navigation/'


class Header extends Component {
  render() {
    return (
      <header className="Header">
        <div className="Header-container">
          <Navigation />
        </div>
      </header>
    );
  }
}

export default Header;
