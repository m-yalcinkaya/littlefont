import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/services/auth_service.dart';
import 'package:littlefont/widgets/bottom_nav_bar.dart';
import 'package:littlefont/widgets/button.dart';
import 'package:littlefont/screens/first_screen.dart';
import 'package:littlefont/screens/sign_up_page.dart';

import '../utilities/google_sign_in.dart';

class Login extends ConsumerStatefulWidget {
  const Login({
    super.key,
  });

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _formKeyLogin = GlobalKey<FormState>();

  final _text1Controller = TextEditingController();
  final _text2Controller = TextEditingController();

  @override
  void dispose() {
    _text1Controller.dispose();
    _text2Controller.dispose();
    super.dispose();
  }

  int lenghtString1 = 0;
  int lenghtString2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyLogin,
        child: Container(
          color: Colors.blue.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              PhysicalModel(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                elevation: 10,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                      text: 'Log in with Google',
                      textColor: Colors.black,
                      color: Colors.white,
                      height: 50,
                      width: 300,
                      image: 'assets/images/google.png',
                      onPressedOperations: () async {
                        try {
                          await signInWithGoogle();
                          if (FirebaseAuth.instance.currentUser != null) {
                            await Future.microtask(
                              () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBar(),
                                    ));
                              },
                            );
                          } else {
                            await Future.microtask(
                              () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FirstScreen(),
                                    ));
                              },
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Log in with Google Error! please try to log in normally')));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 10,
                          child: Divider(
                            thickness: 1,
                            indent: 0,
                            endIndent: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text('Or'),
                        SizedBox(
                          width: 150,
                          height: 10,
                          child: Divider(
                            thickness: 1,
                            indent: 20,
                            endIndent: 0,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: 330,
                        height: 75,
                        alignment: Alignment.center,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              lenghtString1 = value.length;
                            });
                          },
                          validator: (value) {
                            bool isMailSymbol = false;
                            for (var i = 0; i < value!.length; i++) {
                              if (value[i] == '@') {
                                isMailSymbol = true;
                                break;
                              }
                            }
                            return !isMailSymbol ? 'Invalid Email' : null;
                          },
                          controller: _text1Controller,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            counterText: '$lenghtString1 Character',
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                  right: Radius.circular(20),
                                )),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: 330,
                        height: 75,
                        alignment: Alignment.center,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              lenghtString2 = value.length;
                            });
                          },
                          validator: (value) {
                            return null;
                          },
                          controller: _text2Controller,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter the password',
                            counterText: '$lenghtString2 Character',
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                  right: Radius.circular(20),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Button(
                          height: 50,
                          width: 120,
                          text: 'Log in',
                          onPressedOperations: () async {
                            final isSuitable =
                                _formKeyLogin.currentState?.validate();
                            if (isSuitable == true) {
                              await logInUser(context, _text1Controller.text,
                                  _text2Controller.text);

                            }
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ));
                      },
                      child: const Text('Don\'t have an account? register now'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*class TextField1 extends ConsumerStatefulWidget {
  const TextField1({
    super.key,
    required TextEditingController text1Controller,
  }) : _textController = text1Controller;

  final TextEditingController _textController;

  @override
  ConsumerState<TextField1> createState() => _TextField1State();
}

class _TextField1State extends ConsumerState<TextField1> {
  int lenghtString = 0;

  @override
  Widget build(BuildContext context) {
    return
  }
}*/

/*class TextField2 extends ConsumerStatefulWidget {
  const TextField2({
    super.key,
    required TextEditingController text2Controller,
  }) : _textController = text2Controller;

  final TextEditingController _textController;

  @override
  ConsumerState<TextField2> createState() => _TextField2State();
}

class _TextField2State extends ConsumerState<TextField2> {
  int lenghtString = 0;

  @override
  Widget build(BuildContext context) {
    return
  }
}*/
