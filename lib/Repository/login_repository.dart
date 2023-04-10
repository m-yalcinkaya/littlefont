
class LoginRepository {

  List<Account> accounts = [
    Account(name: 'Ali',surname: 'Yalcinkaya',email: 'mustafa_meryem_09@gmail.com',password: '123456'),
    Account(name: 'Mustafa', surname: 'Yalçinkaya', email: '548mustafa@gmail.com', password: 'Mustafa123'),
  ];


}

class Account{

  final String name;
  final String surname;
  final String email;
  final String password;

  Account({required this.name, required this.surname, required this.email, required this.password});
}