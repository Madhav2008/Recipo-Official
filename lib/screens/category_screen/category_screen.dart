import 'package:recipo/screens/category_screen/models/category.dart';
import 'package:recipo/screens/category_screen/category_list_screen/category_list_screen.dart';
import 'package:recipo/screens/category_screen/list_screen/list_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text("Yes"),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pop(willLeave = false),
                child: const Text(
                  "No",
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
        );
        return willLeave;
      },
      child:
          // StreamBuilder(
          //   stream: Connectivity().onConnectivityChanged,
          //   builder:
          //       (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
          //     if (snapshot != null &&
          //         snapshot.hasData &&
          //         snapshot.data != ConnectivityResult.none) {
          //       return
          Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.redAccent,
          title: const Center(
            child: Text(
              "Category",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'MuseoModerno',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(226, 55, 68, 0.50),
                Color.fromRGBO(226, 55, 68, 0.30),
                Color.fromRGBO(226, 55, 68, 0.10),
                Color.fromRGBO(226, 55, 68, 0.30),
                Color.fromRGBO(226, 55, 68, 0.50),
              ],
            ),
          ),
          child: ListView.builder(
            itemCount: category.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Category cate = category[index];
              return CategoryList(
                title: cate.name!,
                image: cate.imageUrl!,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ListScreen(
                        category: cate,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
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
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height - 53);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    var secondEndPoint = Offset(size.width, size.height - 90);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 14);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
