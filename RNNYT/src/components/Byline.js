import React, { PropTypes } from 'react';
import {
  StyleSheet,
  View
} from 'react-native';
import SmallText from './SmallText';
import * as globalStyles from '../styles/global';

const Byline = ({ date, author, location }) => (
  <View>
    <View style={style.row}>
      <SmallText>
        {date.toLocaleDateString()}
      </SmallText>
      <SmallText>
        {author}
      </SmallText>
    </View>

    {location ? (
      <View style={styles.row}>
        <SmallText styles={styles.location}>
          {location}
        </SmallText>
      </View>
    ) : null}
  </View>
);

Byline.propTypes = {
  date: PropTypes.instanceOf(Date).isRequired,
  author: PropTypes.string.isRequired,
  location: PropTypes.string
};

const styles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 5
  },
  location: {
    color: globalStyles.MUTED_COLOR
  }
});
