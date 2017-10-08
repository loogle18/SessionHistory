import React, { Component, PropTypes } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, Brush} from 'recharts';

class SummaryDurationChart extends Component {
  static propTypes = {
    data: PropTypes.arrayOf(PropTypes.object)
  };

  render() {
    return (
      <BarChart width={1200} height={640} data={this.props.data}>
        <XAxis dataKey='date'/>
        <YAxis/>
        <CartesianGrid strokeDasharray='3 3'/>
        <Tooltip/>
        <Legend/>
        <Bar dataKey='duration' name='Summary duration' fill='#27a0b6'/>
        <Brush dataKey='date' height={25} stroke="#27a0b6"/>
      </BarChart>
    );
  };
};

export default SummaryDurationChart;
