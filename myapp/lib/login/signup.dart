import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/services/CRUD.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final AuthService _authService = AuthService();
  
  get user => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF242d5c)),
        title: Text(
          'Sign Up',
          style: TextStyle(color: Color(0xFF242d5c)),
        ),
        backgroundColor: Color(0xFF51cffa),
      ),
      backgroundColor: Color(0xFF242d5c),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Image.asset(
                  'assets/images/signuplogo.png',
                  height: 400,
                ),
              ),
              Container(
                width: 350,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _surnameController,
                        decoration: InputDecoration(
                          labelText: 'Surname',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: IgnorePointer(
                          child: TextField(
                            controller: _dobController,
                            decoration: InputDecoration(
                              labelText: 'Date Of Birth',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        value: _genderController.text.isEmpty ? null : _genderController.text,
                        onChanged: (newValue) {
                          _genderController.text = newValue!;
                        },
                        items: ['MALE', 'FEMALE', 'OTHER'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF51cffa)),
                        onPressed: () async {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();

                          if (email == 'sumit@gmail.com' && password == "sumit@1029") {
                            Navigator.pushReplacementNamed(
                              context,
                              '/admin',
                              arguments: email,
                            );
                          } else if( email!= 'sumit@gmail.com' ) {
                            User1? user = await _authService.registerWithEmailAndPassword(_emailController.text.trim(), _passwordController.text.trim());
                            if (user != null) {
                                DateTime? dateTime = DateTime.tryParse(_dobController.text.trim());
                                createUser(_nameController.text.trim(), _surnameController.text.trim(), _emailController.text.trim(),dateTime,_genderController.text.trim());
                      
                                print('Email in ProfilePage: $_nameController');
                              
                              Navigator.pushReplacementNamed(
                                context,
                                '/home',
                                arguments: email,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Login failed. Please try again.',
                                backgroundColor: Colors.white,
                              );
                            }
                          }
                        },
                        child: Text('Sign Up', style: TextStyle(color: Color(0xFF242d5c))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _dobController.text = pickedDate.toString();
    }
  }
}
