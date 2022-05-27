import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shalgalt/chatScreen.dart';
import 'firebase_options.dart';
// import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("firebae gogogo");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        // '/chat': (context) => const chatscreen(),
      },
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
  }

  final double circleRadius = 60.0;
  var Title = ['Bataa', 'Gomboo', 'Norjmaa'];
  var sub1 = ['Hi how are you friend,', 'hello u there?', 'cya bye'];
  var price1 = [1200, -200, 3000];
  var myicon = [
    const FaIcon(FontAwesomeIcons.user, color: Colors.purple, size: 28),
    const FaIcon(FontAwesomeIcons.userAstronaut, color: Colors.teal, size: 28),
    const FaIcon(FontAwesomeIcons.user, color: Colors.blue, size: 28)
  ];
//messenger chat app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  Icons.arrow_left,
                  size: 50,
                ),
                Text("Chat",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.edit_note,
                        size: 40,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: circleRadius,
                        height: circleRadius,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8.0,
                              offset: Offset(0.0, 5.0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Center(
                            child: Container(
                              child: FaIcon(FontAwesomeIcons.plus),

                              /// replace your image with the Icon
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Mystory(circleRadius: circleRadius),
                      SizedBox(
                        width: 15,
                      ),
                      Mystory(circleRadius: circleRadius),
                      SizedBox(
                        width: 15,
                      ),
                      Mystory(circleRadius: circleRadius),
                      SizedBox(
                        width: 15,
                      ),
                      Mystory(circleRadius: circleRadius),
                    ])),
            // Text("fucksaje")
            Container(
                height: MediaQuery.of(context).size.height * 0.37,
                child: ListView.builder(
                  itemCount: Title.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => chatscreen(todo: index),
                          ),
                        )
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                          color: const Color.fromARGB(
                                              31, 167, 162, 162)),
                                      child: Center(child: myicon[index])),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(Title[index].toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        Text(
                                          sub1[index].toString(),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            Text(
                              "today",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home, size: 36),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.barsProgress, size: 36),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.wallet, size: 36),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user, size: 36),
            label: '',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.black12,
      ),
    );
  }
}

class Mystory extends StatelessWidget {
  const Mystory({
    Key? key,
    required this.circleRadius,
  }) : super(key: key);

  final double circleRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleRadius,
      height: circleRadius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Center(
          child: Container(
            child: FaIcon(
              FontAwesomeIcons.userGraduate,
              size: 20,
            ),

            /// replace your image with the Icon
          ),
        ),
      ),
    );
  }
}
