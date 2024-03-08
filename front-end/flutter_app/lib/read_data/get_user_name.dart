import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserName extends StatelessWidget{
  final String documentId;
  GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context){
    CollectionReference user = FirebaseFirestore.instance.collection('users');

    return FutureBuilder(
        future: user.doc(documentId).get(),
        builder: ((context, snapshot){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['name']}');
        })
    );
  }

}
