import React from 'react';
import { assert } from 'chai';
import { shallow } from 'enzyme';

import CustomTooltip from './CustomTooltip';

describe('CustomTooltip', () => {
  let props

  beforeEach(() => {
    props = getDefaultProps()
  });

  it('does not render anything if active props is false', () => {
    props.active = false
    const customTooltip = shallow(<CustomTooltip {...props}/>)

    assert(!customTooltip.find('div').length)
    assert(!customTooltip.find('p').length)
  });

  it('renders data value with text for each build type', () => {
    const customTooltip = shallow(<CustomTooltip {...props}/>)

    assert.equal(customTooltip.find('p').length, 5)

    assert.notInclude(customTooltip.text(), 'Has abnormal failed builds.')
    assert.include(customTooltip.text(), '12.08.14')
    assert.include(customTooltip.text(), 'Passed: 3')
    assert.include(customTooltip.text(), 'Stopped: 1')
    assert.include(customTooltip.text(), 'Failed: 1')
    assert.include(customTooltip.text(), 'Error: 0')
  });

  it('renders date value with mention about abnormal builds if is_abnormal value is true', () => {
    props.payload[0].payload.is_abnormal = true
    const customTooltip = shallow(<CustomTooltip {...props}/>)

    assert.include(customTooltip.text(), '12.08.14 Has abnormal failed builds.')
  });

  const getDefaultProps = () => {
    return {
      active: true,
      label: '12.08.14',
      payload: [
        {
          value: 3,
          name: 'Passed',
          payload: {
            date: '12.08.14',
            error: 0,
            failed: 1,
            is_abnormal: false,
            passed: 3,
            stopped: 1
          }
        },
        {
          value: 1,
          name: 'Stopped',
          payload: {
            date: '12.08.14',
            error: 0,
            failed: 1,
            is_abnormal: false,
            passed: 3,
            stopped: 1
          }
        },
        {
          value: 1,
          name: 'Failed',
          payload: {
            date: '12.08.14',
            error: 0,
            failed: 1,
            is_abnormal: false,
            passed: 3,
            stopped: 1
          }
        },
        {
          value: 0,
          name: 'Error',
          payload: {
            date: '12.08.14',
            error: 0,
            failed: 1,
            is_abnormal: false,
            passed: 3,
            stopped: 1
          }
        }
      ]
    }
  }
});
