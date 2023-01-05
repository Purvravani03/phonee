import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:phonee/main.dart';

class view2 extends StatefulWidget {
  const view2({Key? key}) : super(key: key);

  @override
  State<view2> createState() => _view2State();
}

class _view2State extends State<view2> {
  List name = [];
  List contact = [];
  List key1 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('contact');
    starCountRef.onValue.listen((DatabaseEvent event) {
      Map data = event.snapshot.value as Map;
      key1.clear();
      name.clear();
      contact.clear();
      data.forEach((key, value) {
        key1.add(key);
        name.add(value['name']);
        contact.add(value['contact']);
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, index) {
          return (name == null)
              ? Center(
                  child: Text("NO NAME FOUND"),
                )
              : ListTile(
                  title: Text("${name[index]}"),
                  subtitle: Text("${contact[index]}"),
                  trailing: Wrap(children: [
                    IconButton(
                        onPressed: () async {
                          DatabaseReference ref = FirebaseDatabase.instance
                              .ref('contact')
                              .child(key1[index]);
                          await ref.remove();
                        },
                        icon: Icon(Icons.delete_forever_outlined)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MyApp(
                                  key1[index], name[index], contact[index]);
                            },
                          ));
                        },
                        icon: Icon(Icons.edit))
                  ]),
                );
        },
      ),
    );
  }
}
