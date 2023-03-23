import 'dart:ui';

import 'package:chstores/Auths/Signin.dart';
import 'package:chstores/dashboard/logistics/shipping.dart';
import 'package:chstores/dashboard/spa/bottomsheet.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:sizer/sizer.dart';

class Logisticsonboarding extends ConsumerStatefulWidget {
  const Logisticsonboarding({Key? key}) : super(key: key);

  @override
  ConsumerState<Logisticsonboarding> createState() =>
      _LogisticsonboardingState();
}

class _LogisticsonboardingState extends ConsumerState<Logisticsonboarding> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return Scaffold(
          body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 26.h,
            ),
            CircleAvatar(
                radius: 80, backgroundImage: AssetImage("assets/lguy.jpg")
                ),

                SizedBox(
                      height: 3.h,
                    ),


            Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListTile(
                title: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Your Logistic Partner For\nSeamless Delivery. ",
                          style: TextStyle(
                              fontSize: 21.sp,
                              fontFamily: "worksans",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    )
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Our Logistics service provides end-to-end solutions for",
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontFamily: "worksans",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "all your shopping needs.",
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontFamily: "worksans",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), 
              child: GestureDetector(
                onTap: (() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Shipping()));
                }),
                child: Container(
                  height: 7.h,
                  width: MediaQuery.of(context).size.width - 10.w,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text("Get Started",
                          style: TextStyle(
                              fontFamily: "worksans",
                              fontSize: 13.sp,
                              color: Colors.white))),
                ),
              ),
            ),
          ],
        ),
      ));
    }));
  }
}
