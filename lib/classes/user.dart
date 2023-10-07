class User {
  final String name;
  final String email;
  final String password;
  final String roll;
  final String phone;

  User( {
    required this.name,
    required this.email,
    required this.password,
    required this.roll,
    required this.phone,
  });

  //From Json
  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'],
    email: json['email'],
    password: json['password'],
    roll: json['roll'],
    phone: json['phone'],
  );


  //from map
  factory User.fromMap(Map<String, dynamic> json) => User(
    name: json['name'],
    email: json['email'],
    password: json['password'],
    roll: json['roll'],
    phone: json['phone'],
  );

}