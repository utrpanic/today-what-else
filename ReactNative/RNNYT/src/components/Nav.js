import React, { Component } from 'react';
import { TouchableOpacity, StyleSheet } from 'react-native';
import { createStackNavigator } from 'react-navigation';
import NavigationExperimental from 'react-native-deprecated-custom-components';
import HomeScreen from './HomeScreen';
import IntroScreen from './IntroScreen';
import Title from './Title';
import SmallText from './SmallText';
import * as globalStyles from '../styles/global';

const INTRO_ROUTE = { 
    screen: IntroScreen,
    navigationOptions: ({ navigation }) => ({
        title: 'Welcome',
        headerStyle: {
            backgroundColor: globalStyles.MUTED_COLOR,
        },
        headerTintColor: globalStyles.HEADER_TEXT_COLOR,
    }),
};

const HOME_ROUTE = { 
    screen: HomeScreen,
    navigationOptions: ({ navigation }) => ({
        title: 'RNNTY',
        headerStyle: {
            backgroundColor: globalStyles.MUTED_COLOR,
        },
        headerTintColor: globalStyles.HEADER_TEXT_COLOR,
    }),
};

export default createStackNavigator(
    {
        Intro: INTRO_ROUTE,
        Home: HOME_ROUTE
    },
    {
        initialRouteName: 'Intro'
    }
);

// const styles = StyleSheet.create({
//     navbar: {
//         backgroundColor: globalStyles.MUTED_COLOR
//     },
//     leftButton: {
//         padding: 12
//     },
//     title: {
//         padding: 8,
//         backgroundColor: globalStyles.MUTED_COLOR
//     }
// });
