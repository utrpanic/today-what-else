import React, { Component } from 'react';
import { 
    AppRegistry,
    StyleSheet,
    Text,
    View,
    TouchableOpacity
} from 'react-native';

import { Provider, connect } from 'react-redux';

import store from './src/store';
import Counter from './src/Counter';
import * as actions from './src/actions';

const mapStateToProps = state => ({
    count: state.count
});

const CounterContainer = connect(
    mapStateToProps,
    actions
)(Counter);

class Countly extends Component {

    render() {
        return (
            <Provider store={store}>
                <CounterContainer />
            </Provider>
        );
    }
}

AppRegistry.registerComponent('Countly', () => Countly);
