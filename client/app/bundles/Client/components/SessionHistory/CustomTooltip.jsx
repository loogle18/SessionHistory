import React, { Component, PropTypes } from 'react';

import css from './index.scss';

class CustomTooltip extends Component {
  propTypes: {
    active: PropTypes.bool,
    payload: PropTypes.array,
    label: PropTypes.string,
  };

  render() {
    const { active, payload, label } = this.props;

    if(!active) return null

    const dataText = payload[0].payload.is_abnormal ? label + ' - Has abnormal failed builds.' : label

    return (
      <div className={css.customTooltip}>
        <p >{dataText}</p>
        <p className={css.labelPassed}>{`${payload[0].name}: ${payload[0].value}`}</p>
        <p className={css.labelStopped}>{`${payload[1].name}: ${payload[1].value}`}</p>
        <p className={css.labelFailed}>{`${payload[2].name}: ${payload[2].value}`}</p>
        <p className={css.labelError}>{`${payload[3].name}: ${payload[3].value}`}</p>
      </div>
    );
  };
};

export default CustomTooltip;
