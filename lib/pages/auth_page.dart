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

  _buildBackgroundImage() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
        image: AssetImage('assets/background.jpg'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final targetWidth = mediaWidth > 368.0 ? 368.0 : mediaWidth * 0.95;
    return new Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          decoration: _buildBackgroundImage(),
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: targetWidth,
                child: Column(
                  children: <Widget>[
                    _buildEmailField(),
                    SizedBox(height: 10.0),
                    _buildPasswordField(),
                    SizedBox(height: 10.0),
                    _buildAcceptTerms(),
                    SizedBox(height: 10.0),
                    _buildLoginButton(),
                    SizedBox(height: 10.0),
                    // _buildHomeCookedButton(),
                    // Text('$EMAIL: $_email'),
                    // Text('$PASSWORD: $_password'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DecoratedBox _buildAcceptTerms() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: SwitchListTile(
        value: _acceptTerms,
        onChanged: (bool onValue) {
          setState(() {
            _acceptTerms = onValue;
          });
        },
        title: Text('Accept terms?'),
      ),
    );
  }

  TextField _buildEmailField() {
    return TextField(
      decoration: InputDecoration(
        labelText: '$EMAIL:',
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  TextField _buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
        labelText: '$PASSWORD:',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  RaisedButton _buildLoginButton() {
    return RaisedButton(
      child: Text('Login'),
      onPressed: _submitForm,
    );
  }

  // GestureDetector _buildHomeCookedButton() {
  //   return GestureDetector(
  //     onTap: _submitForm,
  //     child: Container(
  //       color: Colors.green,
  //       padding: EdgeInsets.all(5.0),
  //       child: Text('Home cooked button'),
  //     ),
  //   );
  // }

  void _submitForm() {
    Navigator.pushReplacementNamed(context, PRODUCTSROUTE);
  }
}
