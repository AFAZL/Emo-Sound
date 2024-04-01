import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/services/auth_service.dart';
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
        iconTheme: IconThemeData(color: Color(0xFF242d5c)),
        title: Text(
          'Sign Up',
          style: TextStyle(color: Color(0xFF242d5c)),
        ),
        backgroundColor: Color(0xFF51cffa),
      ),
      backgroundColor: Color(0xFF242d5c), // Set the background color of the Scaffold
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Image.asset(
                  'assets/images/signuplogo.png', // Change the image path as per your asset
                  height: 400, // Adjust the height of the image as needed
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
                        controller: _name,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          fillColor: Colors.white, // Set the text field background color to white
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _surname,
                        decoration: InputDecoration(
                          labelText: 'Surname',
                          filled: true,
                          fillColor: Colors.white, // Set the text field background color to white
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
                              fillColor: Colors.white, // Set the text field background color to white
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
                          fillColor: Colors.white, // Set the text field background color to white
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white, // Set the text field background color to white
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white, // Set the text field background color to white
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          filled: true,
                          fillColor: Colors.white, // Set the text field background color to white
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF51cffa)),
                        onPressed: () async {
                          // Button onPressed logic
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
