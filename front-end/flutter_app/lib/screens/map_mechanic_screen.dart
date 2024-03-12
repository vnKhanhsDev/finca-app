import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MapMechanicScreen extends StatefulWidget{
  State<MapMechanicScreen> createState() => _MapMechanicScreenState();
}

class _MapMechanicScreenState extends State<MapMechanicScreen>{
  late AlignOnUpdate _alignPositionOnUpdate;
  late final StreamController<double?> _alignPositionStreamController;
  final Location location = Location();

  bool _loading = false;

  var _location;
  String? _error;
  var l1 = 0.0;
  var l2 = 0.0;
  Future<void> _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final locationResult = await location.getLocation();
      setState(() {
        _location = locationResult;
        l1 = locationResult.latitude!;
        l2 = locationResult.longitude!;
        _loading = false;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
        _loading = false;
      });
    }
  }

  List<QueryDocumentSnapshot> data = [];
  Future getData() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('machanics').get();
    data.addAll(querySnapshot.docs);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    _getLocation();
    _alignPositionOnUpdate = AlignOnUpdate.always;
    _alignPositionStreamController = StreamController<double?>();
  }

  @override
  void dispose() {
    _alignPositionStreamController.close();
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
                    child: Text('Kết quả tìm kiếm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Text('Chọn vị chí để hiển thị thông tin thợ sửa xe', style: TextStyle(fontSize: 14, color: Colors.grey),),
              ),
              Container(
                width: double.infinity,
                height: 600,
                margin: EdgeInsets.only(top: 24, bottom: 20),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: const LatLng(0, 0),
                    initialZoom: 16,
                    minZoom: 0,
                    maxZoom: 19,
                    // Stop aligning the location marker to the center of the map widget
                    // if user interacted with the map.
                    onPositionChanged: (MapPosition position, bool hasGesture) {
                      if (hasGesture && _alignPositionOnUpdate != AlignOnUpdate.never) {
                        setState(
                              () => _alignPositionOnUpdate = AlignOnUpdate.never,
                        );
                      }
                    },
                  ),
                  // ignore: sort_child_properties_last
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName:
                      'net.tlserver6y.flutter_map_location_marker.example',
                      maxZoom: 19,
                    ),
                    CurrentLocationLayer(
                      alignPositionStream: _alignPositionStreamController.stream,
                      alignPositionOnUpdate: _alignPositionOnUpdate,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(l1-0.001, l2+0.0005),
                          width: 80,
                          height: 80,
                          child: IconButton(
                            icon: Icon(Icons.location_on, color: Colors.red, size: 40,),
                            onPressed: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (buider){
                                    return Container(
                                      width: double.infinity,
                                      height: 300,
                                      child: Container(
                                        margin: EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text('Thợ sửa ${data[0]['name']}', style: TextStyle(fontSize: 20, color: Colors.blueAccent),),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 12 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.home, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Địa chỉ: ${data[0]['address']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.phone, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('SĐT: ${data[0]['phone']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.tire_repair, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Dịch vụ: ${data[0]['service']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                        Marker(
                          point: LatLng(l1+0.001, l2-0.001),
                          width: 80,
                          height: 80,
                          child: IconButton(
                            icon: Icon(Icons.location_on, color: Colors.red, size: 40,),
                            onPressed: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (buider){
                                    return Container(
                                      width: double.infinity,
                                      height: 300,
                                      child: Container(
                                        margin: EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text('${data[1]['name']}', style: TextStyle(fontSize: 20, color: Colors.blueAccent),),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 12 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.home, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Địa chỉ: ${data[1]['address']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.phone, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('SĐT: ${data[1]['phone']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.tire_repair, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Dịch vụ: ${data[1]['service']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                        Marker(
                          point: LatLng(l1+0.001, l2+0.002),
                          width: 80,
                          height: 80,
                          child: IconButton(
                            icon: Icon(Icons.location_on, color: Colors.red, size: 40,),
                            onPressed: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (buider){
                                    return Container(
                                      width: double.infinity,
                                      height: 300,
                                      child: Container(
                                        margin: EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text('${data[2]['name']}', style: TextStyle(fontSize: 20, color: Colors.blueAccent),),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 12 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.home, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Địa chỉ: ${data[2]['address']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.phone, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('SĐT: ${data[2]['phone']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.tire_repair, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Dịch vụ: ${data[2]['service']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                        Marker(
                          point: LatLng(l1-0.002, l2+0.002),
                          width: 80,
                          height: 80,
                          child: IconButton(
                            icon: Icon(Icons.location_on, color: Colors.red, size: 40,),
                            onPressed: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (buider){
                                    return Container(
                                      width: double.infinity,
                                      height: 300,
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Text('${data[3]['name']}', style: TextStyle(fontSize: 20, color: Colors.blueAccent),),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 12 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.home, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Địa chỉ: ${data[3]['address']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.phone, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('SĐT: ${data[3]['phone']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.tire_repair, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Dịch vụ: ${data[3]['service']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                        Marker(
                          point: LatLng(l1-0.002, l2-0.002),
                          width: 80,
                          height: 80,
                          child: IconButton(
                            icon: Icon(Icons.location_on, color: Colors.red, size: 40,),
                            onPressed: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (buider){
                                    return Container(
                                      width: double.infinity,
                                      height: 300,
                                      child: Container(
                                        margin: EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Container(

                                              child: Text('${data[4]['name']}', style: TextStyle(fontSize: 20, color: Colors.blueAccent),),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 12 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.home, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Địa chỉ: ${data[4]['address']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.phone, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('SĐT: ${data[4]['phone']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8 , bottom: 8),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.tire_repair, size: 30, color:  Colors.blue,),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 8),
                                                    child: Text('Dịch vụ: ${data[4]['service']}', style: TextStyle(fontSize: 14),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            // Align the location marker to the center of the map widget
                            // on location update until user interact with the map.
                            setState(
                                  () => _alignPositionOnUpdate = AlignOnUpdate.always,
                            );
                            // Align the location marker to the center of the map widget
                            // and zoom the map to level 18.
                            _alignPositionStreamController.add(18);
                          },
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.white,
                          ),
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
    );
  }
}