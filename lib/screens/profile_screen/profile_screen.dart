import 'package:recipo/auth/auth_services.dart';
import 'package:recipo/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:recipo/screens/login_screen/login_screen.dart';
import 'package:recipo/screens/post_recipe_screen/models/database.dart';
import 'package:recipo/screens/profile_screen/tab_1.dart';
import 'package:recipo/screens/profile_screen/tab_2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipo/screens/settings_screen/settings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  String numberFormat(int n) {
    String num = n.toString();
    int len = num.length;

    if (n >= 1000 && n < 1000000) {
      return '${num.substring(0, len - 3)}.${num.substring(len - 3, 1 + (len - 3))}k';
    } else if (n >= 1000000 && n < 1000000000) {
      return '${num.substring(0, len - 6)}.${num.substring(len - 6, 1 + (len - 6))}m';
    } else if (n > 1000000000) {
      return '${num.substring(0, len - 9)}.${num.substring(len - 9, 1 + (len - 9))}b';
    } else {
      return num.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // int likes = numberFormat(data[likes]);
    final recipeSnapshot = RecipeDatabase.readUserRecipes(userId);
    final authService = Provider.of<AuthService>(context);
    final db = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("userDetails");
    return FutureBuilder<QuerySnapshot>(
      future: db.get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
          );
        }
        final data = snapshot.data!.docs[0];
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
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                elevation: 9,
                automaticallyImplyLeading: false,
                title: const Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 20,
                    // fontFamily: 'MuseoModerno',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                leading: const Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      // authService.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                  // color: Colors.white,
                  // )
                ],
              ),
              backgroundColor: Colors.white,
              body:
                  // Container(
                  //   decoration: const BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //       colors: [
                  //         Color.fromRGBO(226, 55, 68, 0.50),
                  //         Color.fromRGBO(226, 55, 68, 0.30),
                  //         Color.fromRGBO(226, 55, 68, 0.10),
                  //         Color.fromRGBO(226, 55, 68, 0.30),
                  //         Color.fromRGBO(226, 55, 68, 0.50),
                  //       ],
                  //     ),
                  //   ),
                  //   child:
                  Padding(
                padding: const EdgeInsets.only(
                  // left: 16,
                  top: 16,
                  // bottom: 16,
                ),
                child: Column(
                  children: [
                    // Row(
                    //   children: <Widget>[
                    //     CircleAvatar(
                    //       radius: 45,
                    //       backgroundColor: Colors.grey.withOpacity(0.3),
                    //       // child: data['img'] == null
                    //       //     ? const Icon(
                    //       //         Icons.person,
                    //       //         color: Colors.black,
                    //       //         size: 70,
                    //       //       )
                    //       //     : Image.network(
                    //       //         data['img'],
                    //       //       ),
                    //       backgroundImage: NetworkImage(
                    //         data['img'],
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 1,
                    //       child: Column(
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.only(
                    //               top: 8.0,
                    //               left: 20,
                    //             ),
                    //             child: Row(
                    //               // mainAxisAlignment:
                    //               // MainAxisAlignment.spaceEvenly,
                    //               // mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 Column(
                    //                   children: [
                    //                     Container(
                    //                       // alignment: Alignment.centerLeft,
                    //                       padding: const EdgeInsets.only(
                    //                         top: 5,
                    //                         bottom: 5,
                    //                       ),
                    //                       child: Text(
                    //                         data['userName'],
                    //                         style: const TextStyle(
                    //                           fontSize: 18,
                    //                           // fontWeight: FontWeight.bold,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Row(
                    //                       // mainAxisAlignment:
                    //                       // MainAxisAlignment.center,
                    //                       children: [
                    //                         const Text('---'),
                    //                         const SizedBox(width: 5),
                    //                         Text(
                    //                           data['bio'],
                    //                           style:
                    //                               const TextStyle(fontSize: 12),
                    //                         ),
                    //                         const SizedBox(width: 5),
                    //                         const Text('---'),
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 // buildCountColumn('Posts - ', 0),
                    //                 // buildCountColumn('Followers', 0),
                    //                 // buildCountColumn('Following', 0),
                    //               ],
                    //             ),
                    //           ),
                    //           const Padding(
                    //             padding: EdgeInsets.only(top: 5.0),
                    //             // child: Container(
                    //             //   width: 250,
                    //             //   child: RaisedButton(
                    //             //     color: Colors.white,
                    //             //
                    //             //     shape: RoundedRectangleBorder(
                    //             //       borderRadius: BorderRadius.circular(5),
                    //             //     ),
                    //             //     onPressed: () async {
                    //             //       Navigator.push(
                    //             //           context,
                    //             //           MaterialPageRoute(
                    //             //               builder: (context) =>
                    //             //                   EditProfile()));
                    //             //     },
                    //             //     // },
                    //             //     child: Text("Edit Profile"),
                    //             //     // color: Colors.red,
                    //             //   ),
                    //             // ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // // Center(
                    // // Container(
                    // //   alignment: Alignment.centerLeft,
                    // //   padding: const EdgeInsets.only(top: 2, left: 2),
                    // //   child: Text(
                    // //     data['bio'],
                    // //     style: TextStyle(
                    // //       fontSize: 12,
                    // //     ),
                    // //   ),
                    // // ),

                    // Container(
                    //   height: 120,
                    //   width: 120,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: Colors.grey[200],
                    //   ),
                    // ),

                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      // foregroundColor: Colors.white,
                      // child: data['img'] == null
                      //     ? const Icon(
                      //         Icons.person,
                      //         color: Colors.black,
                      //         size: 70,
                      //       )
                      //     : Image.network(
                      //         data['img'],
                      //       ),
                      backgroundImage: NetworkImage(
                        data['img'] == ''
                            ? 'https://raw.githubusercontent.com/Madhav2008/Blank-Person-Image/main/blank10.png'
                            : data['img'],
                      ),
                    ),

                    // username
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        bottom: 20.0,
                      ),
                      child: Text(
                        '@${data['id']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),

                    // number of following, followers, likes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                Text(
                                  numberFormat(data['following']),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Following',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                numberFormat(data['follower']),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Followers',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text(
                                  numberFormat(data['likes']),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  '  Likes  ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // buttons -> edit profile, insta links, bookmark
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => const EditProfile(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 40,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Edit profile',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.bookmark_border,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Text(
                      data['bio'],
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: Column(
                        children: [
                          const TabBar(
                            indicatorColor: Colors.redAccent,
                            tabs: [
                              Tab(
                                icon: Icon(
                                  Icons.grid_3x3,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Tab(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: TabBarView(
                                children: [
                                  FirstTab(),
                                  const SecondTab(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ),
        );
      },
    );
  }

  buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
