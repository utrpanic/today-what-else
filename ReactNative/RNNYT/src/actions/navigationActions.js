import {
    NAVIGATION_PUSH,
    NAVIGATION_POP
} from './actionTypes';

export const push = key => ({
    type: NAVIGAtION_PUSH,
    payload: key
});

export const pop = () => ({
    type: NAVIGAtION_POP
});
