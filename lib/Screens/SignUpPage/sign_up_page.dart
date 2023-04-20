import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_up_page_index.dart';

class SignUp extends ConsumerWidget {
  final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();

  SignUp({
    Key? key,
  }) : super(key: key);

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode surnameFocusNode = FocusNode();
  final FocusNode mailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  late final String _name;
  late final String _surname;
  late final String _email;
  late final String _password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKeySignUp,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kayıt Ol'),
        ),
        body: SingleChildScrollView(
          child: PhysicalModel(
            color: Colors.white38,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                PhysicalModel(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue.shade100,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Button(
                          text: 'Google ile giriş yap',
                          textColor: Colors.black,
                          color: Colors.white,
                          height: 50,
                          width: 300,
                          image: 'assets/images/google.png',
                          onPressedOperations: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(surnameFocusNode);
                            },
                            validator: (value) {
                              bool isNumeric = false;
                              for (int i = 0; i < value!.length; i++) {
                                int? number = int.tryParse(value[i]);
                                if (number != null) {
                                  isNumeric = true;
                                  break;
                                }
                              }

                              return isNumeric ? 'İsim rakam içeremez' : null;
                            },
                            onSaved: (newValue) {
                              _name = newValue!;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.white70,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            focusNode: surnameFocusNode,
                            validator: (value) {
                              bool isNumeric = false;
                              for (int i = 0; i < value!.length; i++) {
                                int? number = int.tryParse(value[i]);
                                if (number != null) {
                                  isNumeric = true;
                                  break;
                                }
                              }

                              return isNumeric
                                  ? 'Soyisim rakam içeremez'
                                  : null;
                            },
                            onSaved: (newValue) {
                              _surname = newValue!;
                            },
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(mailFocusNode);
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.white70,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            focusNode: mailFocusNode,
                            validator: (value) {
                              bool isMailSymbol = false;
                              bool isFounded = true;
                              for (var i = 0; i < value!.length; i++) {
                                if (value[i] == '@') {
                                  isMailSymbol = true;
                                  break;
                                }

                                for (int i = 0;
                                    i < ref.read(loginProvider).accounts.length;
                                    i++) {
                                  if (ref.read(loginProvider).accounts[i].email ==
                                      value) {
                                    isFounded = false;
                                  }
                                }
                              }
                              return (isMailSymbol &&
                                          value.contains('.com')) &&
                                      isFounded
                                  ? null
                                  : 'Geçersiz E-posta';
                            },
                            onSaved: (newValue) {
                              _email = newValue!;
                            },
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(passwordFocusNode);
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.white70,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            focusNode: passwordFocusNode,
                            obscureText: true,
                            validator: (value) {
                              if (value != null) {
                                bool isNumeric = false;
                                for (var i = 0; i < value.length; i++) {
                                  int? number = int.tryParse(value[i]);
                                  if (number != null) {
                                    isNumeric = true;
                                    break;
                                  }
                                }

                                return value != value.toUpperCase() &&
                                        value != value.toLowerCase() &&
                                        isNumeric
                                    ? null
                                    : 'Şifre küçük-büyük karakter ve en az bir tane rakam içermelidir';
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
                        Button(
                          text: 'Kayıt Ol',
                          color: Colors.blue.shade400,
                          onPressedOperations: () {
                            final isSuitable =
                                formKeySignUp.currentState?.validate();
                            if (isSuitable == true) {
                              formKeySignUp.currentState?.save();

                              ref.read(loginProvider).accounts.add(Account(
                                name: _name,
                                surname: _surname,
                                email: _email,
                                password: _password,
                              ));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(
                                    ),
                                  ));
                            }
                          },
                          width: 150,
                          height: 50,
                          textColor: Colors.black,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const Login(
                              ),
                            ));
                          },
                          child: const Text('Hesabın var mu? Giriş yap'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
