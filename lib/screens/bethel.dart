import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Product extends StatefulWidget {
  const Product({
    Key? key,
  }) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  final imageController = TextEditingController();
  final prouctNameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = databaseReference.child('groceries');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              controller: imageController,
                              decoration: const InputDecoration(
                                labelText: 'Movie',
                                hintText: 'Movie',
                                prefixIcon: Icon(Icons.movie),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            TextField(
                              controller: priceController,
                              decoration: const InputDecoration(
                                labelText: 'Author',
                                hintText: 'Author',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            TextField(
                              controller: prouctNameController,
                              decoration: const InputDecoration(
                                labelText: 'Author',
                                hintText: 'Author',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            TextField(
                              controller: prouctNameController,
                              decoration: const InputDecoration(
                                labelText: 'Author',
                                hintText: 'Author',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            RaisedButton(
                              child: Text('Save'),
                              onPressed: () {
                                ref.push().set({
                                  'image': imageController.text,
                                  'productName': prouctNameController.text,
                                  'price': priceController.text,
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
        body: ListView(children: [
          FirebaseAnimatedList(
              shrinkWrap: true,
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                        width: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                          ),
                          child: Image.network(
                            snapshot.child('image').value.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'Tomatoes',
                            style: TextStyle(
                              color: Color(0xFF4e055a),
                            ),
                          ),
                          const Text(
                            'Unit price GH₵ 0.3',
                            style: TextStyle(
                              color: Color(0xFF4e055a),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {},
                            color: Colors.lightGreen,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              })
        ]));
  }
}
