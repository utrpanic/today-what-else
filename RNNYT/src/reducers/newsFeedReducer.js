import { LOAD_NEWS } from '../actions/actionTypes';

export default (state = [], action = {}) => {
    switch (action.type) {
        case LOAD_NEW:
            return action.payload.result || []
        default:
            return state;
    }
};
