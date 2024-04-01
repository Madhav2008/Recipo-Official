// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:better_skeleton/better_skeleton.dart';
import 'package:recipo/screens/detail_screen/detail_screen.dart';
import 'package:recipo/screens/post_recipe_screen/models/database.dart';
import 'package:recipo/screens/search_screen/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController searchController = TextEditingController();
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you really want to exit the app'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(willLeave = true),
                child: const Text("Yes"),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pop(willLeave = false),
                child: const Text("No"),
              ),
            ],
          ),
        );
        return willLeave;
      },
      child:
          // StreamBuilder(
          // stream: Connectivity().onConnectivityChanged,
          // builder:
          //     (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          //   if (snapshot != null &&
          //       snapshot.hasData &&
          //       snapshot.data != ConnectivityResult.none) {
          //     return
          Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.redAccent,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // ZoomDrawer.of(context)!.open();
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Image.asset(
              "assets/images/Logo3Recipo.png",
              width: 110,
              height: 110,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationIcon: Image.asset(
                      'assets/images/RecipoLogo.png',
                      width: 50,
                      height: 50,
                    ),
                    applicationName: 'Recipo',
                    applicationVersion: 'by Madhav Arora\n\nV1.0',
                  );
                },
                child: const Icon(Icons.info_outline),
              ),
            ),
          ],
          centerTitle: true,
          bottom: _buildBottomBar(),
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       showAboutDialog(
          //         context: context,
          //         applicationName: 'Recipo',
          //         applicationVersion: 'by Madhav Arora\n\nV1.0',
          //       );
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.only(right: 15),
          //       child: Icon(
          //         Icons.info_outline_rounded,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: _buildListView(context),
      ),
    );
    // } else {
    //   return Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               // Icon(Icons.favorite),
    //               // SizedBox(width:5),
    //               Image.asset('assets/images/no-internet.png',
    //                   width: 110, height: 110),
    //               // SizedBox(width:5),
    //               // Icon(Icons.favorite),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               // Icon(Icons.wifi_off),
    //               // SizedBox(width:5),
    //               Text(
    //                 "No Internet Access",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold, fontSize: 25),
    //               ),
    //               // SizedBox(width:5),
    //               // Icon(Icons.wifi_off),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    // },
    // ),
    // );
  }

  PreferredSize _buildBottomBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: TextField(
            controller: searchController,
            cursorColor: Colors.red,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search Recipe',
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                        searchText: searchController.text,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                color: Colors.red,
              ),
              // suffixIcon: IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => SearchScreen(
              //                   searchText: searchController.text)));
              //     },
              //     icon: Icon(Icons.search),
              //     color: Colors.red
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 400,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                // begin: Alignment.topCenter,
                // end: Alignment.bottomCenter,
                colors: [
                  // Color.fromRGBO(226, 55, 68, 0.60),
                  // Color.fromRGBO(226, 55, 68, 0.60),
                  // Color.fromRGBO(226, 55, 68, 0.60),
                  // Color.fromRGBO(226, 55, 68, 0.60),
                  Color.fromRGBO(226, 55, 68, 0.50),
                  Color.fromRGBO(226, 55, 68, 0.30),
                  // Color.fromRGBO(226, 55, 68, 0.10),
                  Color.fromRGBO(226, 55, 68, 0.30),
                  Color.fromRGBO(226, 55, 68, 0.50),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Most Liked Today",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 25,
              ),
              // Spacer(),
              // Builder(
              //     builder: (BuildContext context) =>
              //         Text(
              //           "View All",
              //           style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.black),
              //         )),
            ],
          ),
        ),
        _buildShopItem()
      ],
    );
  }

  Widget _buildShopItem() {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: RecipeDatabase.readAllRecipes(userId),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: ListView(
                children: snapshot.data!.docs.map(
              (document) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(document: document),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(15),
                    //   border: Border.all(
                    //     color: Colors.black,
                    //     width: 1,
                    //   ),
                    // ),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    // height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            AnimatedSkeleton(
                              listenable: animationController!,
                              child: CircleAvatar(
                                radius: 20,
                                // backgroundColor: Colors.grey,
                                backgroundImage:
                                    NetworkImage(document['image']),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            AnimatedSkeleton(
                              listenable: animationController!,
                              child: Text(
                                document['title'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedSkeleton(
                          listenable: animationController!,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  document['image'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       document['title'],
                        //       style: const TextStyle(
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.bold,
                        //         letterSpacing: 1,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Text(
                        //       document['time_to_cook'],
                        //       style: const TextStyle(
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.bold,
                        //         letterSpacing: 1,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    // child: Row(
                    //   children: <Widget>[
                    // Expanded(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //         image: NetworkImage(document["image"]),
                    //         fit: BoxFit.cover,
                    //       ),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(10.0)),
                    //       boxShadow: const [
                    //         BoxShadow(
                    //           color: Colors.grey,
                    //           offset: Offset(5.0, 5.0),
                    //           blurRadius: 10.0,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: Container(
                    //     padding: const EdgeInsets.all(20.0),
                    //     margin: const EdgeInsets.only(
                    //       top: 20.0,
                    //       bottom: 20.0,
                    //     ),
                    //     decoration: const BoxDecoration(
                    //       borderRadius: BorderRadius.only(
                    //         bottomRight: Radius.circular(10.0),
                    //         topRight: Radius.circular(10.0),
                    //       ),
                    //       color: Colors.white,
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey,
                    //           offset: Offset(5.0, 5.0),
                    //           blurRadius: 10.0,
                    //         )
                    //       ],
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: <Widget>[
                    //         Text(
                    //           document["title"],
                    //           style: const TextStyle(
                    //             fontSize: 22.0,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           height: 10.0,
                    //         ),
                    //         Text(
                    //           document["time_to_cook"],
                    //           style: const TextStyle(
                    //             fontSize: 18.0,
                    //             color: Colors.grey,
                    //             height: 1.5,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                    // ],
                    // ),
                  ),
                );
              },
            ).toList()),
          );
        },
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height - 53);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 90);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 14);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
