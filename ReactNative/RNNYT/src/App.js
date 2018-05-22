import React from 'react';
import { Provider } from 'react-redux';
import Nav from './components/Nav';
import createStore from  './createStore';

const store = createStore();

export default () => (
    <Provider store={store}>
        <Nav />
    </Provider>
);
