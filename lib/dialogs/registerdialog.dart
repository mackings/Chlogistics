

import 'dart:ui';

import 'package:chstores/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sizer/sizer.dart';

class Registeralert extends StatefulWidget {
  var text;
  var icon = Icons.check;
  final VoidCallback pressed;

  Registeralert({this.text, required this.icon, required this.pressed});

  @override
  State<Registeralert> createState() => _RegisteralertState();
}

class _RegisteralertState extends State<Registeralert> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return StatefulBuilder(builder: ((context, setState) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: 30.h,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 20,
                    child: Icon(widget.icon,color: Colors.white,
                    size: 30,),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,20.0),
                    child: Text(widget.text,style: TextStyle(
                      color: Colors.black,
                      fontFamily: "worksans"
                    ),),
                  ),

                  
                  GestureDetector(
                    onTap: widget.pressed,
                    child: Container(
                      height: 6.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5,color: Colors.white),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        "Okay",
                        style: TextStyle(
                          color: Colors.white
                        )
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }));
    }));
  }
}
