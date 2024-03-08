import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/read_data/get_user_name.dart';

class HomePage extends StatefulWidget{
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final List<String> imageList = [
    'assets/images/home_carousel_1.jpg',
    'assets/images/home_carousel_2.jpg',
    'assets/images/home_carousel_3.jpg',
  ];
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docId = [];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get().then(
          (snapshot) => snapshot.docs.forEach((element) {
        docId.add(element.reference.id);
      }),
    );
  }
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueAccent[700],
                      child: Padding(
                        padding: const EdgeInsets.all(4), // Border radius
                        child: ClipOval(child: Image.asset('assets/images/avatar_test.png')),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text('Xin chào,'),
                        ),
                        Container(
                          margin:  EdgeInsets.only(left: 12),
                          child: FutureBuilder(
                            future: getDocId(),
                            builder: (context, snapshot){
                              return GetUserName(documentId: docId[0]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Badge(label: Text('2'), child: Icon(Icons.message_rounded, color: Colors.white,)),
                  ),
                  color: Colors.blueAccent[700],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 8),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
                items: imageList.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 8),
                  child: Text('Tính năng chính', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                ),
                color: Color(0xFFE6ECFB),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFE6ECFB), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 110,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.search, color: Colors.blueAccent[700],),
                                Text('Tìm kiếm', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  ),
                  Expanded(child: InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFE6ECFB), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 110,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.create, color: Colors.blueAccent[700],),
                                Text('Đăng tin', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  ),
                  Expanded(child: InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFE6ECFB), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 110,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.date_range, color: Colors.blueAccent[700],),
                                Text('lịch hẹn', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFE6ECFB), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 110,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.two_wheeler, color: Colors.blueAccent[700],),
                                Text('Phương tiện', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),),
                  Expanded(child: InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFE6ECFB), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 110,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.handyman, color: Colors.blueAccent[700],),
                                Text('Đăng ký', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                                Text('Thợ sửa xe', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),),
                  Expanded(child: InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFE6ECFB), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 110,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.menu_rounded, color: Colors.blueAccent[700],),
                                Text('Tện ích', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 8),
                  child: Text('Mở rộng', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                ),
                color: Color(0xFFE6ECFB),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){

                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFFE6ECFB), width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: 110,
                          height: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.miscellaneous_services, color: Colors.blueAccent[700],),
                                  Text('Dịch vụ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                                  Text('cung cấp', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                                ],
                              )
                            ],
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),),
                  Expanded(flex: 1,child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFFE6ECFB), width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: 110,
                          height: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.notifications_active, color: Colors.blueAccent[700],),
                                  Text('Thông báo', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                                  Text('tin tìm kiếm', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                                ],
                              )
                            ],
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),),
                  Expanded(child: Text(''),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}