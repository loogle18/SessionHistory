import React, { Component, PropTypes } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, Brush } from 'recharts';

class SummaryStatusChart extends Component {
  static propTypes = {
    data: PropTypes.arrayOf(PropTypes.object)
  };

  render() {
    return(
      <BarChart width={1200} height={640} data={this.props.data}>
        <XAxis dataKey='date'/>
        <YAxis/>
        <CartesianGrid strokeDasharray='3 3'/>
        <Tooltip/>
        <Legend/>
        <Bar dataKey='passed' name='Passed' stackId='a' fill='#42c88a'/>
        <Bar dataKey='stopped' name='Stopped' stackId='a' fill='#898989'/>
        <Bar dataKey='failed' name='Failed' stackId='a' fill='#dd275a'/>
        <Bar dataKey='error' name='Error' stackId='a' fill='#212121'/>
        <Brush dataKey='date' height={25} stroke="#898989"/>
      </BarChart>
    );
  };
};

export default SummaryStatusChart;
