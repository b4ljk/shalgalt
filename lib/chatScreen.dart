import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shalgalt/chatScreen.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class chatscreen extends StatefulWidget {
  final int todo;
  const chatscreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  final db = FirebaseFirestore.instance;
  void initState() {
    print(widget.todo);
    super.initState();
  }

  final Stream<DocumentSnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance
          .collection('mychats')
          .doc("widget.todo.toString()")
          .snapshots();

  final double circleRadius = 60.0;
  CollectionReference groceries =
      FirebaseFirestore.instance.collection('payment');
  var Title = ['Bataa', 'Gomboo', 'Norjmaa'];
  String mytext = '';
  var sub1 = ['Hi how are you friend,', 'hello u there?', 'cya bye'];
  var price1 = [1200, -200, 3000];
  var myicon = [
    const FaIcon(FontAwesomeIcons.user, color: Colors.purple, size: 28),
    const FaIcon(FontAwesomeIcons.userAstronaut, color: Colors.teal, size: 28),
    const FaIcon(FontAwesomeIcons.user, color: Colors.blue, size: 28)
  ];
  @override
  TextEditingController UsrCntrl = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_left,
                              size: 50,
                            )),
                        Container(
                          child: myicon[widget.todo],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Title[widget.todo],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Active now",
                                ),
                                FaIcon(
                                  FontAwesomeIcons.check,
                                  size: 15,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.video),
                        SizedBox(
                          width: 20,
                        ),
                        FaIcon(FontAwesomeIcons.phone)
                      ],
                    )
                  ],
                ),
                Divider(
                  height: 20,
                  color: Color.fromARGB(255, 137, 136, 136),
                ),
                dataread(idofman: widget.todo)
              ],
            ),
            Column(
              children: [
                Divider(
                  height: 5,
                  color: Color.fromARGB(255, 133, 128, 128),
                ),
                Row(
                  children: [
                    Container(
                      width: 280,
                      child: TextFormField(
                        controller: UsrCntrl,
                        decoration:
                            const InputDecoration(hintText: 'Enter your chat'),
                        onChanged: (value) {
                          setState(() {
                            mytext = value;
                            print(mytext);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => {
                        db
                            .collection("mychats")
                            .doc(widget.todo.toString())
                            .update(
                          {
                            "Chats": FieldValue.arrayUnion([mytext]),
                          },
                        ),
                        setState(() {
                          UsrCntrl.clear();
                        })
                      },
                      child: CircleAvatar(
                          radius: 30,
                          child: Center(
                              child: FaIcon(FontAwesomeIcons.paperPlane))),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
    );
  }
}

class dataread extends StatelessWidget {
  int idofman;
  dataread({
    Key? key,
    required this.idofman,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('mychats').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data[idofman]['Chats']),
                  );
                })
                .toList()
                .cast(),
          ),
        );
      },
    );
  }
}
