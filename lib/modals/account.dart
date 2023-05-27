class Account {
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String password;
  late final String photoUrl;

  Account({required this.firstName, required this.lastName, required this.email, required this.password, this.photoUrl = 'https://images.pexels.com/photos/16884742/pexels-photo-16884742/free-photo-of-sea-flight-dawn-sunset.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'});
}
