import React, { Component } from 'react';

class NoMatch extends Component {
  render() {
    return(
      <div>
        Requested page not found. Go to <a href='/'>home</a>
      </div>
    )
  }
}

export default NoMatch;
