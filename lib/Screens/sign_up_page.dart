import 'package:flutter/material.dart';
import 'app_main_page.dart';
import 'package:littlefont/Items/button.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);


  FocusNode adFocusNode = FocusNode();
  FocusNode soyadfocusNode = FocusNode();
  FocusNode postaFocusNode = FocusNode();
  FocusNode sifreFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ol'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [

                  SizedBox(height: 50,),
                  Button(
                    text: 'Facebook ile giriş yap',
                    textColor: Colors.black,
                    color: Colors.white,
                    height: 50,
                    Width: 250,
                    onPressedOperations: () {},
                    image: 'assets/images/Facebook_Logo_(2019).png',
                  ),
                  Button(
                    text: 'Twitter ile giriş yap',
                    textColor: Colors.black,
                    color: Colors.white,
                    height: 50,
                    Width: 250,
                    image: 'assets/images/Twitter-logo.svg.png',
                    onPressedOperations: () {},
                  ),
                ],
              ),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                  Container(
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

              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(soyadfocusNode);
                    },
                    decoration: InputDecoration(
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
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    focusNode: soyadfocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(postaFocusNode);
                    },
                    decoration: InputDecoration(
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
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    focusNode: postaFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(sifreFocusNode);
                    },
                    decoration: InputDecoration(
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
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  width: 220,
                  height: 40,
                  child: TextField(
                    focusNode: sifreFocusNode,
                    obscureText: true,
                    decoration: InputDecoration(
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
                        builder: (context) => AppMainPage(),
                      ));
                },
                Width: 150,
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
