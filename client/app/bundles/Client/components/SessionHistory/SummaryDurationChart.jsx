import React, { Component, PropTypes } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';

class SummaryDurationChart extends Component {
  static propTypes = {
    data: PropTypes.arrayOf(PropTypes.object)
  };

  render() {
    return (
      <div>
        <BarChart width={980} height={640} data={this.props.data}>
          <XAxis dataKey='date' />
          <YAxis />
          <CartesianGrid strokeDasharray='3 3' />
          <Tooltip />
          <Legend />
          <Bar dataKey='duration' name='Summary duration' fill='#27a0b6' />
        </BarChart>
      </div>
    );
  };
};

export default SummaryDurationChart;
