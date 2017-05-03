import React from 'react'
import Navigation from './index'
import {shallow, mount} from 'enzyme'


it('toggles state display om click', () => {
  let component = shallow(<Navigation/>)
  component.find('.Navigation-menu-button').simulate('click')
  expect(component.state('show')).toBe(true)
})
