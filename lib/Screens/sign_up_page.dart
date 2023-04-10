import 'package:flutter/material.dart';
import 'package:littlefont/Items/button.dart';
import 'package:littlefont/Screens/my_notes_page.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);


  final FocusNode adFocusNode = FocusNode();
  final FocusNode soyadfocusNode = FocusNode();
  final FocusNode postaFocusNode = FocusNode();
  final FocusNode sifreFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 50,),
                  Button(
                    text: 'Facebook ile giriş yap',
                    textColor: Colors.black,
                    color: Colors.white,
                    height: 50,
                    width: 250,
                    onPressedOperations: () {},
                    image: 'assets/images/Facebook_Logo_(2019).png',
                  ),
                  Button(
                    text: 'Twitter ile giriş yap',
                    textColor: Colors.black,
                    color: Colors.white,
                    height: 50,
                    width: 250,
                    image: 'assets/images/Twitter-logo.svg.png',
                    onPressedOperations: () {},
                  ),
                ],
              ),

              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
                  //Divider(thickness: 4, color: Colors.black, indent: 0, endIndent: 150),
                  Text('veya'),
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

              const SizedBox(height: 20,),
              Padding(
                padding:const EdgeInsets.all(10),
                child: SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(soyadfocusNode);
                    },
                    decoration:const InputDecoration(
                      hintText: 'Adınızı giriniz',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(10),
                child: SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    focusNode: soyadfocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(postaFocusNode);
                    },
                    decoration:const InputDecoration(
                      hintText: 'Soyadınızı giriniz',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(10),
                child: SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    focusNode: postaFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(sifreFocusNode);
                    },
                    decoration:const InputDecoration(
                      hintText: 'E-postanızı giriniz',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(10),
                child: SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    focusNode: sifreFocusNode,
                    obscureText: true,
                    decoration:const InputDecoration(
                      hintText: 'Şifrenizi giriniz',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Button(
                text: 'Kayıt Ol',
                color: Colors.red,
                onPressedOperations: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyNotes(),
                      ));
                },
                width: 150,
                height: 10,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
