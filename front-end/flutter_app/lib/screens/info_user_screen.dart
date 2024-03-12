import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoUserScreen extends StatefulWidget {
  const InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  QueryDocumentSnapshot? userData;
  final user = FirebaseAuth.instance.currentUser!;
  Future getData() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get();
    userData = querySnapshot.docs.first;
    setState(() {

    });
  }
  @override
  void initState(){
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String? dob = userData?['dob'];
    String? date = dob?.substring(0,10);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFE6ECFB), // Màu nền của nút
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.blueAccent,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text('Thông tin cá nhân', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFE6ECFB), // Màu nền của nút
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 26),
                child:CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueAccent[700],
                  child: Padding(
                    padding: const EdgeInsets.all(0), // Border radius
                    child: ClipOval(child: Image.asset('assets/images/avatar_test.png')),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text('Thông tin cơ bản', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Expanded(child: Text('HỌ TÊN', style: TextStyle(fontSize: 16, color: Colors.grey,),)),
                    Expanded(child: Text('NGÀY SINH', style: TextStyle(fontSize: 16, color: Colors.grey,),)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Expanded(child: Text('${userData?['name']}', style: TextStyle(fontSize: 16, color: Colors.black,),)),
                    Expanded(child: Text('${date}', style: TextStyle(fontSize: 16, color: Colors.black,),)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Expanded(child: Text('TÊN NGƯỜI DÙNG', style: TextStyle(fontSize: 16, color: Colors.grey,),)),
                    Expanded(child: Text('GIỚI TÍNH', style: TextStyle(fontSize: 16, color: Colors.grey,),)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Expanded(child: Text('${userData?['name']}', style: TextStyle(fontSize: 16, color: Colors.black,),)),
                    Expanded(child: Text('${userData?['gender']}', style: TextStyle(fontSize: 16, color: Colors.black,),)),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 16),
                child: Text('ĐỊA CHỈ', style: TextStyle(fontSize: 16, color: Colors.grey),),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 4),
                child: Text('Yên Nghĩa - Hà Đông - Hà Nội', style: TextStyle(fontSize: 16, color: Colors.black),),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text('Thông tin liên hệ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 16),
                child: Text('ĐỊA CHỈ EMAIL', style: TextStyle(fontSize: 16, color: Colors.grey),),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 4),
                child: Text('${userData?['email']}', style: TextStyle(fontSize: 16, color: Colors.black),),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 16),
                child: Text('SỐ ĐIỆN THOẠI', style: TextStyle(fontSize: 16, color: Colors.grey),),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 4),
                child: Text('${userData?['phone']}', style: TextStyle(fontSize: 16, color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Container(
        margin: EdgeInsets.only(bottom: 12, right: 20, left: 20),
        height: 40,
        width: double.infinity,
        child:  ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.blueAccent), // Màu và độ dày của viền
              ),
            ),
          ),
          onPressed: () {

          },
          child: Text('Cập nhật', style: TextStyle(color: Colors.blueAccent, fontSize: 18),),
        ),
      ),
    );
  }
}
