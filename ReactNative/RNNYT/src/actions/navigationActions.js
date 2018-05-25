import {
    NAVIGATION_PUSH,
    NAVIGATION_POP,
    NSVIGATION_TAB,
    NAVIGATION_OPEN_MODAL,
    NAVIGATION_CLOSE_MODAL
} from './actionTypes';

export const push = key => ({
    type: NAVIGATION_PUSH,
    payload: key
});

export const pop = () => ({
    type: NAVIGATION_POP
});

export const tab = key => ({
    type: NAVIGATION_TAB,
    payload: key
});

export const openModal = url => ({
    type: NAVIGATION_OPEN_MODAL,
    payload: url
});

export const closeModal = () => ({
    type: NAVIGATION_CLOSE_MODAL
})
