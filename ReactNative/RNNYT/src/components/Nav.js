import React, { Component } from 'react';
import { TouchableOpacity, StyleSheet } from 'react-native';
import NavigationExperimental from 'react-native-deprecated-custom-components';
import HomeScreen from './HomeScreen';
import IntroScreen from './IntroScreen';
import Title from './Title';
import SmallText from './SmallText';
import * as globalStyles from '../styles/global';

const HOME_ROUTE = { 
    title: 'RNNTY',
    component: HomeScreen

};
const INTRO_ROUTE = { 
    title: 'Welcome',
    component: IntroScreen,
    props: {
        nextScene: HOME_ROUTE
    }
};

export default class Nav extends Component {

    render() {
        return (
            <Navigator
                initialRoute={INTRO_ROUTE}
                renderScene={this.renderScene}
                navigationBar={this.renderNavigationBar}
            />
        );
    }

    renderScene(route, navigator) {
        return (
            <route.component
                navigator={navigator}
                {...route.props}
            />
        );
    }

    renderNavigationBar() {
        return (
            <Navigator.NavigationBar
                routeMapper={{
                    LeftButton: this.renderLeftButton,
                    RightButton: () => null,
                    Title: this.renderTitle
                }}
                style={styles.navbar}
            />
        );
    }

    renderLeftButton(route, navigator, index) {
        if (index === 0) {
            return null;
        }
        return (
            <TouchableOpacity
                style={styles.leftButton}
                onPress={() => navigator.pop()}
            >
                <SmallText>Back</SmallText>
            </TouchableOpacity>
        );
    }

    renderTitle(route) {
        return (
            <Title style={styles.title}>
                {route.title}
            </Title>
        );
    }
}

const styles = StyleSheet.create({
    navbar: {
        backgroundColor: globalStyles.MUTED_COLOR
    },
    leftButton: {
        padding: 12
    },
    title: {
        padding: 8,
        backgroundColor: globalStyles.MUTED_COLOR
    }
});