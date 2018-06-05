import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {
  View,
  TabBarIOS,
  Alert,
  Vibration,
  StatusBar,
  Text
} from 'react-native';
import NewsFeedContainer from '../containers/NewsFeedContainer';
import SearchContainer from '../containers/SearchContainer';
import BookmarkContainer from '../containers/BookmarkContainer';
import SmallText from './SmallText';
import * as globalStyles from '../styles/global';

StatusBar.setBarStyle('light-content');

export default class HomeScreen extends Component {

  showBookmarkAlert() {
    Vibration.vibrate();
    Alert.alert(
      'coming Soon!',
      'We\'re hard at work on this feature, check back in the near future.',
      [
        { text: 'OK', onPress: () => console.log('User pressed OK') }
      ]
    );
  }

  render() {
    const { selectedTab, tab } = this.props;
    return (
      <TabBarIOS
        barTintColor={globalStyles.BAR_COLOR}
        tintColor={globalStyles.LINK_COLOR}
        translucent={false}
      >
        <TabBarIOS.Item
          badge={4}
          systemIcon={'featured'}
          selected={selectedTab === 'newsFeed'}
          onPress={() => tab('newsFeed')}
        >
          <NewsFeedContainer />
        </TabBarIOS.Item>
        <TabBarIOS.Item
          systemIcon={'search'}
          selected={selectedTab === 'search'}
          onPress={() => tab('search')}
        >
          <SearchContainer />
        </TabBarIOS.Item>
        <TabBarIOS.Item
          systemIcon={'bookmarks'}
          selected={selectedTab === 'bookmarks'}
          onPress={() => tab('bookmarks')}
        >
          <BookmarkContainer />
        </TabBarIOS.Item>
      </TabBarIOS>
    );
  }
}

HomeScreen.propTypes = {
  selectedTab: PropTypes.string,
  tab: PropTypes.func.isRequired
};
