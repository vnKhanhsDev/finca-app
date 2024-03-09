import 'package:flutter/material.dart';

class VerhicleScreen extends StatefulWidget{
  State<VerhicleScreen> createState() => _VerhicleScreenState();
}

class _VerhicleScreenState extends State<VerhicleScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                    child: Text('Phương tiện', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                width: double.infinity,
                child: InkWell(
                  onTap: (){

                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side:  BorderSide(color: Color(0xFFE6ECFB), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0), // Thêm padding 8px cho toàn bộ phần nội dung của Card
                            child: Icon(Icons.motorcycle, size: 30, color: Colors.blueAccent,),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Xe máy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                              Text('Tên xe: Honda Wave', style: TextStyle(fontSize: 14, color: Colors.grey)),
                              Text('Biển kiểm soát: 29V1-12345', style: TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    color: Color(0xFFE6ECFB),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                width: double.infinity,
                child: InkWell(
                  onTap: (){

                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side:  BorderSide(color: Color(0xFFE6ECFB), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0), // Thêm padding 8px cho toàn bộ phần nội dung của Card
                            child: Icon(Icons.directions_car, size: 30, color: Colors.blueAccent,),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ô tô', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                              Text('Tên xe: Huyndai Tucson', style: TextStyle(fontSize: 14, color: Colors.grey)),
                              Text('Biển kiểm soát: 29V1-99999', style: TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    color: Color(0xFFE6ECFB),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Xử lý sự kiện khi nút được nhấn
          print('Add button pressed');
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}