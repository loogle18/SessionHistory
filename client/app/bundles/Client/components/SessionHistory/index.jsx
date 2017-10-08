import React, { Component } from 'react';
import SummaryStatusChart from './SummaryStatusChart';
import SummaryDurationChart from './SummaryDurationChart';

class SessionHistory extends Component {
  render() {
    const { data } = this.props.route;

    return (
      <div>
        <SummaryStatusChart data={data}/>
        <SummaryDurationChart data={data}/>
      </div>
    );
  };
};

export default SessionHistory;
