import 'dart:async';

import 'package:chstores/Auths/Signin.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sizer/sizer.dart';
import 'dart:typed_data';

class MyWidget extends ConsumerStatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  final signupkey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController uemail = TextEditingController();
  TextEditingController upass = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final dark = Colors.black;
  final light = Colors.white;

  String? email;
  String? password;

  Future Signup() async {
    try {
      var register = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: uemail.text.trim(), password: upass.text.trim())
          .then((value) {
        showDialog(
            context: context,
            builder: (context) {
              return Registeralert(
                  icon: Icons.check,
                  text: "Registered Successfully",
                  pressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signin()));
                  });
            });
      });

      print(UserCredential);
    } on FirebaseException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return Registeralert(
                icon: Icons.close,
                text: e.message,
                pressed: () {
                  Navigator.pop(context);
                });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return Scaffold(
          body: Form(
        key: formkey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 30,
                  child: Text("CH"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 10.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: light,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 6, bottom: 6),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Full Name",
                        suffixIcon: Icon(
                          Icons.person,
                          color: dark,
                        ),
                        // hintStyle: GoogleFonts.workSans()),
                        // style: GoogleFonts.workSans(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 10.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: light,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 6, bottom: 6),
                    child: TextFormField(
                      controller: uemail,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        suffixIcon: Icon(
                          Icons.email,
                          color: dark,
                        ),

                        /// hintStyle: GoogleFonts.workSans(color: Colors.white)
                      ),

                      onSaved: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      // style: GoogleFonts.workSans(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 10.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: light,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 6, bottom: 6),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone Number",
                        suffixIcon: Icon(
                          Icons.phone,
                          color: dark,
                        ),
                        // hintStyle: GoogleFonts.workSans(color: Colors.white)
                      ),
                      //style: GoogleFonts.workSans(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 10.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: light,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 6, bottom: 6),
                    child: TextFormField(
                      controller: upass,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: Icon(
                          Icons.lock,
                          color: dark,
                        ),
                        // hintStyle: GoogleFonts.workSans(color: Colors.white)
                      ),
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              loading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;

                              Signup().whenComplete(() {
                                setState(() {
                                  loading = false;
                                });
                              });
                            });
                          } else {
                            return null;
                          }
                        },
                        child: Container(
                          height: 7.h,
                          width: MediaQuery.of(context).size.width - 10.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text("Sign Up",
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  children: [
                    Text(
                      "Exisiting User? ",
                      style: TextStyle(
                          fontFamily: "worksans", color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signin()));
                      },
                      child: Text(
                        "Sign In ",
                        style: TextStyle(
                            fontFamily: "worksans",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ));
    }));
  }
}
