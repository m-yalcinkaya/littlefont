class Account {
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String password;
  late final String? photoUrl;

  Account({required this.firstName, required this.lastName, required this.email, required this.password, this.photoUrl});
}
