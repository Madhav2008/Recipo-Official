import 'package:recipo/screens/detail_screen/detail_screen.dart';
import 'package:recipo/screens/post_recipe_screen/models/database.dart';
import 'package:recipo/screens/search_screen/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class SearchScreenNav extends StatefulWidget {
  const SearchScreenNav({Key? key}) : super(key: key);

  @override
  _SearchScreenNavState createState() => _SearchScreenNavState();
}

class _SearchScreenNavState extends State<SearchScreenNav> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController searchController = TextEditingController();

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
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.redAccent,
          bottom: _buildBottomBar(),
        ),
        body: _buildListView(context),
      ),
    );
  }

  PreferredSize _buildBottomBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
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
                colors: [
                  Color.fromRGBO(226, 55, 68, 0.60),
                  Color.fromRGBO(226, 55, 68, 0.60),
                  Color.fromRGBO(226, 55, 68, 0.60),
                  Color.fromRGBO(226, 55, 68, 0.60),
                ],
              ),
            ),
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
            padding: const EdgeInsets.only(top: 20.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: snapshot.data!.docs.map((document) {
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
                    margin: const EdgeInsets.only(bottom: 20.0),
                    height: 250,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(document["image"]),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 10.0,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            margin: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 20.0,
                            ),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 10.0,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  document["title"],
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  document["time_to_cook"],
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey,
                                    height: 1.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
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
