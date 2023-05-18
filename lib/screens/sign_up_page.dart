import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/services/auth_service.dart';
import 'package:littlefont/widgets/button.dart';
import 'package:littlefont/screens/login_page.dart';

import '../modals/account.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();

  final FocusNode _surnameFocusNode = FocusNode();
  final FocusNode _mailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late String _firstName;
  late String _lastName;
  late String _email;
  late String _password;

  bool? _isNumeric(String? value) {
    for (int i = 0; i < value!.length; i++) {
      int? number = int.tryParse(value[i]);
      if (number != null) {
        return true;
      }
    }
    return false;
  }

  bool? isMailSymbol(String? value) {
    for (var i = 0; i < value!.length; i++) {
      if (value[i] == '@') {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeySignUp,
      child: Scaffold(
        body: PhysicalModel(
          color: Colors.blue.shade100,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_surnameFocusNode);
                    },
                    validator: (value) {
                      return _isNumeric(value)!
                          ? 'Name cannot contain numbers'
                          : null;
                    },
                    onSaved: (newValue) {
                      _firstName = newValue!;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    focusNode: _surnameFocusNode,
                    validator: (value) {
                      return _isNumeric(value)!
                          ? 'Surname cannot contain numbers'
                          : null;
                    },
                    onSaved: (newValue) {
                      _lastName = newValue!;
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_mailFocusNode);
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'Enter your surname',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    focusNode: _mailFocusNode,
                    validator: (value) {
                      return (isMailSymbol(value)! && value!.contains('.com'))
                          ? null
                          : 'Invalid email';
                    },
                    onSaved: (newValue) {
                      _email = newValue!;
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    validator: (value) {
                      if (value != null) {
                        _isNumeric(value);

                        return value != value.toUpperCase() &&
                                value != value.toLowerCase() &&
                                _isNumeric(value)!
                            ? null
                            : 'Password must consist of upper and lower case letters and numbers';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _password = newValue!;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Button(
                  text: 'Register',
                  color: Colors.blue.shade400,
                  onPressedOperations: () async {
                    final isSuitable = formKeySignUp.currentState?.validate();
                    if (isSuitable == true) {
                      formKeySignUp.currentState?.save();
                      final account = Account(firstName: _firstName, lastName: _lastName, email: _email, password: _password);
                      await createUser(context, account: account);
                      await Future.microtask(
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ));
                        },
                      );
                    }
                  },
                  width: 150,
                  height: 50,
                  textColor: Colors.black,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
                  },
                  child: const Text('Do you have an account? Log in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
