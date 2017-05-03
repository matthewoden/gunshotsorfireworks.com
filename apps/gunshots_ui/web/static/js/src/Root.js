import React, {Component} from 'react'
import {
  BrowserRouter as Router,
  Route,
  Switch
} from 'react-router-dom'


import Home from './views/home/'
import About from './views/about/'
import Map from './views/map/'
import Header from './components/header/'
import Footer from './components/footer/'

class Root extends Component {
  render () {
    return (
      <Router>
        <div className="App">
          <div className="mobile-only">
            <Header/>
          </div>
          <div className="Main">
            <Switch>
              <Route exact path ="/" component={Home} />
              <Route path="/map" component={Map} />
              <Route path="/about" component={About} />
            </Switch>
          </div>
          <div className="desktop-only">
            <Header/>
          </div>
        </div>
      </Router>
    )
  }
}


export default Root
