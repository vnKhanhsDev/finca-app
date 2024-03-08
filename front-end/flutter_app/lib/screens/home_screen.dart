import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/read_data/get_user_name.dart';
import 'package:flutter_app/widgets/home_page.dart';
import 'package:flutter_app/widgets/setting.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Business',
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.notifications_sharp),
              title: Text('Notification 1'),
              subtitle: Text('This is a notification'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.notifications_sharp),
              title: Text('Notification 2'),
              subtitle: Text('This is a notification'),
            ),
          ),
        ],
      ),
    ),
    Setting(),
  ];
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
  return Scaffold(

    body: SingleChildScrollView(
      child: _widgetOptions.elementAt(_selectedIndex),
    ),
    bottomNavigationBar:  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Trang chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Đã lưu',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Thông báo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Cài đặt',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blueAccent[700],
      onTap: _onItemTapped,
    ),
  );
  }
}