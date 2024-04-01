import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _profileImageFile;
  File? _default;

  Future<void> _pickImage() async {
    final selected = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImageFile = File(selected!.path);
    });
  }

  void _clear() {
    setState(() {
      _profileImageFile = null;
    });
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
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
        TextEditingController editBioController =
            TextEditingController(text: data['bio']);
        TextEditingController editDisplayNameController =
            TextEditingController(text: data['userName']);
        TextEditingController editEmailController =
            TextEditingController(text: data['userEmail']);
        TextEditingController editIdController =
            TextEditingController(text: data['id']);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            elevation: 9,
            // automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: const Text(
              'Edit Profile',
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: <Widget>[
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     const Text('Edit'),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.pop(context);
                  //       },
                  //       child: const Icon(
                  //         Icons.close,
                  //         color: Color.fromRGBO(255, 63, 111, 1),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  _profileImageFile != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: FileImage(_profileImageFile!),
                              radius: 55,
                            ),
                            TextButton(
                              onPressed: _clear,
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Column(
                            children: <Widget>[
                              // Container(
                              //   decoration: BoxDecoration(
                              //     color: Colors.grey.withOpacity(0.3),
                              //     shape: BoxShape.circle,
                              //   ),
                              //   width: 100,
                              //   child: const Icon(
                              //     Icons.person,
                              //     size: 80,
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
                                  data['img'] ?? _profileImageFile,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Select Profile Image',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      // autovalidate: true,
                      controller: editDisplayNameController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: editBioController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      // autovalidate: true,
                      controller: editEmailController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'UserName',
                      ),
                      // autovalidate: true,
                      // obscureText: true,
                      controller: editIdController,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: 'User Details Saved Successfully!!',
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.redAccent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
