import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/Screens/AboutPage/about_page_index.dart';

class LoginRepository extends ChangeNotifier{
  List<Account> accounts = [
    Account(
        name: 'Ahmet',
        surname: 'Erdem',
        email: 'deneme@gmail.com',
        password: 'Giris123'),
    Account(
        name: 'Saliha',
        surname: 'Çakmak',
        email: 'deneme@hotmail.com',
        password: 'Giris123'),
  ];
}

final loginProvider = ChangeNotifierProvider((ref) {
  return LoginRepository();
});

class Account {
  final String name;
  final String surname;
  final String email;
  final String password;

  Account(
      {required this.name,
      required this.surname,
      required this.email,
      required this.password});
}
