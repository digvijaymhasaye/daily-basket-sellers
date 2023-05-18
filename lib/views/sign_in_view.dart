import 'package:daily_basket_sellers/blocs/auth_bloc.dart';
import 'package:daily_basket_sellers/views/home_view.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _emailId;
  String _password;
  AuthorizationBloc _authorizationBloc = AuthorizationBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: Image.asset('assets/images/grocers.png'),
          ),
          Card(
            margin: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                        validator: (email) {
                          if (email.isEmpty) {
                            return 'Please enter email id';
                          }

                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);

                          if (!regex.hasMatch(email)) {
                            return 'Please enter valid email id';
                          }
                          _emailId = email;
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18.0),
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (password) {
                          if (password.isEmpty) {
                            return 'Please enter password';
                          }

                          if (password.length < 8 || password.length > 32) {
                            return 'Invalid password';
                          }
                          _password = password;
                          return null;
                        },
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18.0),
                          labelText: 'Password',
                        ),
                      )
                    ],
                  ),
                )),
          ),
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  try {
                    await _authorizationBloc.signIn(_emailId, _password);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  } catch (e) {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text(e.message)));
                  }
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      letterSpacing: 0.8,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
