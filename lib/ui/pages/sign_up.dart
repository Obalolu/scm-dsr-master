import 'package:dsr/api/api_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? username;
  String? password;
  bool? _isLoading;
  String? errorMessage = '';
  TextStyle style = TextStyle(fontFamily: 'Inder', fontSize: 20.0);
  bool? _obscureText;
  bool _isGoogleLoggedIn = false;
  GoogleSignInAccount? _userDetails;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _obscureText = true;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonWidget() {
      if (_isLoading!) {
        return CircularProgressIndicator(backgroundColor: Colors.white);
      } else {
        return Text("Sign Up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold));
      }
    }

    final usernameField = TextFormField(
      initialValue: username,
      onSaved: (value) {
        username = value;
      },
      obscureText: false,
      style: style,
      validator: MultiValidator([
        RequiredValidator(errorText: '*Required'),
      ]),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final emailField = TextFormField(
      initialValue: email,
      onSaved: (value) {
        email = value;
      },
      obscureText: false,
      style: style,
      validator: MultiValidator([
        EmailValidator(errorText: 'Enter a valid email address'),
      ]),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextFormField(
      initialValue: password,
      onSaved: (value) {
        password = value;
      },
      obscureText: _obscureText!,
      style: style,
      validator: MultiValidator([
        MinLengthValidator(6,
            errorText: "Password should be at least 6 characters"),
        MaxLengthValidator(15,
            errorText: "Password should not be greater than 15 characters")
      ]),
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText!;
              });
            },
            icon: Icon(
              _obscureText! ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          final form = _formKey.currentState;

          if (form!.validate()) {
            form.save();
            setState(() {
              _isLoading = true;
            });
            APIService apiService = APIService(
                username: username, email: email, password: password!);
            errorMessage = await apiService.getDevotionalData(context);
            print('error: $errorMessage');
            setState(() {
              _isLoading = false;
            });
            if (errorMessage == '') {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }
          } else {}
        },
        child: buttonWidget(),
      ),
    );
    final googleButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(30.0),
        ),
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        onPressed: () async {
          await _googleSignIn.signIn().then((userData) {
            setState(() {
              _isGoogleLoggedIn = true;
              _userDetails = userData;
            });
          }).catchError((e) {
            print(e);
          });
          _isLoading = true;
          APIService apiService = APIService(
              username: _userDetails!.displayName, email: _userDetails!.email, password: _userDetails!.id);
          errorMessage = await apiService.getDevotionalData(context);
          print('error: $errorMessage');
          setState(() {
            _isLoading = false;
          });
          await _googleSignIn.signOut().then((value) {
            setState(() {
              _isGoogleLoggedIn = false;
            });
          }).catchError((e) {
            print(e);
          });
          if (errorMessage == '') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Home()));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 0,
              child: Image.asset(
                'assets/images/google.png',
                width: 32,
                height: 32,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Continue With Google".toUpperCase(),
                textAlign: TextAlign.center,
                style: style.copyWith(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );

    final signIn = RichText(
      text: TextSpan(
          text: 'Already have an account?',
          style: TextStyle(color: Colors.black, fontSize: 18),
          children: <TextSpan>[
            TextSpan(
                text: ' Sign In',
                style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to desired screen
                    Navigator.pop(context);
                  })
          ]),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/images/logo.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        usernameField,
                        SizedBox(height: 25.0),
                        emailField,
                        SizedBox(height: 25.0),
                        passwordField,
                        SizedBox(
                          height: 35.0,
                        ),
                      ],
                    ),
                  ),
                  Text(errorMessage!, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 8.0),
                  signUpButton,
                  SizedBox(height: 15.0),
                  signIn,
                  SizedBox(height: 56.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Divider(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'or',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Divider(
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  googleButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
