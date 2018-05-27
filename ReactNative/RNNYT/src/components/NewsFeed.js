import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {
  ListView,
  WebView,
  StyleSheet,
  View,
  Modal,
  TouchableOpacity,
  RefreshControl,
  ActivityIndicator,
  NetInfo,
  Linking
} from 'react-native';
import NewsItem from './NewsItem';
import SmallText from './SmallText';
import AppText from './AppText';
import * as globalStyles from '../styles/global';

export default class NewsFeed extends Component {

  constructor(props) {
    super(props);
    const ds = new ListView.DataSource({
      rowHasChanged: (row1, row2) => row1.title !== row2.title
    });
    this.state = {
      dataSource: ds.cloneWithRows(props.news),
      initialLoading: true,
      refreshing: false,
      connected: true
    };
    this.renderRow = this.renderRow.bind(this);
    this.refresh = this.refresh.bind(this);
    this.handleConnectivityChange = this.handleConnectivityChange.bind(this);
  }

  componentWillMount() {
    NetInfo.isConnected.addEventListener('change', this.handleConnectivityChange);
    this.refresh();
  }

  componentWillUnmount() {
    NetInfo.isConnected.removeEventListener('change', this.handleConnectivityChange);
  }

  componentWillReceiveProps(nextProps) {
    this.setState({
      dataSource: this.state.dataSource.cloneWithRows(nextProps.news),
      initialLoading: false
    });
  }

  refresh() {
    if (this.props.loadNews) {
      this.props.loadNews();
    }
  }

  renderModal(rowData, ...rest) {
    const index = parseInt(rest[1], 10)
    return (
      <Modal
        animationType="slide"
        visible={this.props.modal !== undefined}
        onRequestClose={this.props.onModalClose}
      >
        <View style={styles.modalContent}>
          <View style={styles.modalButtons}>
            <TouchableOpacity
              onPress={this.props.onModalClose}
            >
              <SmallText>Close</SmallText>
            </TouchableOpacity>
            <TouchableOpacity
              onPress={() => Linking.openURL(this.props.modal)}
            >
              <SmallText>Open in Browser</SmallText>
            </TouchableOpacity>
          </View>
          <WebView
            scalesPageToFit
            source={{ uri: this.props.modal }}
          />
        </View>
      </Modal>
    );
  }

  renderRow(rowData, sectionID, rowID, highlightRow) {
    const index = parseInt(rowID, 10);
    return (
      <NewsItem
        onPress={() => this.props.onModalOpen(rowData.url)}
        style={styles.newsItem}
        index={index}
        {...rowData}
      />
    );
  }

  render() {
    const {
      listStyles = globalStyles.COMMON_STYLES.pageContainer,
      showLoadingSpinner
    } = this.props;
    const { initialLoading, refreshing, dataSource } = this.state;
    if (!this.state.connected) {
      return (
        <View style={[globalStyles.COMMON_STYLES.pageContainer, styles.loadingContainer]}>
          <AppText>
            No Connection
          </AppText>
        </View>
      );
    }
    return (
      (initialLoading && showLoadingSpinner
        ? (
          <View style={[listStyles, styles.loadingContainer]}>
            <ActivityIndicator
              animating
              size="small"
              {...this.props}
            />
          </View>
        ) : (
          <View style={styles.container}>
            <ListView
              refreshControl={
                <RefreshControl
                  refreshing={refreshing}
                  onRefresh={this.refresh}
                />
              }
              enableEmptySections
              dataSource={dataSource}
              renderRow={this.renderRow}
              style={listStyles}
            />
            {this.renderModal()}
          </View>
        )
      )
    );
  }

  handleConnectivityChange(isConnected) {
    this.setState({
      connected: isConnected
    });
    if (isConnected) {
      this.refresh();
    }
  }
}

NewsFeed.propTypes = {
  news: PropTypes.arrayOf(PropTypes.object),
  listStyles: View.propTypes.style,
  loadNews: PropTypes.func,
  showLoadingSpinner: PropTypes.bool,
  modal: PropTypes.string,
  onModalOpen: PropTypes.func.isRequired,
  onModalClose: PropTypes.func.isRequired
};

NewsFeed.defaultProps = {
  showLoadingSpinner: true
};

const styles = StyleSheet.create({
  newsItem: {
    marginBottom: 20
  },
  container: {
    flex: 1
  },
  loadingContainer: {
    alignItems: 'center',
    justifyContent: 'center'
  },
  modalContent: {
    flex: 1,
    justifyContent: 'center',
    paddingTop: 20,
    backgroundColor: globalStyles.BG_COLOR
  },
  closeButton: {
    paddingVertical: 5,
    paddingHorizontal: 10,
    flexDirection: 'row'
  },
  modalButtons: {
    paddingVertical: 5,
    paddingHorizontal: 10,
    flexDirection: 'row',
    justifyContent: 'space-between'
  }
});
