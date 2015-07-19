var GuessList = React.createClass({
  render: function() {
    function iterateData(data) {
      items = [];
      for(var obj in data) {
        items.push(<li>{data[obj]['title']}</li>)
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
  render: function() {
    return (
      <div>
        <h3>Suggestions</h3>
        <form onSubmit={this.handleSubmit} className='col-lg-6'>
          <input onChange={this.onChange} value={this.state.text} />
          <button>{'Suggestions based on ' + (this.state.text)}</button>
        </form>
        <br></br>
        <GuessList guessList={this.state.data} />
      </div>
    );
  }
});
