import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterMechanicScreen extends StatefulWidget{
  State<RegisterMechanicScreen> createState() => _RegisterMechanicScreenState();
}

class _RegisterMechanicScreenState extends State<RegisterMechanicScreen>{
  final addressController = TextEditingController();
  List<String> service = [];

  String selectedTimeStart = '00:00';
  String selectedTimeEnd = '00:00';
  String expValue = '1 năm';
  String vehicleValue = 'Xe máy';

  bool repairChecked = false;
  bool maintenanceChecked = false;
  bool beautyChecked = false;
  bool emergencyChecked = false;

  final user = FirebaseAuth.instance.currentUser!;
  QueryDocumentSnapshot? userData;

  Future registerMechanic() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get();
    userData = querySnapshot.docs.first;
    
    addMechanic(
        user.email.toString(),
        userData?['name'],
        userData?['phone'],
        addressController.text.trim(),
        selectedTimeStart,
        selectedTimeEnd,
        expValue,
        vehicleValue,
        service
    );

  }

  Future addMechanic(String email, String name, String phone, String address, String sTime, String eTime, String exp, String vehicle, List<String> service) async{
      await FirebaseFirestore.instance.collection('machanics').add({
        'email' : email,
        'name' : name,
        'phone' : phone,
        'address' : address,
        'sTime' : sTime,
        'eTime' : eTime,
        'exp' : exp,
        'vehicle' : vehicle,
        'service' : service,
      });
  }
  @override
  void dispose(){
    addressController.dispose();
    super.dispose();
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
                    child: Text('Đăng ký thợ sửa xe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Text('Địa chỉ làm việc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.only(top: 8, bottom: 12),
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      filled: true,
                      fillColor: Color(0xFFE6ECFB),
                      hintText: 'Yen Nghia - Ha Dong - Ha Noi',
                      hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only( top: 24),
                child: Text('Thời gian làm việc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child:DropdownButton<String>(
                        value: selectedTimeStart,

                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.blue, fontSize: 18.0),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTimeStart = newValue!;
                          });
                        },
                        items: <String>['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00',
                          '07:00', '08:00', '09:00', '10:00', '11:00', '12:00',
                          '13:00', '14:00', '15:00', '16:00', '17:00', '18:00',
                          '19:00', '20:00', '21:00', '22:00', '23:00']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text('  ${value}        '),
                          );
                        }).toList(),
                      ),
                  ),
                  Text('        -        '),
                  Expanded(
                    child:DropdownButton<String>(
                      value: selectedTimeEnd,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue, fontSize: 18.0),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTimeEnd = newValue!;
                        });
                      },
                      items: <String>['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00',
                        '07:00', '08:00', '09:00', '10:00', '11:00', '12:00',
                        '13:00', '14:00', '15:00', '16:00', '17:00', '18:00',
                        '19:00', '20:00', '21:00', '22:00', '23:00']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('  ${value}        '),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only( top: 24),
                          child: Text('Kinh nghiệm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 8, top: 24),
                        child: Text('Phương tiện', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child:DropdownButton<String>(
                      value: expValue,

                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue, fontSize: 18.0),
                      onChanged: (String? newValue) {
                        setState(() {
                          expValue = newValue!;
                        });
                      },
                      items: <String>['1 năm', '2 năm', '3 năm', 'Trên 3 năm']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('  ${value}'),
                        );
                      }).toList(),
                    ),
                  ),
                  Text('        -        '),
                  Expanded(
                    child:DropdownButton<String>(
                      value: vehicleValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue, fontSize: 18.0),
                      onChanged: (String? newValue) {
                        setState(() {
                          vehicleValue = newValue!;
                        });
                      },
                      items: <String>['Xe máy', 'Xe máy điện', 'Ô tô', 'Ô tô điện']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('  ${value}'),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Text('Dịch vụ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Sửa chữa', style: TextStyle(fontSize: 12,  fontWeight: FontWeight.normal),),
                      value: repairChecked,
                      onChanged: (bool? value){
                        setState(() {
                          repairChecked = value!;
                          if(repairChecked == true){
                            service.add('Sửa chữa');
                          }else{
                            int index = service.indexOf('Sửa chữa');
                            if (index != -1) {
                              service.remove('Sửa chữa');
                            }
                          }
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Bảo dưỡng', style: TextStyle(fontSize: 12,  fontWeight: FontWeight.normal),),
                      value: maintenanceChecked,
                      onChanged: (bool? value){
                        setState(() {
                          maintenanceChecked = value!;
                          if(maintenanceChecked == true){
                            service.add('Bảo dưỡng');
                          }else{
                            int index = service.indexOf('Bảo dưỡng');
                            if (index != -1) {
                              service.remove('Bảo dưỡng');
                            }
                          }
                        });
                      },
                      contentPadding: EdgeInsets.all(0),
                      activeColor: Colors.blueAccent,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: Text('Làm đẹp', style: TextStyle(fontSize: 12,  fontWeight: FontWeight.normal),),
                      value: beautyChecked,
                      onChanged: (bool? value){
                        setState(() {
                          beautyChecked = value!;
                          if(beautyChecked == true){
                            service.add('Làm đẹp');
                          }else{
                            int index = service.indexOf('Làm đẹp');
                            if (index != -1) {
                              service.remove('Làm đẹp');
                            }
                          }
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
                      title: Text('Khẩn cấp', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),),
                      value: emergencyChecked,
                      onChanged: (bool? value){
                        setState(() {
                          emergencyChecked = value!;
                          if(emergencyChecked == true){
                            service.add('Khẩn cấp');
                          }else{
                            int index = service.indexOf('Khẩn cấp');
                            if (index != -1) {
                              service.remove('Khẩn cấp');
                            }
                          }
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
        width: double.infinity,
        height: 40,
        margin: EdgeInsets.all(20),
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
            registerMechanic();
            setState(() {

            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Đăng ký thành công'),
                  content: Text('Thông tin của bạn đã được đăng ký thành công.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        // Đóng hộp thoại
                        Navigator.of(context).pop();
                        // Điều hướng về trang chủ
                        Navigator.of(context).pop();
                      },
                      child: Text('OK', style: TextStyle(color: Colors.blueAccent),),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Đăng ký', style: TextStyle(color: Colors.white, fontSize: 18),),
        ),
      ),
    );
  }
}