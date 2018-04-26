import React, { PropTypes, Component } from 'react';
import {
  ListView,
  StyleSheet,
  View
} from 'react-native';
import * as globalStyles from '../styles/global';

export default class NewsFeed extends Component {

  constructor(props) {
    super(props)
    this.ds = new ListView.DataSource({
      rowChanged: (row1, row2) => row1.title !== row2.title
    });
    this.state = {
      dataSource: this.ds.cloneWithRows(props.news)
    };
  }

  renderRow(rowData, ...rest) {
    const index = parseInt(rest[1], 10);
    return (
      <NewsItem
        style={styles.newsItem}
        index={index}
        {...rowData}
      />
    );
  }

  render() {
    return (
      <View style={globalStyles.COMMON_STYLES.pageContainer}>
        <ListView
          enableEmptySections
          dataSource={this.state.dataSource}
          renderRow={this.renderRow}
          style={this.props.listStyle}
        />
      </View>
    );
  }
}

NewsFeed.propType = {
  news: PropTypes.arrayOf(PropTypes.object),
  listStyle: View.propTypes.style
}

NewsFeed.defaultProps = {
  news: [
    {
      title: 'React Native',
      imageUrl: 'https://facebook.github.io/react/image/logo_og.png',
      description: 'Build Native Mobile Apps using JavaScript and React',
      date: new Date(),
      author: 'Facebook',
      location: 'Menlo Park, California',
      url: 'https://facebook.github.io/react-native'
    },
    {
      title: 'Packt Publishing',
      imageUrl: 'https://www.packtpub.com/sites/default/files/packt_logo.png',
      description: 'Stay Relevant',
      date: new Date(),
      author: 'Packt Publishing',
      location: 'Birmingham, UK',
      url: 'https://www.packtpub.com/'
    },
  ]
};

const styles = StyleSheet.create({
  newsItem: {
    marginBottom: 20
  }
});
