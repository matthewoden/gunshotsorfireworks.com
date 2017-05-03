import React from 'react';
import ReactDOM from 'react-dom';
import Root from './Root'
import {Provider} from 'react-redux'
import store from './redux/store'

ReactDOM.render(
  <Provider store={store} >
    <Root />
  </Provider>,
  document.getElementById('root')
);
