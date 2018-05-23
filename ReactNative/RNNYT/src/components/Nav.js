import React, { Component } from 'react';
import { TouchableOpacity, StyleSheet } from 'react-native';
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import {
    StyleSheet,
    NavigationExperimental
} from 'react-native';

import * as globalStyles from '../styles/global';

const { Header, CardStack } = NavigationExperimental;

export default class Nav extends Component {

    constructor(props, context) {
        super(props, context);
        this.renderScene = this.renderScene.bind(this);
        this.renderNavigationBar = this.renderNavigationBar.bind(this);
    }

    renderScene(sceneProps) {
        const route = sceneProps.scene.route;
        return (
            <route.component
                {...route.props}
                push={this.props.push}
                pop={this.props.pop}
            />
        );
    }

    renderNavigationBar(sceneProps) {
        return (
            <Header
                style={styles.navigationBar}
                onNavigationBack={this.props.pop}
                {...sceneProps}
            />
        );
    }
    
    render() {
        return (
            <CardStack
                onNavigateBack={this.props.pop}
                navigationState={this.props.navigation}
                renderScene={this.renderScene}
                renderHeader={this.renderNavigationBar}
                style={styles.cardStack}
            />
        );
    }
}

Nav.propTypes = {
    push: PropTypes.func.isRequired,
    pop: PropTypes.func.isRequired,
    navigation: PropTypes.objectOf(PropTypes.any)
};

const styles = StyleSheet.create({
    cardStack: {
        flex: 1
    },
    navigationBar: {
        backgroundColor: globalStyles.MUTED_COLOR
    }
});
