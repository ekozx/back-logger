var SuggestionList = React.createClass({
  render: function() {
    var suggestions = [];
    function iterateSuggestions(suggestions) {

    }
    iterateSuggestions(this.props.suggestionList);
    return <ul className='suggestion-list'>{suggestions}</ul>;
  }
});

var GuessListItem = React.createClass({
  quickSuggestion: function(e) {
    var rtId = this.props.movieData['rotten_tomatoes_id'];
    var imdbId = this.props.movieData['imdb_id'];
    if (rtId !== null) {
      $.get('/rt_suggestion/rt/' + rtId, function(data) {
        console.log(data);
        // this.setState({suggestions: ['my', 'rt', 'suggestions']});
        this.props.suggest(['my', 'rt', 'suggestions']);
      }.bind(this));
    } else if (imdbId !== null) {
      $.get('/rt_suggestion/imdb/' + imdbId, function(data) {
        console.log(data);
        // this.setState({suggestions: ['my', 'rt', 'suggestions']});
        this.props.suggest(['my', 'rt', 'suggestions']);
      }.bind(this));
    } else {
      console.log("nada");
    }
  },
  render: function() {
    return (
      <li><a href='#' onClick={this.quickSuggestion}>
      {this.props.movieData['title']}
      </a></li>
    );
  }
});

var GuessList = React.createClass({
  render: function() {
    function iterateData(data, suggestFunction) {
      items = [];
      for(var index in data) {
        items.push(<GuessListItem movieData={data[index]} suggest={suggestFunction}/>);
      }
    }
    // this.setState(suggestions:)
    iterateData(this.props.guessList, this.props.suggest);
    return <ul className='guess-list'>{items}</ul>;
  }
});

var SuggestionBox = React.createClass({
  getInitialState: function() {
    return{text: '', data: {}, suggestions: []};
  },
  suggestionFunc: function(suggstionList) {
    console.log("suggestions!");
    this.setState({suggestions: suggstionList});
  },
  onChange: function(e) {
    var txt = e.target.value;
    url = "/search/entries/" + txt  + "/no";
    if (url === '/search/entries//no') {
      this.setState({data: {}, text: txt});
    }
    $.get(url, function(data){
      this.setState({data: data, text: txt});
    }.bind(this));
  },
  handleSubmit: function(e) {
    e.preventDefault();
  },
  suggestionClick: function(e) {
    console.log(e);
  },
  render: function() {
    console.log(this.state);
    return (
      <div>
        <div className="col-lg-6" >
          <h3>Suggestions</h3>
          <form onSubmit={this.handleSubmit} className=''>
            <input onChange={this.onChange} value={this.state.text} />
            <button className="btn-suggest" onClick={this.suggestionClick}>
              {'Suggestions based on ' + (this.state.text)}
            </button>
          </form>
          <br></br>
          <GuessList guessList={this.state.data} suggest={this.suggestionFunc} />
        </div>
        <div className="col-lg-6">
          <SuggestionList suggestionList={this.state.suggestions} />
        </div>
      </div>
    );
  }
});
