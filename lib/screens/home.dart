import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firstfire/screens/consume.dart';
import 'package:firstfire/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart ';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeData extends StatefulWidget {
  HomeData({Key? key, required this.firebaseApp}) : super(key: key);
  final FirebaseApp firebaseApp;
  @override
  State<HomeData> createState() => _HomeDataState();
}

class _HomeDataState extends State<HomeData> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    final ref = databaseReference.child('groceries');
    final movieController = TextEditingController();
    final authorController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(
            controller: movieController,
            decoration: const InputDecoration(
              labelText: 'Movie',
              hintText: 'Movie',
              prefixIcon: Icon(Icons.movie),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          TextField(
            controller: authorController,
            decoration: const InputDecoration(
              labelText: 'Author',
              hintText: 'Author',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                ref.push().set({
                  'movies': movieController.text,
                  'author': authorController.text,
                }).asStream();
                print(movieController.text);
              },
              child: const Text('Add')),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Consume(
                    firebaseApp: Firebase.app(),
                  );
                }));
              },
              child: const Text('HomePAge')),
        ]),
      ),
    );
  }
}
