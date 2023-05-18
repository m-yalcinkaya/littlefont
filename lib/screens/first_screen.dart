import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:littlefont/screens/sign_up_page.dart';
import '../widgets/button.dart';
import 'login_page.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({
    super.key,
  });

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  final _text1Controller = TextEditingController();
  final _text2Controller = TextEditingController();

  @override
  void dispose() {
    _animationController.dispose();
    _text1Controller.dispose();
    _text2Controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse;
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pexels-photo-1723637.webp'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 8,),
            Expanded(
              flex: 5,
              child: AnimatedBuilder(
                animation: _opacityAnimation,
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
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
                        AutoSizeText(
                          'LittleFont',
                          style: GoogleFonts.akshar(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          minFontSize: 24,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Spacer(flex: 2,),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Button(
                    textColor: Colors.white,
                    text: 'Log in',
                    color: Colors.red,
                    onPressedOperations: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Login()));
                    },
                    width: screenSize.width/2,
                    height: screenSize.width/8,
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    )),
                    child: const Text(
                      'New to the app? register now',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 8,),
          ],
        ),
      ),
    );
  }
}
