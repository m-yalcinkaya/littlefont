import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/Items/bottom_nav_bar.dart';

import 'login_page_index.dart';

class Login extends ConsumerStatefulWidget {

  const Login({
    super.key,
  });

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  late String? name;
  late String? surname;


  TextEditingController text1Controller = TextEditingController();
  TextEditingController text2Controller = TextEditingController();


  @override
  void dispose() {
    text1Controller.dispose();
    text2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: formKeyLogin,
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
                          formKey: formKeyLogin,
                          text1Controller: text1Controller,
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
                          formKey: formKeyLogin,
                          text2Controller: text2Controller,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Button(
                          height: 35,
                          text: 'Giriş Yap',
                          onPressedOperations: () {
                            const isSuitable = true;
                                // widget.formKeyLogin.currentState?.validate();

                            if (isSuitable == true) {
                              Account? account;

                              for (Account a
                                  in ref.read(loginProvider).accounts) {
                                if (a.email == text1Controller.text) {
                                  account = a;
                                }
                              }
                              name = account?.name;
                              surname = account?.surname;

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BottomNavBar(),
                                    /*AppMainPage(name: name, surname: surname),*/
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
                      child: const Text('Hesabın yok mu? Kayıt ol'),
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
    required this.text1Controller,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController text1Controller;

  @override
  ConsumerState<TextField1> createState() => _TextField1State();
}

class _TextField1State extends ConsumerState<TextField1> {
  int lenghtString = 0;

  @override
  Widget build(BuildContext context) {
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
          for (int i = 0; i < ref.read(loginProvider).accounts.length; i++) {
            if (ref.read(loginProvider).accounts[i].email == value) {
              isFounded = true;
            }
          }

          return isFounded ? null : 'Yanlış E-posta';
        } else {
          return 'Geçersiz E-posta';
        }
      },
      controller: widget.text1Controller,
      decoration: InputDecoration(
        labelText: 'E-Posta',
        hintText: 'E-Postanızı giriniz',
        counterText: '$lenghtString Karakter',
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
    required this.text2Controller,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController text2Controller;

  @override
  ConsumerState<TextField2> createState() => _TextField2State();
}

class _TextField2State extends ConsumerState<TextField2> {
  int lenghtString = 0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (value) {
        setState(() {
          lenghtString = value.length;
        });
      },
      validator: (value) {
        bool isFounded = false;
        for (int i = 0; i < ref.read(loginProvider).accounts.length; i++) {
          if (ref.read(loginProvider).accounts[i].password == value) {
            isFounded = true;
            break;
          }
        }

        return isFounded ? null : 'Geçersiz Şifre';
      },
      controller: widget.text2Controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Şifre',
        hintText: 'Şifreyi giriniz',
        counterText: '$lenghtString Karakter',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20),
          right: Radius.circular(20),
        )),
      ),
    );
  }
}
