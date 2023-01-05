import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:phonee/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  String? name, key1, contact;

  MyApp([this.key1, this.name, this.contact]);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.key1!=null)
    {
      t1.text=widget.name!;
      t2.text=widget.contact!;
    }

  }
  FirebaseDatabase database = FirebaseDatabase.instance;
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("realtime")),
      body: Column(
        children: [
          Container(
            child: TextField(
              controller: t1,
            ),
          ),
          Container(
            child: TextField(
              controller: t2,
            ),
          ),
          TextButton(
              onPressed: () async {
            if(widget.key1==null) {
              DatabaseReference ref =
              FirebaseDatabase.instance.ref('contact').push();

              await ref.set({
                "name": t1.text,
                "contact": t2.text,
              });
            }
            else {
              DatabaseReference ref =
              FirebaseDatabase.instance.ref('contact').child(widget.key1!);
              await ref.update({
                "name": t1.text,
                "contact": t2.text,
              });
            }
              },
              child: (widget.key1==null)?Text("add user"):Text("update user")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return view2();
                  },
                ));
              },
              child: Text("view"))
        ],
      ),
    );
  }
}
