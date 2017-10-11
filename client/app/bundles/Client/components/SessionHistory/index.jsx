import React, { Component } from 'react';

import SummaryStatusChart from './SummaryStatusChart';
import SummaryDurationChart from './SummaryDurationChart';

import css from './index.scss';

class SessionHistory extends Component {
  renderNoDataText() {
    return(
      <div className={css.noDataText}>
        There is no data yet for to show charts. Please try again later.
      </div>
    );
  };

  render() {
    const { data } = this.props.route;

    if(!data || !data.length) return this.renderNoDataText();

    return(
      <div>
        <SummaryStatusChart data={data}/>
        <div className={css.abnormalBuildsDescription}>
          Day has abnormal status if failed builds count in that day more or equal to average value plus
          <a className={css.link} href='https://en.wikipedia.org/wiki/Standard_deviation'> standard deviation </a>
          times two.
          <p>
            Date in the chart above that has abnormal failed builds are filled in
            <span style={{color: '#dd275a'}}> red </span>
            color.
          </p>
        </div>
        <SummaryDurationChart data={data}/>
      </div>
    );
  };
};

export default SessionHistory;
