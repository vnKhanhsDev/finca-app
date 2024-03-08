import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget{
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting>{

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
        child: Column(
          children: [
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
                    FirebaseAuth.instance.signOut();
                },
                child: Text('Đăng xuất', style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}