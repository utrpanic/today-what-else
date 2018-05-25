import NavigationExperimental from 'react-native-navigation-experimental-compat';
import {
    NAVIGATION_PUSH,
    NAVIGATION_POP,
    NAVIGATION_TAB,
    NAVIGATION_OPEN_MODAL,
    NAVIGATION_CLOSE_MODAL
} from '../actions/actionTypes';
import IntroScreen from '../components/IntroScreen';
import HomeScreenContainer from '../containers/HomeScreenContainer';

const { StateUtils } = NavigationExperimental;

const routes = {
    home: {
        key: 'home',
        title: 'RNNYT',
        component: HomeScreenContainer,
        index: 0,
        routes: [
            { key: 'newsFeed' },
            { key: 'search' },
            { key: 'bookmarks' }
        ]
    },
    intro: {
        key: 'intro',
        title: 'Welcome',
        component: IntroScreen
    }
};

const initialState = {
    index: 0,
    routes: [
        routes.intro
    ]
};

export default (state = initialState, action = {}) => {
    if (action.type == NAVIGATION_PUSH) {
        return StateUtils.push(state, routes[action.payload]);
    } else if (action.type == NAVIGATION_POP) {
        return StateUtils.pop(state);
    } else if (action.type == NAVIGATION_TAB) {
        const homeState = StateUtils.get(state, 'home')
        const updatedHomeState = StateUtils.jumpTo(homeState, action.payload);
        return StateUtils.replaceAt(state, 'home', updatedHomeState);
    } else if (action.type == NAVIGATION_OPEN_MODAL) {
        const homeState = StateUtils.get(state, 'home')
        const openTabState = homeState.routes[homeState.index]
        const updatedTabState = { ...openTabState, modal: action.payload }
        const updatedHomeState = StateUtils.replaceAt(homeState, openTabState.key, updatedTabState)
        return StateUtils.replaceAt(state, 'home', updatedHomeState)
    } else if (action.type == NAVIGATION_CLOSE_MODAL) {
        const homeState = StateUtils.get(state, 'home')
        const openTabState = homeState.routes[homeState.index]
        const updatedTabState = { ...openTabState, modal: undefined }
        const updatedHomeState = StateUtils.replaceAt(homeState, openTabState.key, updatedTabState)
        return StateUtils.replaceAt(state, 'home', updatedHomeState)
    }
    return state;
};
