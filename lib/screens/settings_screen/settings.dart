import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipo/auth/auth_services.dart';
import 'package:recipo/screens/navigation_screen/navigation_screen.dart';
import 'package:recipo/screens/profile_screen/profile_screen.dart';
import 'package:recipo/screens/welcome_screen/welcome_screen.dart';

// import 'package:recipo/provider/auth_provider.dart';
// import 'package:recipo/screens/help.dart';
// import 'package:recipo/screens/welcome_screen.dart';
// import 'package:recipo/utils/constants.dart';
// import 'package:rating_dialog/rating_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("userDetails");
    final authService = Provider.of<AuthService>(context);
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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            elevation: 9,
            // automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const Navigation(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'MuseoModerno',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    // Navigator.push(context,
                    //   MaterialPageRoute(
                    //       builder: (builder) => Account();
                    //   ),
                    // );
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      data['img'],
                      // ap.userModel.profilePic.isEmpty
                      //     ? 'https://raw.githubusercontent.com/Madhav2008/Blank-Person-Image/main/blank9.png'
                      //     : ap.userModel.profilePic,
                    ),
                  ),
                  title: Text(
                    data['userName'],
                    // ap.userModel.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    data['contact'],
                    // ap.userModel.phoneNumber,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
                Divider(
                  color: Colors.black.withOpacity(0.3),
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (builder) => SupportScreen(),
                          //   ),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.red.shade400,
                              width: 0.2,
                            ),
                            image: const DecorationImage(
                              opacity: 0.4,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://c8.alamy.com/comp/2C3Y51G/wallpaper-gray-text-random-words-on-a-dark-black-background-rain-of-letters-dictionary-3d-abstract-render-illustration-isolated-2C3Y51G.jpg',
                              ),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: 100,
                          child: const Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.language,
                                color: Colors.black,
                                size: 35,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Language',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (builder) => SupportScreen(),
                          //   ),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.red.shade400,
                              width: 0.2,
                            ),
                            image: const DecorationImage(
                              opacity: 0.4,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://t3.ftcdn.net/jpg/02/20/90/06/360_F_220900600_ncRGLMAcUCeuC80mwcdsfogF7dwP8j9l.jpg',
                              ),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: 100,
                          child: const Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.phone_in_talk,
                                color: Colors.black,
                                size: 35,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Help & Support',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  minLeadingWidth: 20,
                  leading: const Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'My Wish listed products',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // final navigator = Navigator.of(
                    //   context,
                    // );
                    // z.close?.call()?.then(
                    //       (value) => navigator.push(
                    //     MaterialPageRoute(
                    //       builder: (_) => const TestPage(),
                    //     ),
                    //   ),
                    // );
                  },
                ),
                ListTile(
                  minLeadingWidth: 20,
                  leading: const Icon(
                    CupertinoIcons.bitcoin_circle_fill,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'My SuperCoins',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // final navigator = Navigator.of(
                    //   context,
                    // );
                    // z.close?.call()?.then(
                    //       (value) => navigator.push(
                    //     MaterialPageRoute(
                    //       builder: (_) => const TestPage(),
                    //     ),
                    //   ),
                    // );
                  },
                ),
                ListTile(
                  minLeadingWidth: 20,
                  leading: const Icon(
                    Icons.card_giftcard_outlined,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'My Rewards',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // final navigator = Navigator.of(
                    //   context,
                    // );
                    // z.close?.call()?.then(
                    //       (value) => navigator.push(
                    //     MaterialPageRoute(
                    //       builder: (_) => const TestPage(),
                    //     ),
                    //   ),
                    // );
                  },
                ),
                ListTile(
                  minLeadingWidth: 20,
                  leading: const Icon(
                    Icons.menu_book_outlined,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'My Addresses',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // final navigator = Navigator.of(
                    //   context,
                    // );
                    // z.close?.call()?.then(
                    //       (value) => navigator.push(
                    //     MaterialPageRoute(
                    //       builder: (_) => const TestPage(),
                    //     ),
                    //   ),
                    // );
                  },
                ),
                ListTile(
                  minLeadingWidth: 20,
                  leading: const Icon(
                    Icons.update_rounded,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Updates',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // final navigator = Navigator.of(
                    //   context,
                    // );
                    // z.close?.call()?.then(
                    //       (value) => navigator.push(
                    //     MaterialPageRoute(
                    //       builder: (_) => const TestPage(),
                    //     ),
                    //   ),
                    // );
                  },
                ),
                ListTile(
                  minLeadingWidth: 20,
                  leading: const Icon(
                    Icons.feedback,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Feedback',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // final navigator = Navigator.of(
                    //   context,
                    // );
                    // z.close?.call()?.then(
                    //       (value) => navigator.push(
                    //     MaterialPageRoute(
                    //       builder: (_) => const TestPage(),
                    //     ),
                    //   ),
                    // );
                  },
                ),
                ListTile(
                  minLeadingWidth: 20,
                  leading: const Icon(
                    Icons.star_rate_rounded,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Rate Us',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // showDialog(
                    //   context: context,
                    //   barrierDismissible: true,
                    //   builder: (context) => RatingDialog(
                    //     title: const Text(
                    //       'Twenty Four into 7',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         fontSize: 25,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     message: const Text(
                    //       'Tap a star to set your rating. Add more description here if you want.',
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(fontSize: 15),
                    //     ),
                    //     image: Image.asset(
                    //       'assets/app_icon-modified.png',
                    //       width: 100,
                    //       height: 100,
                    //     ),
                    //     submitButtonText: 'Submit',
                    //     submitButtonTextStyle: const TextStyle(
                    //       letterSpacing: 1,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //     ),
                    //     starColor: Colors.yellowAccent,
                    //     starSize: 30,
                    //     commentHint: 'Write your comment.',
                    //     onCancelled: () => print('cancelled'),
                    //     onSubmitted: (response) {
                    //       print(
                    //           'rating: ${response.rating}, comment: ${response.comment}');
                    //
                    //       // TODO: add your own logic
                    //       if (response.rating < 3.0) {
                    //         // send their comments to your email or anywhere you wish
                    //         // ask the user to contact you instead of leaving a bad review
                    //       } else {
                    //         // _rateAndReviewApp();
                    //       }
                    //     },
                    //   ),
                    // );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    authService.signOut().then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                          ),
                        );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Log Out',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
