import React from 'react';
import { Button, StyleSheet, Text, View } from 'react-native';
import { AuthSession } from 'expo';

export default class App extends React.Component {
  state = {
    result: null
  }
  render() {
    return (
      <View style={styles.container}>
        <Text>Helllllllooooo</Text>
        <Button title="Login" onPress={this._handlePressAsync }/>
        {this.state.result ? (
          <Text>{JSON.stringify(this.state.result)}</Text>
        ): null}
      </View>
    );
  }

  _handlePressAsync = async () => {
    let redirectUrl = AuthSession.getRedirectUrl();
    let result = await AuthSession.startAsync({
      authUrl: `https://cd952c18.ngrok.io/oauth/authorize?response_type=code` +
               `&client_id=THIS_IS_A_SECRET_AND_I_DONT_KNOW_HOW_TO_POPULATE_SECRETS_SAFELY_YET` +
               `&redirect_uri=${encodeURIComponent(redirectUrl)}`,
    });
    this.setState({ result });
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
