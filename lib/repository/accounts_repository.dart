import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlefont/modals/account.dart';

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


