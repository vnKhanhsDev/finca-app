import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_app/screens/main_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_app/screens/sign_in_screen.dart';
import 'package:date_field/date_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget{
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  String _selectedValue = 'Cá nhân';
  bool isFocused_n = false;
  bool isFocused_e = false;
  bool isFocused_p = false;
  bool isFocused_pn = false;
  bool isFocused_d = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  DateTime? selectedDate;
  final roleController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  @override
  void dispose(){
    roleController.dispose();
    nameController.dispose();
    phoneController.dispose();
    dateController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future signUp() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    addUser(
        _selectedValue,
        nameController.text.trim(),
        phoneController.text.trim(),
        selectedDate.toString(),
        emailController.text.trim()
    );
  }
  Future addUser(String role, String name, String phone, String dob, String email) async{
    await FirebaseFirestore.instance.collection('users').add({
      'role': role,
      'name': name,
      'phone': phone,
      'dob': dob,
      'email': email,
    });
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFE6ECFB), // Màu nền của nút
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.blueAccent, // Màu biểu tượng
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text.rich(
                  TextSpan(
                    text: 'Tạo', style: TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 34, fontWeight: FontWeight.bold), // default text style
                    children: <TextSpan>[
                      TextSpan(text: ' tài khoản', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent[700])),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Cá nhân', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _selectedValue == 'individual' ? Colors.blue : Colors.grey,),),
                        value: 'Cá nhân',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                            roleController.text = _selectedValue;
                          });
                        },
                        activeColor: Colors.blueAccent,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Cửa hàng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _selectedValue == 'shop' ? Colors.blue : Colors.grey,),),
                        value: 'Cửa hàng',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                            roleController.text = _selectedValue;
                          });
                        },
                        activeColor: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                            filled: true,
                            fillColor: Color(0xFFE6ECFB),
                            prefixIcon: Icon(Icons.person, color: isFocused_n ? Colors.black : Colors.grey,),
                            hintText: 'Họ và tên',
                            hintStyle: TextStyle(color: isFocused_n ? Colors.black : Colors.grey,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none
                            ),

                          ),
                          onTap: () {
                            setState(() {
                              isFocused_n = true;
                            });
                          },
                          validator: (val) => val.toString().length < 1 ? 'Hãy điền họ và tên' : null,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                            filled: true,
                            fillColor: Color(0xFFE6ECFB),
                            prefixIcon: Icon(Icons.phone, color: isFocused_pn ? Colors.black : Colors.grey,),
                            hintText: 'Số điện thoại',
                            hintStyle: TextStyle(color: isFocused_pn ? Colors.black : Colors.grey,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none
                            ),

                          ),
                          onTap: () {
                            setState(() {
                              isFocused_pn = true;
                            });
                          },
                          validator: (val) => val.toString().length < 1 ? 'Hãy điền số điện thoại' : null,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: DateTimeFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                            filled: true,
                            fillColor: Color(0xFFE6ECFB),
                            prefixIcon: Icon(Icons.cake, color: isFocused_d ? Colors.black : Colors.grey,),
                            hintText: 'Ngày sinh',
                            hintStyle: TextStyle(color: isFocused_d ? Colors.black : Colors.grey,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none
                            ),
                            suffixIcon: null,
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          onChanged: (DateTime? value) {
                            selectedDate = value;
                            dateController.text = selectedDate.toString();
                          },
                          onTap: () {
                            setState(() {
                              isFocused_d = true;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                            filled: true,
                            fillColor: Color(0xFFE6ECFB),
                            prefixIcon: Icon(Icons.email, color: isFocused_e ? Colors.black : Colors.grey,),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: isFocused_e ? Colors.black : Colors.grey,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none
                            ),

                          ),
                          onTap: () {
                            setState(() {
                              isFocused_e = true;
                            });
                          },
                          validator: (value) => EmailValidator.validate(value.toString()) ? null : "Hãy nhập email",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12, bottom: 28),
                        child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_obscured,
                          focusNode: textFieldFocusNode,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                            hintText: 'Mật khẩu',
                            hintStyle: TextStyle(color: isFocused_p ? Colors.black : Colors.grey,),
                            filled: true,
                            fillColor: Color(0xFFE6ECFB),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.lock_rounded,size: 24, color: isFocused_p ? Colors.black : Colors.grey,),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: GestureDetector(
                                onTap: _toggleObscured,
                                child: Icon(
                                  _obscured
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          validator: (val) => val.toString().length < 8 ? 'Mật khẩu phải chứa ít nhất 8 ký tự.' : null,
                          onTap: () {
                            setState(() {
                              isFocused_p = true;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        child:  ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          onPressed:(){
                            signUp();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                          },
                          child: Text('Đăng ký', style: TextStyle(color: Colors.white, fontSize: 20),),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 40),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10.0),
                                height: 1.0,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Text('Hoặc', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, backgroundColor: Colors.white,), textAlign: TextAlign.center,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: double.infinity,
                height: 40,
                child:SignInButton(
                  Buttons.Google,
                  text: "Tiếp tục với Google",
                  onPressed: () {},
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                child:SignInButton(
                  Buttons.FacebookNew,
                  text: "Tiếp tục với Facebook",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bạn đã có tài khoản?', style: TextStyle(color: Colors.grey),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                  }, child: Text('Đăng nhập', style: TextStyle(color: Colors.blueAccent),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}