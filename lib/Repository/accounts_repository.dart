import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountRepository extends ChangeNotifier{

  late Account manager;

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


final accountProvider = ChangeNotifierProvider((ref) {
  return AccountRepository();
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
