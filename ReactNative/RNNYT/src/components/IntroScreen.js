import React from 'react';
import PropTypes from 'prop-types';
import {
    View,
    TouchableOpacity,
    StatusBar,
    StyleSheet
} from 'react-native';
import { StackActions } from 'react-navigation';
import Title from './Title';
import AppText from './AppText';
import * as globalStyles from '../styles/global';

StatusBar.setBarStyle('light-content');

const pushToHomeAction = StackActions.push({
    routeName: 'Home',
});

const IntroScreen = ({ navigation }) => (
    <View style={[globalStyles.COMMON_STYLES.pageContainer, styles.container]}>
        <TouchableOpacity onPress={() => navigation.dispatch(pushToHomeAction)}>
            <Title>React Native News Reader</Title>
            <AppText>
                Start Reading
            </AppText>
        </TouchableOpacity>
    </View>
);

const styles = StyleSheet.create({
    container: {
        marginBottom: 0,
        justifyContent: 'center',
        alignItems: 'center'
    }
});

export default IntroScreen;
