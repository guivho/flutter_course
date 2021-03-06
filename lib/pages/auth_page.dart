import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/auth_mode.dart';
import '../models/login_data.dart';
import '../scoped-models/main_model.dart';
import '../utils/constants.dart';
import '../widgets/ui_elements/spinner.dart';
import '../utils/util.dart';
import '../utils/validators.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final LoginData _loginData = LoginData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _warningText = 'Required!';
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

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
          _buildPasswordConfirmField(),
          SizedBox(height: 10.0),
          _buildAcceptTerms(),
          SizedBox(height: 10.0),
          _buildSubmitButton(),
          SizedBox(height: 10.0),
          _buildSwitchModeButton(),
          // _buildHomeCookedButton(),
          // Text('$EMAIL: $_email'),
          // Text('$PASSWORD: $_password'),
        ],
      ),
    );
  }

  Widget _buildSwitchModeButton() {
    return FlatButton(
      child: Text(
          'Switch to ${_authMode == AuthMode.Login ? 'signup' : 'login'} mode'),
      onPressed: () {
        setState(() {
          _authMode =
              _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
        });
      },
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
        labelText: '$EMAILPROMPT',
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: Validators.emailAddress,
      onSaved: (String value) {
        _loginData.email = value.trim();
      },
    );
  }

  Widget _buildPasswordConfirmField() {
    if (_authMode == AuthMode.Login) return Container();
    return TextFormField(
      decoration: InputDecoration(
        labelText: '$CONFIRMPASSWORD',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      validator: (input) {
        return Validators.confirmPassword(input, _passwordTextController.text);
      },
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '$PASSWORDPROMPT',
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      controller: _passwordTextController,
      validator: Validators.password,
      onSaved: (String value) {
        _loginData.password = value.trim();
      },
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Spinner()
            : RaisedButton(
                child:
                    Text('${_authMode == AuthMode.Login ? 'Login' : 'Signup'}'),
                onPressed: () => _submitForm(model.authenticate),
              );
      },
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

  void _submitForm(Function authenticate) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _loginData.warning = _loginData.acceptTerms ? '' : _warningText;
      });
      if (_loginData.acceptTerms) {
        final Map<String, dynamic> successInformation = await authenticate(
            _authMode, _loginData.email, _loginData.password);
        if (successInformation[FB_SUCCESS]) {
          // Navigator.pushReplacementNamed(context, AUTHROUTE);
        } else {
          Util.showErrorDialog(context, successInformation['message']);
        }
      }
    }
  }
}
