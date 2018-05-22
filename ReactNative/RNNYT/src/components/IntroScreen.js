import React from 'react';
import PropTypes from 'prop-types';
import {
    View,
    TouchableOpacity,
    StatusBar,
    StyleSheet
} from 'react-native';
import Title from './Title';
import AppText from './AppText';
import * as globalStyles from '../styles/global';

StatusBar.setBarStyle('light-content');

const IntroScreen = ({ navigator, nextScene }) => (
    <View style={[globalStyles.COMMON_STYLES.pageContainer, styles.container]}>
        <TouchableOpacity onPress={() => navigator.push(nextScene)}>
            <Title>React Native News Reader</Title>
            <AppText>
                Start Reading
            </AppText>
        </TouchableOpacity>
    </View>
);

IntroScreen.propTypes = {
    navigator: PropTypes.shape({
        push: PropTypes.func
    }).isRequired,
    nextScene: PropTypes.objectOf(PropTypes.any)
};

const styles = StyleSheet.create({
    container: {
        marginBottom: 0,
        justifyContent: 'center',
        alignItems: 'center'
    }
});

export default IntroScreen;
