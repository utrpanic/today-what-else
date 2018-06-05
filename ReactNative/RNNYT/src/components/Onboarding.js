import React, { Component } from 'react';
import {
    StyleSheet,
    View
} from 'react-native';
import OnboardingButtons from './OnboardingButtons';
import OnboardingPanel from './OnboardingPanel';
import onboardingContent from '../config/onboarding';

export default class Onboarding extends Component {

    constructor(props) {
        super(props);
        this.moveNext = this.moveNext.bind(this);
        this.movePrevious = this.movePrevious.bind(this);
        this.transitionToNextPanel = this.transitionToNextPanel.bind(this);
        this.state = {
            currentIndex: 0
        };
    }

    movePrevious() {
        this.transitionToNextPanel(this.state.currentIndex - 1);
    }

    moveNext() {
        this.transitionToNextPanel(this.state.currentIndex + 1);
    }

    transitionToNextPanel(nextIndex) {
        this.setState({
            currentIndex: nextIndex
        });
    }
    
    render() {
        return (
            <View style={styles.container}>
                <View style={styles.container}>
                    <View style={styles.panelContainer}>
                        <OnboardingPanel {...onboardingContent[this.state.currentIndex]} />
                    </View>
                    <OnboardingButtons 
                        totalItems={onboardingContent.length}
                        currentIndex={this.state.currentIndex}
                        movePrevious={this.movePrevious}
                        moveNext={this.moveNext}
                    />
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1
    }, 
    panelContainer: {
        flex: 1,
        flexDirection: 'row'
    }
});