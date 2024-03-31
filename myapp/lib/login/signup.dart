import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/services/CRUD.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(color: Color.fromARGB(255, 241, 241, 241))),
        backgroundColor: Color.fromARGB(255, 79, 39, 181),
      ),
      body: Center(
        child: Container(
          width: 350,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _surname,
                  decoration: InputDecoration(
                    labelText: 'Surname',
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
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 79, 39, 181)),
                  onPressed: () async {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    String confirmPassword = _confirmPasswordController.text.trim();
                    DateTime? dob;
                    if (_dobController.text.isNotEmpty) {
                      dob = DateTime.parse(_dobController.text.trim());
                    }
                    String gender = _genderController.text.trim();
                    String name = _name.text.trim();
                    String surname = _surname.text.trim();

                    // Perform validations
                    if (password != confirmPassword) {
                      Fluttertoast.showToast(msg: 'Passwords do not match');
                      return;
                    }
                    if (!['MALE', 'FEMALE', 'OTHER'].contains(gender.toUpperCase())) {
                      Fluttertoast.showToast(msg: 'Invalid gender');
                      return;
                    }

                    User1? user = await _authService.registerWithEmailAndPassword(email, password);
                    print(user);
                    if (user != null) {
                      createUser(name, surname, email, dob, gender);
                      Navigator.pushReplacementNamed(context, '/');
                    } else {
                      Fluttertoast.showToast(msg: 'An Error Occurred');
                    }
                  },
                  child: Text('Sign Up', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
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
