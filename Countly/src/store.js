import { createStore, applyMiddleware } from 'redux';
import promise from 'redux-promise';

const initialState = {
    count: 0
};

const countReducer = (state = initialState, action) => {
    switch (action.type) {
        case 'INCREMENT':
            return {
                count: state.count + 1
            };
        case 'DECREMENT':
            return {
                count: state.count - 1
            };
        case 'ZERO':
            return {
                count: 0
            };
        default:
            return state;
    }
};

const middleware = applyMiddleware(promise);

export default createStore(countReducer, middleware);