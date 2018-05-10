import React, { Component } from 'react';
import {
  View,
  TabBarIOS,
  Alert,
  Vibration,
  StatusBar,
  Text
} from 'react-native';
import NewsFeedContainer from '../containers/NewsFeedContainer';
import Search from './Search';
import SmallText from './SmallText';
import * as globalStyles from '../styles/global';

StatusBar.setBarStyle('light-content');

export default class HomeScreen extends Component {

  constructor(props) {
    super(props);
    this.state = {
      tab: 'newsFeed'
    };
  }

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
    return (
      <TabBarIOS
        barTintColor={globalStyles.BAR_COLOR}
        tintColor={globalStyles.LINK_COLOR}
        translucent={false}
      >
        <TabBarIOS.Item
          badge={4}
          systemIcon={'featured'}
          selected={this.state.tab === 'newsFeed'}
          onPress={() => this.setState({ tab: 'newsFeed' })}
        >
          <NewsFeedContainer />
        </TabBarIOS.Item>
        <TabBarIOS.Item
          systemIcon={'search'}
          selected={this.state.tab === 'search'}
          onPress={() => this.setState({ tab: 'search' })}
        >
          <Search />
        </TabBarIOS.Item>
        <TabBarIOS.Item
          systemIcon={'bookmarks'}
          selected={this.state.tab === 'bookmarks'}
          onPress={() => this.showBookmarkAlert()}
        >
          <Text>Bookmarks</Text>
        </TabBarIOS.Item>
      </TabBarIOS>
    );
  }
}
