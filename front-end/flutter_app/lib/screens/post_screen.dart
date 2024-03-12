import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool mechanicChecked = false;
  bool shopChecked = false;
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin:  EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: Text('Đăng tin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
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
                margin: EdgeInsets.only(top: 24),
                child: Text('Gửi tới', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Thợ sửa chữa', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),),
                      value: mechanicChecked,
                      onChanged: (bool? value){
                        setState(() {
                          mechanicChecked = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Cửa hàng sửa chữa', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),),
                      value: shopChecked,
                      onChanged: (bool? value){
                        setState(() {
                          shopChecked = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: Text('Nội dung tin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all( 20.0),
                    filled: true,
                    fillColor: Color(0xFFE6ECFB),
                    hintText: 'Nhập nội dung....',
                    hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none
                    ),
                  ),
                  maxLines: 10,
                ),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Text('Thêm vào tin của bạn', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ),
                    ),
                    Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.image, color: Colors.green, size: 26,),
                              ),
                              IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.person, color: Colors.blueAccent, size: 26,),
                              ),
                              IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.location_on, color: Colors.redAccent, size: 26,),
                              ),
                              IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.emoji_emotions, color: Colors.yellowAccent, size: 26,),
                              ),
                            ],
                          ),
                        ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
          child: Text('Đăng tin', style: TextStyle(color: Colors.blueAccent, fontSize: 18),),
        ),
      ),
    );
  }
}
