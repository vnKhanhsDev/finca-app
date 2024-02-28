import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_app/screens/sign_up_screen.dart';
import 'package:flutter_app/screens/sign_in_screen.dart';
class CarouselScreen extends StatefulWidget{
  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen>{
  final List<String> imageList = [
    'assets/images/carousel_screen.png',
    'assets/images/carousel_screen.png',
    'assets/images/carousel_screen.png',
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 8),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 600.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),

                      child: Column(
                        children: [
                          Image.asset('assets/images/carousel_screen.png', fit: BoxFit.cover,),
                          Container(
                            margin: EdgeInsets.only(left: 12, right: 12),
                            child: Text.rich(
                              TextSpan(
                                text: 'Tìm kiếm dịch vụ', style: TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 26,), // default text style
                                children: <TextSpan>[
                                  TextSpan(text: ' sửa xe ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent[700])),
                                  TextSpan(text: 'dễ dàng', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16, top:16),
                            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              style: TextStyle(fontSize: 14, decoration: TextDecoration.none, color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),

                      child: Column(
                        children: [
                          Image.asset('assets/images/carousel_screen.png', fit: BoxFit.cover,),
                          Container(
                            margin: EdgeInsets.only(left: 12, right: 12),
                            child: Text.rich(
                              TextSpan(
                                text: 'Lên lịch hẹn', style: TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 26,), // default text style
                                children: <TextSpan>[
                                  TextSpan(text: ' bảo dưỡng ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent[700])),
                                  TextSpan(text: 'nhanh chóng', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              style: TextStyle(fontSize: 14, decoration: TextDecoration.none, color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),

                      child: Column(
                        children: [
                          Image.asset('assets/images/carousel_screen.png', fit: BoxFit.cover,),
                          Container(
                            margin: EdgeInsets.only(left: 12, right: 12),
                            child: Text.rich(
                              TextSpan(
                                text: 'Đăng ký và cung cấp', style: TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 26,), // default text style
                                children: <TextSpan>[
                                  TextSpan(text: ' dịch vụ ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent[700])),
                                  TextSpan(text: 'thuận tiện', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16, top:16),
                            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              style: TextStyle(fontSize: 14, decoration: TextDecoration.none, color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DotsIndicator(
                dotsCount: imageList.length,
                position: currentIndex.toDouble(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  activeColor: Colors.blueAccent[700],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 120, // Chiều cao của Container chứa cột button
        padding: EdgeInsets.all(10), // Padding để tạo khoảng cách từ mép
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text('Tạo tài khoản', style: TextStyle(color: Colors.blueAccent, fontSize: 18),),
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: Text('Đăng nhập', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}