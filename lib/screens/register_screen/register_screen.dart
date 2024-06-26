import 'dart:io';
import 'package:recipo/auth/auth_services.dart';
import 'package:recipo/screens/login_screen/button.dart';
import 'package:recipo/screens/login_screen/login_screen.dart';
import 'package:recipo/screens/navigation_screen/navigation_screen.dart';
import 'package:recipo/widgets/text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:recipo/screens/post_recipe_screen/models/users.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  File? _imageFile;
  String uploadedPath = "";
  late XFile _image;
  ImagePicker imagePicker = ImagePicker();
  bool _isLoading = false;

  void saveUser(uid) {
    // UserDatabase.addUser(
    //   userId: uid,
    //   userName: nameController.text,
    //   bio: bioController.text,
    //   userEmail: emailController.text,
    //   contact: contactController.text,
    //   img: uploadedPath,
    // );
  }

  selectImage() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () {
                Navigator.of(context).pop();
                imagePickerMethod(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.of(context).pop();
                imagePickerMethod(ImageSource.gallery);
              },
            ),
          ],
        ),
        onClosing: () {},
      ),
    );
  }

  imagePickerMethod(ImageSource source) async {
    var pic = await imagePicker.pickImage(source: source);
    if (pic != null) {
      // setState(() {
      //   _image = XFile(pic.path);
      // });
    }
    uploadImage();
  }

  void uploadImage() {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('Images').child(imageFileName);
    final UploadTask uploadTask = storageReference.putFile(File(_image.path));
    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        _isLoading = true;
      });
    });
    uploadTask.then((TaskSnapshot taskSnapshot) async {
      uploadedPath = await uploadTask.snapshot.ref.getDownloadURL();
      print(uploadedPath);

      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Register.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.black54,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://github.com/Madhav2008/App-Assets/blob/main/RecipoLogo.png?raw=true",
                  width: 100,
                  height: 100,
                ),
                const Text(
                  'Recipo',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                //   child: Column(
                //     children: [
                //       ListView(
                //         shrinkWrap: true,
                //         children: <Widget>[
                //           _imageFile != null
                //               ? Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: <Widget>[
                //               ClipRRect(
                //                 borderRadius:
                //                 BorderRadius.all(Radius.circular(10)),
                //                 child: Container(
                //                   width: MediaQuery.of(context).size.width -
                //                       20,
                //                   child: Image.file(
                //                     _imageFile!,
                //                     fit: BoxFit.fitWidth,
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           )
                //               : GestureDetector(
                //             onTap: () {
                //               selectImage();
                //             },
                //             child: Card(
                //               elevation: 2,
                //               child: Container(
                //                 alignment: Alignment.center,
                //                 width: MediaQuery.of(context).size.width,
                //                 height:
                //                 MediaQuery.of(context).size.height * .3,
                //                 child: _isLoading == false
                //                     ? Expanded(
                //                   child: uploadedPath == ""
                //                       ? Column(
                //                     mainAxisAlignment:
                //                     MainAxisAlignment
                //                         .center,
                //                     children: [
                //                       Icon(
                //                         Icons
                //                             .cloud_upload_outlined,
                //                         color: Colors.redAccent,
                //                         size: 100,
                //                       ),
                //                       Padding(
                //                         padding: EdgeInsets
                //                             .symmetric(
                //                             vertical: 5),
                //                         child: Text(
                //                           "Upload Image",
                //                           style: TextStyle(
                //                               fontSize: 22),
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding: EdgeInsets
                //                             .symmetric(
                //                             vertical: 5),
                //                         child: Text(
                //                             "click here for upload image"),
                //                       )
                //                     ],
                //                   )
                //                       : Image(
                //                       image: NetworkImage(
                //                           uploadedPath)),
                //                 )
                //                     : CircularProgressIndicator(
                //                   color: Colors.red,
                //                 ),
                //                 // child: Image.asset(
                //                 //   'assets/images/upload.png',
                //                 //   fit: BoxFit.cover,
                //                 // ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.supervised_user_circle_outlined,
                        color: Colors.white,
                      ),
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: bioController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.assignment_outlined,
                        color: Colors.white,
                      ),
                      hintText: 'Bio',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: contactController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 0.0,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      hintText: 'Contact',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await authService
                          .createUserWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                      )
                          .then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Navigation(),
                          ),
                        );
                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        saveUser(userId);
                        Fluttertoast.showToast(
                          msg: "User Registered Successfully!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }).catchError(
                        (error) {
                          showDialog(
                            context: context,
                            builder: (con) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: Text(error.toString()),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.58,
                      height: 50,
                      child: const Buttons(
                        buttonText: 'Register',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextSimpleButton(
                      title: 'Login',
                      colors: Colors.redAccent,
                      onPress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
