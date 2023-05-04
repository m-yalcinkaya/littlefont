import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/items/bottom_nav_bar.dart';
import 'package:littlefont/repository/accounts_repository.dart';
import 'package:littlefont/items/button.dart';
import 'package:littlefont/screens/sign_up_page.dart';
import 'package:littlefont/modals/account.dart';

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

  void _findManager() {
    final accountRepo = ref.read(accountProvider);
    for (Account a in accountRepo.accounts) {
      if (a.email == _text1Controller.text) {
        accountRepo.manager = a;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyLogin,
        child: Container(
          color: Colors.blue.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              PhysicalModel(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                elevation: 10,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.people,
                        color: Colors.black,
                        size: 70,
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: 330,
                        height: 75,
                        alignment: Alignment.center,
                        child: TextField1(
                          text1Controller: _text1Controller,
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
                        child: TextField2(
                          text2Controller: _text2Controller,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Button(
                          height: 35,
                          text: 'Log in',
                          onPressedOperations: () {
                            final isSuitable =
                                _formKeyLogin.currentState?.validate();

                            if (isSuitable == true) {
                              _findManager();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BottomNavBar(),
                              ));
                            }
                          },
                          width: 100,
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SignUp(),
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

class TextField1 extends ConsumerStatefulWidget {
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
    final accountRepo = ref.read(accountProvider);
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        setState(() {
          lenghtString = value.length;
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

        bool isFounded = false;

        if (isMailSymbol && value.contains('.com')) {
          for (int i = 0; i < accountRepo.accounts.length; i++) {
            if (accountRepo.accounts[i].email == value) {
              isFounded = true;
            }
          }

          return isFounded ? null : 'Wrong email';
        } else {
          return 'Invalid email';
        }
      },
      controller: widget._textController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        counterText: '$lenghtString Character',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        )),
      ),
    );
  }
}

class TextField2 extends ConsumerStatefulWidget {
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
    final accountRepo = ref.read(accountProvider);
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) {
        setState(() {
          lenghtString = value.length;
        });
      },
      validator: (value) {
        bool isFounded = false;
        for (int i = 0; i < accountRepo.accounts.length; i++) {
          if (accountRepo.accounts[i].password == value) {
            isFounded = true;
            break;
          }
        }

        return isFounded ? null : 'Invalid password';
      },
      controller: widget._textController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter the password',
        counterText: '$lenghtString Character',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        )),
      ),
    );
  }
}
