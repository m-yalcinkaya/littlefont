import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'first_screen_index.dart';

class FirstScreen extends ConsumerStatefulWidget{
  const FirstScreen({
    super.key,
  });

  @override
  ConsumerState<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> with TickerProviderStateMixin{
  
  late AnimationController animationController;
  late Animation<double> opacityAnimation;

  @override
  void dispose() {
    animationController.dispose();
    text1Controller.dispose();
    text2Controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
    );


    opacityAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
    ).animate(animationController);


    if(animationController.status == AnimationStatus.completed){
      animationController.reverse;
    }else {
      animationController.forward();
    }
  }

  final text1Controller = TextEditingController();

  final text2Controller = TextEditingController();


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
                animation: opacityAnimation,
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                      opacity: opacityAnimation.value,
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
                    builder: (context) => const Login()));
              },
              width: 200,
              height: 20,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SignUp(),
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
