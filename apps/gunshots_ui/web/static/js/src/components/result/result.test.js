import React from 'react'
import {shallow,mount} from 'enzyme'
import {Result} from './index.js'



let defaultProps = {
  gunshots: [],
  fireworks: [],
  records: [],
  isValid: true,
  revealResultAfter: 0,
  revealMaybeAfter: 0,
  revealDetailsAfter: 0,
  dispatch: () => true
}

let component;

const install = (props) => {
  const finalProps = {
    ...defaultProps,
    ...props
  }
  return component = shallow(<Result {...finalProps} />)
}

const waitForTimeout = (time = 0) =>
  new Promise((resolve) => setTimeout(resolve, 0))



it("displays gunshots when there are gunshot records",  () => {
  install({ gunshots: [{id: 'P90X'}] })
  expect(component.find('.Result-title').text()).toBe("GUNSHOTS!")
})

it("displays fireworks when there are fireworks records", () => {
  install({ fireworks: [{id: 'P90X'}] })
  expect(component.find('.Result-title').text()).toBe("FIREWORKS!")
})

it("displays fireworks when there are no gunshot records", () => {
  install({ gunshots: [] })
  expect(component.find('.Result-title').text()).toBe("FIREWORKS!")
})


it("displays fireworks when the user is out of bounds", () => {
  install({ isValid: false })
  expect(component.find('.Result-title').text()).toBe("FIREWORKS!")
})
