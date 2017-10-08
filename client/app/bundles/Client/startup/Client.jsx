import React from 'react';
import { Router, Route, IndexRoute, browserHistory } from 'react-router';
import injectTapEventPlugin from 'react-tap-event-plugin';

import App from '../components/App';
import NoMatch from '../components/NoMatch';
import SessionHistory from '../components/SessionHistory/index';

injectTapEventPlugin();

const Client = (props, _railsContext) => (
  <Router history={browserHistory}>
    <Route path='/' component={App}>
      <IndexRoute component={SessionHistory} data={props} />
      <Route path='*' component={NoMatch} />
    </Route>
  </Router>
);

export default Client;
