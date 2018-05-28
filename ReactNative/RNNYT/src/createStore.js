import { createStore, applyMiddleware, combineReducers } from 'redux';
import { createLogger } from 'redux-logger';
import promiseMiddleWare from 'redux-promise';
import newsFeedReducer from './reducers/newsFeedReducer';
import navigationReducer from './reducers/navigationReducer';
import searchTermReducer from './reducers/searchTermReducer';
import bookmarkReducer from './reducers/bookmarkReducer';

const logger = createLogger()

export default (initialState = {}) => (
    createStore(
        combineReducers({
            news: newsFeedReducer,
            searchTerm: searchTermReducer,
            bookmarks: bookmarkReducer,
            navigation: navigationReducer
        }),
        initialState,
        applyMiddleware(logger, promiseMiddleWare)
    )
);
