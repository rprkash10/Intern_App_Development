import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle
import 'package:login_signup_screen/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isPasswordVisible = false; // State variable to toggle password visibility
  bool _isConfirmPasswordVisible = false; // State variable to toggle confirm password visibility

  final _formKey = GlobalKey<FormState>(); // Key for form validation

  String? _selectedGender; // State variable for gender selection

  // TextEditingController for each field
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // FocusNodes for each field
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    // Dispose controllers and focus nodes to prevent memory leaks
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  // Validation functions
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Enter a valid phone number (only digits)';
    } else if (value.length < 10 || value.length > 10) {
      return 'Phone number should be 10 digits';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40), // Adjusted padding for better UI
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Image.network(
                    'https://i.pinimg.com/originals/a1/c2/50/a1c250ea784c58e25c5f64515dad7529.gif',
                    height: 150,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Create an account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700] ?? Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                inputFile(
                  hintText: "First Name",
                  controller: _firstNameController,
                  validator: _validateName,
                  focusNode: _firstNameFocusNode,
                  nextFocusNode: _lastNameFocusNode,
                ),
                SizedBox(height: 10),
                inputFile(
                  hintText: "Last Name",
                  controller: _lastNameController,
                  validator: _validateName,
                  focusNode: _lastNameFocusNode,
                  nextFocusNode: _usernameFocusNode,
                ),
                SizedBox(height: 10),
                inputFile(
                  hintText: "Username",
                  controller: _usernameController,
                  validator: _validateUsername,
                  focusNode: _usernameFocusNode,
                  nextFocusNode: _emailFocusNode,
                ),
                SizedBox(height: 10),
                inputFile(
                  hintText: "Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  focusNode: _emailFocusNode,
                  nextFocusNode: _addressFocusNode,
                ),
                SizedBox(height: 10),
                genderDropdown(),
                SizedBox(height: 10),
                dateOfBirthField(context),
                SizedBox(height: 10),
                inputFile(
                  hintText: "Address",
                  controller: _addressController,
                  validator: _validateAddress,
                  focusNode: _addressFocusNode,
                  nextFocusNode: _phoneFocusNode,
                ),
                SizedBox(height: 10),
                inputFile(
                  hintText: "Phone Number",
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhoneNumber,
                  focusNode: _phoneFocusNode,
                  nextFocusNode: _passwordFocusNode,
                ),
                SizedBox(height: 10),
                inputFile(
                  hintText: "Password",
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  onTapSuffix: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  suffixIcon: _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  validator: _validatePassword,
                  focusNode: _passwordFocusNode,
                  nextFocusNode: _confirmPasswordFocusNode,
                ),
                SizedBox(height: 10),
                inputFile(
                  hintText: "Confirm Password",
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  onTapSuffix: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                  suffixIcon: _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  validator: _validateConfirmPassword,
                  focusNode: _confirmPasswordFocusNode,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 150, // Adjusted width
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0095FF), // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Form is valid
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Signing up...')),
                          );
                        }
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        // Navigate to login page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()), // Replace LoginPage with your actual login page class
                        );
                      },
                      child: Text(
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xff0095FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for text field with placeholder (hintText) and focus handling
  Widget inputFile({
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
    IconData suffixIcon = Icons.visibility,
    VoidCallback? onTapSuffix,
    TextInputType keyboardType = TextInputType.text,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          focusNode: focusNode,
          textInputAction: nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
          onFieldSubmitted: (_) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey),
            ),
            hintText: hintText, // Adding hint text here
            suffixIcon: onTapSuffix != null
                ? GestureDetector(
              onTap: onTapSuffix,
              child: Icon(suffixIcon),
            )
                : null,
          ),
          validator: validator,
        ),
      ],
    );
  }

  // Widget for gender dropdown with validation
  Widget genderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownButtonFormField<String>(
          value: _selectedGender,
          items: ["Male", "Female", "Other"]
              .map((gender) => DropdownMenuItem(
            value: gender,
            child: Text(gender),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey),
            ),
            hintText: "Select your gender", // Adding hint text here
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your gender';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Widget for date of birth field with validation
  Widget dateOfBirthField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _dobController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400] ?? Colors.grey),
            ),
            hintText: "Select your date of birth", // Adding hint text here
          ),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode()); // To prevent opening the keyboard
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              _dobController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your date of birth';
            }
            return null;
          },
        ),
      ],
    );
  }
}
