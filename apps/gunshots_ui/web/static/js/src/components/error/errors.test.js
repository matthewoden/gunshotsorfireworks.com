import Error from './index.js'
import React from 'react'
import {shallow} from 'enzyme'

it('displays a message if it contains at least one error.', () => {
  let component =
    shallow(<Error errors={["test"]} showAfter={0} />)

  expect(component.find('.Error-inner').text()).toBe("test")
})
