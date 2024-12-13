import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socio_app/presentation/page/signin_page.dart';
import 'package:socio_app/service/api_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // // This is the file that will be used to store the image
  // File? _image;

  // // This is the image picker
  // final _picker = ImagePicker();
  // // Implementing the image picker
  // Future<void> _openImagePicker() async {
  //   final XFile? pickedImage =
  //       await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       _image = File(pickedImage.path);
  //     });
  //   }
  // }

  final ApiService service = ApiService();

  final usernameControl = TextEditingController();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final bioControl = TextEditingController();
  final profilelControl = TextEditingController.fromValue(TextEditingValue(
      text:
          'https://www.kpopmonster.jp/wp-content/uploads/2021/07/karina_01.jpg'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 96, 244),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height + 200,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                  right: -200,
                  width: 400,
                  bottom: -150,
                  height: 400,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white30,
                        border: Border.all(color: Colors.white70, width: 5)),
                  )),
              Positioned.fill(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 54),
                        TextField(
                          controller: usernameControl,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: emailControl,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Suggested code may be subject to a license. Learn more: ~LicenseLog:1994651105.
                        TextField(
                          controller: passwordControl,
                          // obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: bioControl,
                          decoration: InputDecoration(
                            labelText: 'Bio',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: profilelControl,
                          decoration: InputDecoration(
                            labelText: 'Profile Picture',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),

                        // SizedBox(
                        //     height: 150,
                        //     child: Row(
                        //       children: [
                        //         Expanded(
                        //           child: Container(
                        //             height: double.infinity,
                        //             color: Colors.grey,
                        //             child: _image != null
                        //                 ? Image.file(_image!, fit: BoxFit.cover)
                        //                 : const Text('Please select an image'),
                        //           ),
                        //         ),
                        //         SizedBox(width: 16),
                        //         Expanded(
                        //             child: ElevatedButton(
                        //                 onPressed: _openImagePicker,
                        //                 child: Text('Pick Picture'))),
                        //       ],
                        //     )),
                        // const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                              onPressed: () async {
                                try {
                                  var meesage = await service.register(
                                      usernameControl.text,
                                      emailControl.text,
                                      passwordControl.text,
                                      bioControl.text,
                                      profilelControl.text);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(meesage)));

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SigninPage(),
                                      ));
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              },
                              child: Text('Register')),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigninPage(),
                                ));
                          },
                          child: Text('Sudah punya akun?'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
