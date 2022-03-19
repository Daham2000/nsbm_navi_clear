import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsbm_navi_clear/db/auth.dart';
import 'package:nsbm_navi_clear/theme/styled_colors.dart';
import 'package:nsbm_navi_clear/ui/home_page/home_page_view.dart';
import 'package:nsbm_navi_clear/ui/login_page/login_page_view.dart';
import 'package:nsbm_navi_clear/ui/widgets/basic_widget.dart';
import 'package:nsbm_navi_clear/util/assets.dart';

class SignUpPageView extends StatefulWidget {
  const SignUpPageView({Key? key}) : super(key: key);

  @override
  State<SignUpPageView> createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<SignUpPageView> {
  final emailCtrl = TextEditingController();
  String email = "";
  String password = "";
  String name = "";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: emailCtrl,
      validator: (value) {
        if (value == null) {
          return 'Please enter your email';
        } else if (EmailValidator.validate(value)) {
          email = value;
        } else {
          return 'Please enter a valid Email';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: "Email",
        contentPadding: EdgeInsets.only(top: 20, bottom: 15, left: 10),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: StyledColor.textFieldBorderColor, width: 0.0),
        ),
        hintStyle: TextStyle(
          fontSize: 18,
          fontFamily: "Avenir",
          fontWeight: FontWeight.w800,
          color: StyledColor.textFieldBorderColor,
        ),
        fillColor: StyledColor.SEARCH_BOX,
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passCtrl,
      obscureText: true,
      validator: (value) {
        if (value == null) {
          return 'Please input a password';
        } else if (value.length < 6) {
          return 'Please input at least 6 characters';
        } else {
          password = value;
        }
        return null;
      },
      onChanged: (value) {
        if (password.isEmpty) {
          setState(() {
            password = value;
          });
        }
      },
      decoration: const InputDecoration(
        hintText: "Password",
        contentPadding: EdgeInsets.only(top: 20, bottom: 15, left: 10),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: StyledColor.textFieldBorderColor, width: 0.0),
        ),
        hintStyle: TextStyle(
          fontSize: 18,
          fontFamily: "Avenir",
          fontWeight: FontWeight.w800,
          color: StyledColor.textFieldBorderColor,
        ),
        fillColor: StyledColor.SEARCH_BOX,
      ),
    );

    final nameField = TextFormField(
      autofocus: false,
      controller: nameCtrl,
      obscureText: false,
      validator: (value) {
        if (value == null) {
          return 'Please input a user name';
        } else if (value.length < 3) {
          return 'Please input at least 3 characters';
        } else {
          name = value;
        }
        return null;
      },
      onChanged: (value) {
        if (name.isEmpty) {
          setState(() {
            name = value;
          });
        }
      },
      decoration: const InputDecoration(
        hintText: "Name",
        contentPadding: EdgeInsets.only(top: 20, bottom: 15, left: 10),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: StyledColor.textFieldBorderColor, width: 0.0),
        ),
        hintStyle: TextStyle(
          fontSize: 18,
          fontFamily: "Avenir",
          fontWeight: FontWeight.w800,
          color: StyledColor.textFieldBorderColor,
        ),
        fillColor: StyledColor.SEARCH_BOX,
      ),
    );

    Future<void> _signupClicked() async {
      final email = (emailCtrl.text).trim();
      final password = (passCtrl.text).trim();
      if (EmailValidator.validate(email)) {
        setState(() {
          isLoading = true;
        });
        UserCredential? result =
            await Auth().emailPasswordSignup(email, password);
        setState(() {
          isLoading = false;
        });
        if (result?.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePageView()),
          );
        }
      } else {
        return;
      }
      if (email.isEmpty || password.isEmpty) {
        return;
      }
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leadingWidth: 110,
          elevation: 0,
          leading: const AppBarLogo()),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: StyledColor.blurPrimary,
              ),
            )
          : ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "Signup to the system",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: nameField,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: emailField,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: passwordField,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        child: SizedBox(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState != null) {
                                if (_formKey.currentState!.validate()) {
                                  _signupClicked();
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: StyledColor.blurPrimary,
                              onPrimary: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Signup',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Mulish"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Text(
                    "Or",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            StyledColor.googleBtn),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                Assets.google,
                                color: Colors.white,
                                height: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Signup with google",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.mulish(
                                    color: Colors.white,
                                    textStyle: const TextStyle(fontSize: 13)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPageView()),
                    );
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      "Already have a account? Signin",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
