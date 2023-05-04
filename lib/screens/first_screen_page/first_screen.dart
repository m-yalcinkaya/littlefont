import 'first_screen_index.dart';

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
              text: 'Log in',
              color: Colors.red,
              onPressedOperations: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              width: 200,
              height: 20,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SignUp(),
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
    );
  }
}
