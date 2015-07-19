var GuessListItem = React.createClass({
  quickSuggestion: function(e) {
    console.log(this.props.movieData);
    var rtId = this.props.movieData['rotten_tomatoes_id'];
    var imdbId = this.props.movieData['imdb_id'];

    if (rtId !== null) {
      $.get("http://api.rottentomatoes.com/api/public/v1.0/movies/" + rtId + ".json?apikey=")
    } else if (imdbId !== null) {

    } else {
      console.log("lame. nothing to work with");
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
    function iterateData(data) {
      items = [];
      for(var index in data) {
        items.push(<GuessListItem movieData={data[index]} />);
      }
    }
    iterateData(this.props.guessList);
    return <ul className='guess-list'>{items}</ul>;
  }
});

var SuggestionBox = React.createClass({
  getInitialState: function() {
    return {results: [], text: '', data: {}};
  },
  onChange: function(e) {
    var txt = e.target.value
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
          <GuessList guessList={this.state.data} />
        </div>
        <div className="col-lg-6"></div>
      </div>
    );
  }
});
