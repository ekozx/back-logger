var SuggestionListItem = React.createClass({
  quickAdd: function(e) {
    console.log(e);
  },
  render: function() {
    console.log(this.props.suggestionData);
    return (
      <li className="new_well">
        <a href='#'>
          <img src={this.props.suggestionData['posters']['thumbnail']} className='img-circle' />
        </a>
        <span>{this.props.suggestionData['title']}</span>
        <button className="btn btn-success" onClick={this.quickAdd}>Add</button>
      </li>
    );
  }
});

var SuggestionList = React.createClass({
  render: function() {
    var suggestionList = [];
    function iterateSuggestions(suggestions) {
      for(var suggestionIndex in suggestions) {
        suggestionList.push(<SuggestionListItem suggestionData={suggestions[suggestionIndex]} />)
      }
    }
    iterateSuggestions(this.props.suggestionList);
    return <ul className='suggestion-list'>{suggestionList}</ul>;
  }
});

var GuessListItem = React.createClass({
  toggleGif: function() {
    $('.loading-entries-2').hide();
    $('.suggestion-list').show();
  },
  quickSuggestion: function(e) {
    $('.loading-entries-2').show();
    $('.suggestion-list').hide();
    var rtId = this.props.movieData['rotten_tomatoes_id'];
    var imdbId = this.props.movieData['imdb_id'];
    if (rtId === undefined) {rtId = this.props.movieData['id']}
    if (rtId !== null) {
      $.get('/rt_suggestion/rt/' + rtId, function(data) {
        this.props.suggest(data["movies"]);
        this.toggleGif();
      }.bind(this));
    } else if (imdbId !== null) {
      $.get('/rt_suggestion/imdb/' + imdbId, function(data) {
        this.props.suggest(data["movies"]);
        this.toggleGif();
      }.bind(this));
    }
  },
  render: function() {
    var thumbnailSrc = this.props.movieData['thumbnail_file_name'];
    if (!thumbnailSrc) {thumbnailSrc = this.props.movieData['posters']['thumbnail']}
    // thumbnailSrc === undefined ? thumbnailSrc = this.props.movieData['posters']['thumbnail'] : thumbnailSrc = "#";
    return (
      <li className="new_well">
        <a href='#'>
          <img src={thumbnailSrc} className='img-circle' />
        </a>
        <a href='#' onClick={this.quickSuggestion}>{this.props.movieData['title']}</a>
      </li>
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
    iterateData(this.props.guessList, this.props.suggest);
    return <ul className='guess-list'>{items}</ul>;
  }
});

var SuggestionBox = React.createClass({
  // Endpoint: search/:type/:query/:t
  queryRottenTomatoes: function(query) {
    var url = ('rt_react_search/' + query)

    $.get(url, function(data) {
      $('.loading-entries').hide();
      $('.guess-list').show();
      this.setState({data: data["movies"]});
    }.bind(this));
  },
  componentDidMount: function () {
    window.addEventListener('keydown', this.handleKeyDown);
  },
  componentWillUnmount: function () {
    window.removeEventListener('keydown', this.handleKeyDown);
  },
  handleKeyDown: function(e) {
    if(e.keyCode == 13) {
      e.preventDefault();
      $('.guess-list').hide();
      $('.loading-entries').show();
      this.queryRottenTomatoes(this.state.text);
    }
  },
  getInitialState: function() {
    return{text: '', data: {}, suggestions: []};
  },
  suggestionFunc: function(suggstionList) {
    this.setState({suggestions: suggstionList});
  },
  onChange: function(e) {
    var txt = e.target.value;
    e.preventDefault();
    url = "/search/entries/" + txt  + "/no";
    if (url === '/search/entries//no') {
      this.setState({data: {}, text: txt});
    }
    $.get(url, function(data){
      this.setState({data: data, text: txt});
    }.bind(this));
  },
  render: function() {
    return (
      <div>
        <div className="col-lg-6">
          <form className='static_well'>
            <h3>Suggestions</h3>
            <input onChange={this.onChange} value={this.state.text} />
          </form>
          <div className="" >
            <GuessList guessList={this.state.data} suggest={this.suggestionFunc} />
            <div className='loading-entries'>
              <img src={'/assets/loading1.gif'}></img>
            </div>
          </div>
        </div>
        <div className="col-lg-6">
          <SuggestionList suggestionList={this.state.suggestions} />
          <div className='loading-entries-2'>
            <img src={'/assets/loading1.gif'}></img>
          </div>
        </div>
      </div>
    );
  }
});
