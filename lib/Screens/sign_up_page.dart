import 'package:flutter/material.dart';
import 'package:littlefont/Items/button.dart';
import 'package:littlefont/Repository/login_repository.dart';
import 'package:littlefont/Screens/login_page.dart';

class SignUp extends StatelessWidget {

  final LoginRepository loginRepository;
  final GlobalKey<FormState> formKey;

  SignUp({
    Key? key,
    required this.loginRepository, required this.formKey,
  }) : super(key: key);

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode surnamefocusNode = FocusNode();
  final FocusNode mailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();



  late final String _name;
  late final String _surname;
  late final String _email;
  late final String _password;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
                          text: 'Facebook ile giriş yap',
                          textColor: Colors.black,
                          color: Colors.white,
                          height: 50,
                          width: 300,
                          onPressedOperations: () {},
                          image: 'assets/images/Facebook_Logo_(2019).png',
                        ),
                        Button(
                          text: 'Twitter ile giriş yap',
                          textColor: Colors.black,
                          color: Colors.white,
                          height: 50,
                          width: 300,
                          image: 'assets/images/Twitter-logo.svg.png',
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
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 220,
                            height: 40,
                            child: TextFormField(
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(surnamefocusNode);
                              },
                              validator: (value) {

                                bool isNumeric = false;
                                for(int i=0; i< value!.length; i++){
                                  int? number = int.tryParse(value[i]);
                                  if(number != null){
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 220,
                            height: 40,
                            child: TextFormField(
                              focusNode: surnamefocusNode,
                              validator: (value) {
                                bool isNumeric = false;
                                for(int i=0; i< value!.length; i++){
                                  int? number = int.tryParse(value[i]);
                                  if(number != null){
                                    isNumeric = true;
                                    break;
                                  }
                                }

                                return isNumeric ? 'Soyisim rakam içeremez' : null;
                              },
                              onSaved: (newValue) {
                                _surname = newValue!;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(mailFocusNode);
                              },
                              decoration: const InputDecoration(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 220,
                            height: 40,
                            child: TextFormField(
                              focusNode: mailFocusNode,
                              validator: (value) {

                                bool isMailSymbol = false;
                                for (var i = 0; i < value!.length; i++) {
                                  if (value[i] == '@') {
                                    isMailSymbol = true;
                                    break;
                                  }
                                }
                                return (isMailSymbol && value.contains('.com')) ? null : 'Geçersiz E-posta';
                              },
                              onSaved: (newValue) {
                                _email = newValue!;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocusNode);
                              },
                              decoration: const InputDecoration(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 220,
                            height: 40,
                            child: TextFormField(
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
                        ),
                        Button(
                          text: 'Kayıt Ol',
                          color: Colors.blue.shade400,
                          onPressedOperations: () {

                            final isSuitable = formKey.currentState?.validate();
                            if (isSuitable == true) {
                              formKey.currentState?.save();

                              loginRepository.accounts.add(Account(
                                  name: _name,
                                  surname: _surname,
                                  email: _email,
                                  password: _password,
                              ));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(
                                      loginRepository: loginRepository,
                                      formKey: formKey,
                                    ),
                                  ));

                            }
                          },
                          width: 150,
                          height: 10,
                          textColor: Colors.black,
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
