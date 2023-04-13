
class LoginRepository {

  List<Account> accounts = [
    Account(name: 'Ahmet',surname: 'Erdem',email: 'deneme@gmail.com',password: 'Giris123'),
    Account(name: 'Saliha', surname: 'Çakmak', email: 'deneme@hotmail.com', password: 'Giris123'),
  ];


}

class Account{

  final String name;
  final String surname;
  final String email;
  final String password;

  Account({required this.name, required this.surname, required this.email, required this.password});
}