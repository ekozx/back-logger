var SuggestionList = React.createClass({
  render: function() {
    var createItem = function(itemText, index) {
      console.log("ItemText:");
      console.log(itemText);
      console.log("Index:");
      console.log(index);
      return <li key={index + itemText}>{itemText}</li>;
    };
    return <ul className='col-lg-6'>{this.props.results.map(createItem)}</ul>;
  }
});
var SuggestionBox = React.createClass({
  getInitialState: function() {
    return {guesses: [], results: [], text: ''};
  },
  onChange: function(e) {
    url = "/search/entries/" + e.target.value + "/no";
    $.get(url, function(data) {
      console.log(data)
      var dbResults = [];
      for(var value in data) {
        if (value["thumbnail_file_name"] == null) {
          data["thumbnail_file_name"] = "";
        }
        if (value != null) {
          dbResults.push(value);
        }
      }
      this.setState({guesses: dbResults, text: e.target.value})
    });
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
        <SuggestionList results={this.state.results} />
      </div>
    );
  }
});
