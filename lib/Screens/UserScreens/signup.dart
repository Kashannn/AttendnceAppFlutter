import 'package:flutter/material.dart';
import '../../DatabaseHelper/dbhelper.dart';
import '../../classes/user.dart';
import 'login.dart';
import '../../main.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // TextEditing Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'FILL FOR SIGN UP',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              buildTextFormField(
                controller: firstNameController,
                label: 'First Name',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                controller: lastNameController,
                label: 'Last Name',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                controller: emailController,
                label: 'Email',
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                controller: passwordController,
                label: 'Password',
                prefixIcon: Icons.lock,
                isPassword: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                prefixIcon: Icons.lock,
                isPassword: true,
                validator: (value) {
                  if (value!.isEmpty || value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              buildTextFormField(
                controller: phoneController,
                label: 'Phone Number',
                prefixIcon: Icons.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final name = firstNameController.text;
                      final lastName = lastNameController.text;
                      String fullName = name + ' ' + lastName;
                      User user = User(
                        name: fullName,
                        email: emailController.text,
                        password: passwordController.text,
                        roll: 'Student',
                        phone: phoneController.text,
                      );

                      final dbHelper = DatabaseHelper();
                      await dbHelper.openDatabase();
                      await dbHelper.insertUser(user);

                      print(dbHelper.getAllUser());

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    } else {
                      print('Validation Failed');
                    }
                  },
                  child: Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create TextFormFields
  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    bool isPassword = false,
    required String? Function(String?) validator,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.lightBlue,
          ),
          border: OutlineInputBorder(),
          labelText: label,
        ),
        controller: controller,
        validator: validator,
      ),
    );
  }
}
