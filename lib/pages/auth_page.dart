import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _email = '';
  String _password = '';
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
          child: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            buildEmailField(),
            buildPasswordField(),
            // Switch(
            //   value: true,
            //   onChanged: (bool onValue) {},
            // ),
            buildAcceptTerms(),
            SizedBox(height: 10.0),
            buildLoginButton(context),
            SizedBox(height: 10.0),
            Text('$EMAIL: $_email'),
            Text('$PASSWORD: $_password'),
          ],
        ),
      )),
    );
  }

  SwitchListTile buildAcceptTerms() {
    return SwitchListTile(
      value: _acceptTerms,
      onChanged: (bool onValue) {
        setState(() {
          _acceptTerms = onValue;
        });
      },
      title: Text('Accept terms?'),
    );
  }

  TextField buildEmailField() {
    return TextField(
      decoration: InputDecoration(labelText: '$EMAIL:'),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  TextField buildPasswordField() {
    return TextField(
      decoration: InputDecoration(labelText: '$PASSWORD:'),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  RaisedButton buildLoginButton(BuildContext context) {
    return RaisedButton(
      child: Text('Login'),
      onPressed: () {
        Navigator.pushReplacementNamed(context, PRODUCTSROUTE);
      },
    );
  }
}
