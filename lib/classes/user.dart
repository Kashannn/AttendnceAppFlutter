class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String roll;
  final String phone;
  final String imagePath;

  User( {

    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.roll,
    required this.phone,
    this.imagePath = 'assets/images/logo.png',
  });

  //From Json
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
    roll: json['roll'],
    phone: json['phone'],
    imagePath: json['imagePath'],
  );


}