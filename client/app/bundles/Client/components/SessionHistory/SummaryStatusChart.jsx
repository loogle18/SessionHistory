import React, { Component, PropTypes } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';

import CustomTooltip from './CustomTooltip';
import CustomizedAxisTick from './CustomizedAxisTick';

class SummaryStatusChart extends Component {
  static propTypes = {
    data: PropTypes.arrayOf(PropTypes.object)
  };

  render() {
    const { data } = this.props;
    return(
      <BarChart
        width={1280}
        height={640}
        data={data}
        margin={{top: 20, right: 120, bottom: 0, left: 0}}
      >
        <XAxis dataKey='date' interval={0} height={80} tick={<CustomizedAxisTick data={data}/>}/>
        <YAxis unit=' builds' width={120}/>
        <CartesianGrid strokeDasharray='3 3'/>
        <Tooltip content={<CustomTooltip/>}/>
        <Legend verticalAlign='top'/>
        <Bar dataKey='passed' name='Passed' stackId='a' fill='#42c88a'/>
        <Bar dataKey='stopped' name='Stopped' stackId='a' fill='#898989'/>
        <Bar dataKey='failed' name='Failed' stackId='a' fill='#dd275a'/>
        <Bar dataKey='error' name='Error' stackId='a' fill='#212121'/>
      </BarChart>
    );
  };
};

export default SummaryStatusChart;
