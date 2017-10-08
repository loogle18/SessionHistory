import React, { Component } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';

class SessionHistory extends Component {
  render() {
    return (
      <BarChart width={980} height={640} data={this.props.route.data}>
       <XAxis dataKey='date'/>
       <YAxis/>
       <CartesianGrid strokeDasharray='3 3'/>
       <Tooltip/>
       <Legend />
       <Bar dataKey='passed' stackId='a' fill='#42c88a'/>
       <Bar dataKey='stopped' stackId='a' fill='#898989'/>
       <Bar dataKey='failed' stackId='a' fill='#dd275a'/>
       <Bar dataKey='error' stackId='a' fill='#212121'/>
      </BarChart>
    );
  };
};

export default SessionHistory;
