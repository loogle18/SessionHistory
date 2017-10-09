import React from 'react';
import { assert } from 'chai';
import { shallow } from 'enzyme';

import CustomizedAxisTick from './CustomizedAxisTick';

describe('CustomizedAxisTick', () => {
  let props

  beforeEach(() => {
    props = {
      x: 10,
      y: 20,
      data: [
        { date: '11.08.14', passed: 2, stopped: 0, failed: 0, error: 0, is_abnormal: false }
      ],
      payload: { value: '19.10.14' }
    }
  });

  it('renders needed elements with props', () => {
    const customizedAxisTick = shallow(<CustomizedAxisTick {...props}/>)

    assert.equal(customizedAxisTick.find('g').prop('transform'), `translate(${props.x},${props.y})`)
    assert.equal(customizedAxisTick.find('text').text(), props.payload.value)
  });

  it('renders text with red color if isAbnormal state equal to true', () => {
    const customizedAxisTick = shallow(<CustomizedAxisTick {...props}/>)

    assert.equal(customizedAxisTick.find('text').prop('fill'), '#666666')

    customizedAxisTick.setState({ isAbnormal: true })

    assert.equal(customizedAxisTick.find('text').prop('fill'), '#dd275a')
  });

  it('does not set new value for isAbnormal state if data is absent', () => {
    props.data = undefined
    const customizedAxisTick = shallow(<CustomizedAxisTick {...props}/>)

    assert.equal(customizedAxisTick.state('isAbnormal'), false)
  });

  it('does not set new value for isAbnormal state if data is empty', () => {
    props.data = []
    const customizedAxisTick = shallow(<CustomizedAxisTick {...props}/>)

    assert.equal(customizedAxisTick.state('isAbnormal'), false)
  });

  it('does not set new value for isAbnormal state if no data with needed value', () => {
    props.payload.value = '01.01.27'
    const customizedAxisTick = shallow(<CustomizedAxisTick {...props}/>)

    assert.equal(customizedAxisTick.state('isAbnormal'), false)
  });

  it('does not set new value for isAbnormal state if is_abnormal of filtered object is false', () => {
    props.data.push({ date: props.payload.value, passed: 2, stopped: 0, failed: 0, error: 0, is_abnormal: false })
    const customizedAxisTick = shallow(<CustomizedAxisTick {...props}/>)

    assert.equal(customizedAxisTick.state('isAbnormal'), false)
  });

  it('sets isAbnormal state to true if is_abnormal of filtered object is true', () => {
    props.data.push({ date: props.payload.value, passed: 2, stopped: 0, failed: 0, error: 0, is_abnormal: true })
    const customizedAxisTick = shallow(<CustomizedAxisTick {...props}/>)

    assert.equal(customizedAxisTick.state('isAbnormal'), true)
  });
});
