import React, { Component } from 'react';

import css from './NoMatch.scss';

class NoMatch extends Component {
  render() {
    return(
      <div className={css.wrapper}>
        Requested page not found. Go<a className={css.link} href='/'> home</a>
      </div>
    );
  };
};

export default NoMatch;
