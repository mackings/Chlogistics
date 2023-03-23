import 'dart:async';

import 'package:chstores/dashboard/dashboard.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sizer/sizer.dart';
import 'dart:typed_data';

class Signin extends ConsumerStatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  ConsumerState<Signin> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  Future Signin() async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: uemail.text.trim(), password: upass.text.trim())
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      });
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

  TextEditingController uemail = TextEditingController();
  TextEditingController upass = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(children: [
              SizedBox(
                height: 7.h,
              ),
              Text("Welcome Back",style: TextStyle(
                fontFamily: "worksans",
                fontWeight: FontWeight.bold,
                fontSize:20.sp
              ),),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text("Sign in to continue",style: TextStyle(
                  fontFamily: "worksans",
                  fontSize:10.sp
              ),),
               ),

                SizedBox(
                height: 7.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 10.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 6, bottom: 6),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: uemail,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        suffixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
          
                        /// hintStyle: GoogleFonts.workSans(color: Colors.white)
                      ),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 6, bottom: 6),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: upass,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
          
                        /// hintStyle: GoogleFonts.workSans(color: Colors.white)
                      ),
                      // style: GoogleFonts.workSans(),
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
                          setState(() {
                            loading = true;
          
                     if (formkey.currentState!.validate()) {
                              setState(() {
                                loading = true;
          
                                Signin().whenComplete(() {
                                  setState(() {
                                    loading = false;
                                  });
                                });
                              });
                            } else {
                              return null;
                            }
                          });
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
                              child: Text(
                            "Sign in",
                           style: TextStyle(
                            color: Colors.white,
                            fontFamily: "worksans"
                           )
                          )),
                        ),
                      ),
                    )
            ]),
          ),
        ),
      ));
    }));
  }
}
