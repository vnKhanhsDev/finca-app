import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignUpScreen extends StatefulWidget{
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  String _selectedValue = 'individual';
  bool isFocused_e = false;
  bool isFocused_p = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  @override
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
                        value: 'individual',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                        activeColor: Colors.blueAccent,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Cửa hàng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _selectedValue == 'shop' ? Colors.blue : Colors.grey,),),
                        value: 'shop',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
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
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscured,
                          focusNode: textFieldFocusNode,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: isFocused_p ? Colors.black : Colors.grey,),
                            filled: true, // Needed for adding a fill color
                            fillColor: Color(0xFFE6ECFB),
                            isDense: true,  // Reduces height a bit
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,              // No border
                              borderRadius: BorderRadius.circular(12),  // Apply corner radius
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
                          onPressed: () {

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
                                margin: EdgeInsets.only(top: 10.0), // Điều chỉnh độ cao của kẻ ngang
                                height: 1.0,
                                color: Colors.grey, // Màu của kẻ ngang
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
                width: double.infinity,
                child:SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}