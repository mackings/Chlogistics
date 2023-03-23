import 'dart:async';

import 'package:chstores/dashboard/Nailshop/nailcollections.dart';
import 'package:chstores/dashboard/dashboard.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sizer/sizer.dart';
import 'dart:typed_data';

class Nailonboarding extends ConsumerStatefulWidget {
  const Nailonboarding({Key? key}) : super(key: key);

  @override
  ConsumerState<Nailonboarding> createState() => _NailonboardingState();
}

class _NailonboardingState extends ConsumerState<Nailonboarding> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return Scaffold(
            body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 5.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back))
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage("assets/polish.png"),
                  backgroundColor: Colors.white
                  //child: Image.asset("assets/polish.png", height: 280, width: 280)
                  ),
                SizedBox(height: 8.h),
                ListTile(
                  title: Text(
                    "Nails For You.",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "worksans",
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                  ),
                  subtitle: Column(
                    children: [
                      SizedBox(height: 2.h,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Lorems ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "worksans",
                              fontSize: 13.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (() {
                      setState(() {
                        load = true;
                      });

                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          load = false;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Nailcollections())));
                        });
                      });
                    }),
                    child: load
                        ? CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : Container(
                            height: 7.h,
                            width: MediaQuery.of(context).size.width - 10.w,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                                child: Text("Continue",
                                    style: TextStyle(
                                        fontFamily: "worksans",
                                        fontSize: 13.sp,
                                        color: Colors.white))),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }),
    );
  }
}
