import NavigationExperimental from 'react-native-navigation-experimental-compat';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { searchNews } from '../actions/newsActions';
import { openModal, closeModal } from '../actions/navigationActions';
import { addBookmark } from '../actions/bookmarkActions';
import Search from '../components/Search';
import { searchNewsSelector } from '../selectors/newsSelectors';

const { StateUtils } = NavigationExperimental;

const mapStateToProps = (state) => {
    const homeState = StateUtils.get(state.navigation, 'home');
    const newsFeedState = homeState && StateUtils.get(homeState, 'newsFeed');
    const modal = newsFeedState && newsFeedState.modal;
    return {
        filteredNews: searchNewsSelector(state),
        modal: modal || undefined
    }
};

const mapDispatchToProps = dispatch => (
    bindActionCreators({
        searchNews,
        onModalOpen: openModal,
        onModalClose: closeModal,
        addBookmark
    }, dispatch)
);

export default connect(mapStateToProps, mapDispatchToProps)(Search);
