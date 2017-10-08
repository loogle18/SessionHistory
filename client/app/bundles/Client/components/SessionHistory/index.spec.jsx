import React from 'react';
import { assert } from 'chai';
import { shallow } from 'enzyme';

import SessionHistory from './index';

describe('SessionHistory', () => {
  const NO_DATA_TEXT = 'There is no data yet for to show charts. Please try again later.'

  it('renders SummaryStatusChart and SummaryDurationChart if data exist', () => {
    const props = {
      route: {
        data: [
          {
            date: '11.08.14',
            duration: 1023,
            error: 0,
            failed: 0,
            passed: 2,
            stopped: 0
          }
        ]
      }
    };
    const sessionHistory = shallow(<SessionHistory {...props} />);

    assert(sessionHistory.find('SummaryStatusChart').length);
    assert(sessionHistory.find('SummaryDurationChart').length);
    assert.notInclude(sessionHistory.text(), NO_DATA_TEXT);

    assert.deepEqual(sessionHistory.find('SummaryStatusChart').prop('data'), props.route.data)
    assert.deepEqual(sessionHistory.find('SummaryDurationChart').prop('data'), props.route.data)
  });

  it('renders no data text if data is absent', () => {
    const props = { route: {} };
    const sessionHistory = shallow(<SessionHistory {...props} />);

    assert(!sessionHistory.find('SummaryStatusChart').length);
    assert(!sessionHistory.find('SummaryDurationChart').length);

    assert.include(sessionHistory.text(), NO_DATA_TEXT);
  });

  it('renders no data text if data exist, but empty', () => {
    const props = { route: { data: [] } };
    const sessionHistory = shallow(<SessionHistory {...props} />);

    assert(!sessionHistory.find('SummaryStatusChart').length);
    assert(!sessionHistory.find('SummaryDurationChart').length);

    assert.include(sessionHistory.text(), NO_DATA_TEXT);
  });
});
