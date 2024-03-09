import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget{
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>{
  bool repairChecked = false;
  bool maintenanceChecked = false;
  bool beautyChecked = false;
  bool emergencyChecked = false;

  bool mechanicChecked = false;
  bool shopChecked = false;

  String locationValue = 'Hiện tại';

  bool carChecked = false;
  bool eCarChecked =false;
  bool motorbikeChecked = false;
  bool eMotorbikeChecked = false;
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
                    child: Text('Tìm kiếm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 12),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    filled: true,
                    fillColor: Color(0xFFE6ECFB),
                    prefixIcon: Icon(Icons.search, color: Colors.grey,),
                    hintText: 'Tên cửa hàng',
                    hintStyle: TextStyle(color: Colors.grey,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none
                    ),

                  ),
                ),
              ),
              Container(
                child: Text('Dịch vụ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              Row(
                children: [
                  Expanded(
                      child: CheckboxListTile(
                        title: Text('Sửa chữa', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
                        value: repairChecked,
                        onChanged: (bool? value){
                          setState(() {
                            repairChecked = value!;
                          });
                        },
                        contentPadding: EdgeInsets.all(0),
                        activeColor: Colors.blueAccent,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Bảo dưỡng', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
                      value: maintenanceChecked,
                      onChanged: (bool? value){
                        setState(() {
                          maintenanceChecked = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Làm đẹp', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
                      value: beautyChecked,
                      onChanged: (bool? value){
                        setState(() {
                          beautyChecked = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Khẩn cấp', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
                      value: emergencyChecked,
                      onChanged: (bool? value){
                        setState(() {
                          emergencyChecked = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: Text(''),
                  ),
                  Expanded(
                    child: Text(''),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: Text('Dối tượng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Thợ sửa chữa', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
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
                      title: Text('Cửa hàng sửa chữa', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
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
                child: Text('Vị trí', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Vị trí hiện tại', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey,),),
                      value: 'Hiện tại',
                      groupValue: locationValue,
                      onChanged: (value) {
                        setState(() {
                          locationValue = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('Chọn trên bản đồ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey,),),
                      value: 'Bản đồ',
                      groupValue: locationValue,
                      onChanged: (value) {
                        setState(() {
                          locationValue = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: Text('Phương tiện', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Ô tô', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
                      value: carChecked,
                      onChanged: (bool? value){
                        setState(() {
                          carChecked = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Ô tô điện', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
                      value: eCarChecked,
                      onChanged: (bool? value){
                        setState(() {
                          eCarChecked = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Xe máy', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
                      value: motorbikeChecked,
                      onChanged: (bool? value){
                        setState(() {
                          motorbikeChecked = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Xe máy điện', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.normal),),
                      value: eMotorbikeChecked,
                      onChanged: (bool? value){
                        setState(() {
                          eMotorbikeChecked = value!;
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: Text(''),
                  ),
                  Expanded(
                    child: Text(''),
                  )
                ],
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
          child: Text('Tìm kiếm', style: TextStyle(color: Colors.blueAccent, fontSize: 18),),
        ),
      ),
    );
  }
}