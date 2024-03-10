import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget{
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>{



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
                    child: Text('Bản đồ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  )
                ],
              ),
              FlutterMap(
                  options: MapOptions(
                    center: LatLng(21.0285, 105.8542),
                    zoom: 13.0,
                  ),
                  children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}