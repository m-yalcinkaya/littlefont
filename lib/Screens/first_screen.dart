import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:littlefont/Repository/login_repository.dart';
import 'package:littlefont/Screens/sign_up_page.dart';
import '../Items/button.dart';
import 'login_page.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({
    super.key,
  });

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with TickerProviderStateMixin{
  
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void dispose() {
  controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
    );


    animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
    ).animate(controller);


    if(controller.status == AnimationStatus.completed){
      controller.reverse;
    }else {
      controller.forward();
    }
  }

  final text1Controller = TextEditingController();

  final text2Controller = TextEditingController();

  final loginRepository = LoginRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pexels-photo-1723637.webp'),
            fit: BoxFit.fill,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                      opacity: animation.value,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.access_time_filled,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                        Text(
                          'LittleFont',
                          style: GoogleFonts.akshar(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },

              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Button(
              textColor: Colors.white,
              text: 'Giriş Yap',
              color: Colors.red,
              onPressedOperations: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Login(
                          loginRepository: loginRepository,
                        )));
              },
              width: 200,
              height: 42,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SignUp(
                  loginRepository: loginRepository,
                ),
              )),
              child: const Text(
                'Uygulamada yeni misin? Hemen Kaydol',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
