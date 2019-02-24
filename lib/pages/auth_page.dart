import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../models/login_data.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final LoginData _loginData = LoginData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _warningText = 'Required!';

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
                child: _buildForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
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
    );
  }

  Widget _buildAcceptTerms() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: SwitchListTile(
              value: _loginData.acceptTerms,
              onChanged: (bool onValue) {
                setState(() {
                  _loginData.acceptTerms = onValue;
                });
              },
              title: Text('Accept terms?'),
            ),
          ),
          Text(
            _loginData.warning,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '$EMAIL:',
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: Validators.emailAddress,
      onSaved: (String value) {
        _loginData.email = value;
      },
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '$PASSWORD:',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      validator: Validators.password,
      //  (String input) {
      //   String errors = Validators.password(input);
      //   if (errors.length > 0) {
      //     return errors;
      //   }
      // },
      onSaved: (String value) {
        _loginData.password = value;
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
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _loginData.warning = _loginData.acceptTerms ? '' : _warningText;
      });
      // print(_loginData.email);
      // print(_loginData.password);
      // print(_loginData.acceptTerms);
      if (_loginData.acceptTerms) {
        print('[auth_page] pushing PRODUCTSROUTE');
        Navigator.pushReplacementNamed(context, PRODUCTSROUTE);
      }
    }
  }
}
