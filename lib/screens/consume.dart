import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'home.dart';

class Consume extends StatefulWidget {
  Consume({Key? key, required this.firebaseApp}) : super(key: key);
  final FirebaseApp firebaseApp;

  @override
  State<Consume> createState() => _ConsumeState();
}

class _ConsumeState extends State<Consume> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final movieController = TextEditingController();
  final authorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ref = databaseReference.child('movies');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consume'),
      ),
      body: ListView(
        children: [
          FirebaseAnimatedList(
              shrinkWrap: true,
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return ListTile(
                  title: Text(snapshot.child('movies').value.toString()),
                  subtitle: Text(snapshot.child('author').value.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          ref.child(snapshot.key.toString()).remove();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit,
                            color: Color.fromARGB(255, 54, 244, 63)),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: movieController,
                                        decoration: const InputDecoration(
                                          labelText: 'Movie',
                                          hintText: 'Movie',
                                          prefixIcon: Icon(Icons.movie),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                        ),
                                      ),
                                      RaisedButton(
                                        child: Text('Save'),
                                        onPressed: () {
                                          ref
                                              .child(snapshot.key.toString())
                                              .update({
                                            'movies': movieController.text,
                                            'author': authorController.text,
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ],
                  ),
                );
              }),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeData(
                    firebaseApp: Firebase.app(),
                  );
                }));
              },
              child: Text('Add')),
        ],
      ),
    );
  }
}
