import React, { Component } from 'react';

class CustomizedAxisTick extends Component {
  propTypes: {
    data: PropTypes.object
  };

  state = {
    isAbnormal: false
  }

  componentWillMount() {
    const { data, payload } = this.props;

    if(!data || !data.length) return

    const dataObject = data.filter(element => element.date === payload.value)[0];

    if(dataObject && dataObject.is_abnormal) this.setState({ isAbnormal: dataObject.is_abnormal })
  }

  render() {
    const { x, y, stroke, payload } = this.props,
          fillColor = this.state.isAbnormal ? '#dd275a' : '#666666'

    return (
      <g transform={`translate(${x},${y})`}>
        <text x={0} y={0} dy={16} textAnchor='end' fill={fillColor} transform='rotate(-35)'>
          {payload.value}
        </text>
      </g>
    );
  };
};

export default CustomizedAxisTick;
