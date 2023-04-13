import 'package:flutter/material.dart';
import 'package:littlefont/Repository/login_repository.dart';
import 'package:littlefont/Screens/app_main_page.dart';
import 'package:littlefont/Items/button.dart';



class Login extends StatefulWidget {
  final LoginRepository loginRepository;
  final  GlobalKey<FormState> formKey;
  const Login({
    super.key, required this.loginRepository, required this.formKey,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {



  late String? name;
  late String? surname;

  @override
  Widget build(BuildContext context) {
    TextEditingController text1Controller = TextEditingController();
    TextEditingController text2Controller = TextEditingController();


    return Scaffold(
      body: Form(
        key: widget.formKey,
        child: Container(
          color: Colors.blue.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        size: 80,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: 330,
                        height: 75,
                        alignment: Alignment.center,
                        child: TextField1(
                          formKey: widget.formKey,
                          loginRepository: widget.loginRepository,
                          text1Controller: text1Controller,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        width: 330,
                        height: 75,
                        alignment: Alignment.center,
                        child: TextField2(
                          formKey: widget.formKey,
                          loginRepository: widget.loginRepository,
                          text2Controller: text2Controller,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        padding: const EdgeInsets.only(top: 15),
                        alignment: Alignment.topCenter,
                        child: Button(
                          height: 35,
                          text: 'Giriş Yap',
                          onPressedOperations: () {

                            final isSuitable = widget.formKey.currentState
                                ?.validate();

                            if (isSuitable == true) {
                              Account? account;

                              for(Account a in widget.loginRepository.accounts){
                                if(a.email == text1Controller.text) {
                                  account = a;
                                }
                              }
                              name = account?.name;
                              surname = account?.surname;

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AppMainPage(name: name, surname: surname),));
                            }

                          },
                          width: 100,
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ),
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

class TextField1 extends StatefulWidget {
  const TextField1({
    super.key,
    required this.text1Controller, required this.loginRepository, required this.formKey,
  });

  final LoginRepository loginRepository;
  final GlobalKey<FormState> formKey;
  final TextEditingController text1Controller;

  @override
  State<TextField1> createState() => _TextField1State();
}

class _TextField1State extends State<TextField1> {
  int lenghtString = 0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          for (int i = 0; i < widget.loginRepository.accounts.length; i++) {
            if (widget.loginRepository.accounts[i].email == value) {
              isFounded = true;
            }
          }

          return isFounded ? null : 'Yanlış E-posta';
        }else {
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
            )
        ),
      ),
    );
  }
}

class TextField2 extends StatefulWidget {
  const TextField2({
    super.key,
    required this.text2Controller, required this.loginRepository, required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  final LoginRepository loginRepository;
  final TextEditingController text2Controller;

  @override
  State<TextField2> createState() => _TextField2State();
}

class _TextField2State extends State<TextField2> {
  int lenghtString = 0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          lenghtString = value.length;
        });
      },
      validator: (value) {

        bool isFounded = false;
        for(int i=0; i<widget.loginRepository.accounts.length; i++){
          if(widget.loginRepository.accounts[i].password == value){
            isFounded = true;break;
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
            )
        ),
      ),
    );
  }
}
