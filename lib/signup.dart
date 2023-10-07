import 'package:flutter/material.dart';
import 'DatabaseHelper/dbhelper.dart';
import 'classes/user.dart';
import 'main.dart';

class SignUp extends StatefulWidget {

   SignUp({Key? key}) : super(key: key);
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool valuefirst = false;
  bool valuesecond = false;


  //TextEditing Controller
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  //Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Sign Up Page'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Container(
                  padding:  EdgeInsets.all(10),
                  child:  Text(
                    'FILL FOR SIGN UP',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                padding:  EdgeInsets.all(10),
                child:  TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.green,
                    ),

                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                  controller: firstNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding:  EdgeInsets.all(10),
                child:  TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                  controller: lastNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:  TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.lightBlue,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:  TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.lightBlue,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'password',
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:  TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.lightBlue,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Confirm password',
                  ),
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter confirm password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:  TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.lightBlue,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),

                  controller: phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
              ),


              Container(
                padding:  EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {

                    if(_formKey.currentState!.validate()){
                      if(passwordController.text==confirmPasswordController.text){
                        final name = firstNameController.text;
                        final lastName = lastNameController.text;
                        String fullName = name + ' ' + lastName;
                        User user = User(name: fullName, email: emailController.text ,password: passwordController.text, roll: 'Student', phone: phoneController.text);
                        final dbHelper = DatabaseHelper();
                        await dbHelper.openDatabase();
                        await dbHelper.insertUser(user);

                        print(dbHelper.getAllUser());
                      }
                      else{
                        print('Validation Failed');
                      }
                      print('Validation Successfull');
                    }
                    else{
                      print('Validation Failed');
                    }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>  MyApp()),
                    // );
                  },
                  child:  Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
