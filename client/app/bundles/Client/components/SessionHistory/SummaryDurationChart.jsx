import React, { Component, PropTypes } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, Brush } from 'recharts';

import CustomizedAxisTick from './CustomizedAxisTick';

class SummaryDurationChart extends Component {
  static propTypes = {
    data: PropTypes.arrayOf(PropTypes.object)
  };

  render() {
    return(
      <LineChart
        width={1280}
        height={640}
        data={this.props.data}
        margin={{top: 20, right: 120, bottom: 20, left: 0}}
      >
        <XAxis dataKey='date' interval={0} height={80} tick={<CustomizedAxisTick/>}/>
        <YAxis unit=' seconds' width={120}/>
        <CartesianGrid strokeDasharray='3 3'/>
        <Tooltip/>
        <Legend verticalAlign='top'/>
        <Line dataKey='duration' name='Summary duration' type='monotone' fill='#27a0b6'/>
        <Brush dataKey='date' height={25} stroke='#27a0b6'/>
      </LineChart>
    );
  };
};

export default SummaryDurationChart;
