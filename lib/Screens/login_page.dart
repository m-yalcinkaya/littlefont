import 'package:flutter/material.dart';
import 'package:littlefont/Screens/my_notes_page.dart';
import 'package:littlefont/Items/button.dart';
import 'first_screen.dart';

  bool userNameCompability = true;
  bool passwordCompability = true;

class Login extends StatefulWidget {
  const Login({
    super.key,
    required this.widget,
    required this.text1Controller,
    required this.text2Controller,
  });


  final FirstScreen widget;
  final TextEditingController text1Controller;
  final TextEditingController text2Controller;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  _LoginState();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[400],
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
                    padding:  EdgeInsets.all(12.0),
                    child:  Icon(
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
                        text1Controller: widget.text1Controller,
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
                        text2Controller: widget.text2Controller,
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
                          (widget.text1Controller.text.length < 8) == true ?
                          userNameCompability = false : userNameCompability = true;
                          (widget.text2Controller.text.length < 10) == true ?
                          passwordCompability = false : passwordCompability = true;
                          (((widget.text1Controller.text.length >= 8) && (widget.text2Controller.text.length >= 10))
                              == true) ? buildPush(context) : null;
                          setState(() {
                          });
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
    );
  }

  Future<dynamic> buildPush(BuildContext context) {
    widget.text1Controller.text = '';
    widget.text2Controller.text = '';
    return Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyNotes(),));
  }
}

class TextField1 extends StatefulWidget {
  const TextField1({
    super.key,
    required this.text1Controller,
  });

  final TextEditingController text1Controller;

  @override
  State<TextField1> createState() => _TextField1State();
}

class _TextField1State extends State<TextField1> {
  int lenghtString = 0;


  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        setState(() {
          lenghtString = value.length;
        });
      },
      controller: widget.text1Controller,
      decoration: InputDecoration(
        labelText: 'Kullanıcı Adı',
        hintText: 'Kullanıcı adını giriniz',
        helperText: 'En az 8 karakter girilmelidir.',
        counterText: '$lenghtString characters',
        errorText: userNameCompability ? null : 'Kullanıcı adı 8 karakteri geçmeli',
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
    required this.text2Controller,
  });

  final TextEditingController text2Controller;
  @override
  State<TextField2> createState() => _TextField2State();
}

class _TextField2State extends State<TextField2> {
  int lenghtString = 0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        setState(() {
          lenghtString = value.length;
        });
      },
      controller: widget.text2Controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Şifre',
        hintText: 'Şifreyi giriniz',
        helperText: 'En az 10 karakter girilmelidir.',
        counterText: '$lenghtString characters',
        errorText: passwordCompability ? null : 'Parola 10 karakteri geçmeli !!',
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
