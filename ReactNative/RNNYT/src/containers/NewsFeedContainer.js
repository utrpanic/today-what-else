import NavigationExperimental from 'react-native-navigation-experimental-compat';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { loadNews } from '../actions/newsActions';
import { openModal, closeModal } from '../actions/navigationActions';
import { allNewsSelector } from '../selectors/newsSelectors';
import NewsFeed from '../components/NewsFeed';

const { StateUtils } = NavigationExperimental;

const mapStateToProps = (state) => {
    const homeState = StateUtils.get(state.navigation, 'home');
    const newsFeedState = homeState && StateUtils.get(homeState, 'newsFeed');
    const modal = newsFeedState && newsFeedState.modal;
    return {
        news: allNewsSelector(state),
        modal: modal || undefined
    };
};

const mapDispatchToProps = dispatch => (
    bindActionCreators({
        loadNews,
        onModalOpen: openModal,
        onModalClose: closeModal
    }, dispatch)
);

export default connect(mapStateToProps, mapDispatchToProps)(NewsFeed);
