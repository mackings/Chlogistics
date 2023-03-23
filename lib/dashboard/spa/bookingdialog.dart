import 'dart:async';

import 'package:chstores/Auths/Signin.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class BookConfimed extends StatefulWidget {
  var icon = Icons.check;
  var message;
  var description;
  final VoidCallback callback;
  BookConfimed(
      {this.message,
      required this.icon,
      this.description,
      required this.callback});

  @override
  State<BookConfimed> createState() => _BookConfimedState();
}

class _BookConfimedState extends State<BookConfimed> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 35.h,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              CircleAvatar(
                radius: 30,
                child: Icon(widget.icon)
                ),

                SizedBox(height: 2.h,),

                Text(widget.message,style: TextStyle(
                  fontFamily: "worksans",
                  fontWeight: FontWeight.bold
                ),),

                SizedBox(height: 2.h,),

                Text(widget.description),

                SizedBox(height: 3.h,),

                GestureDetector(
                  onTap: widget.callback,
                  child: Container(
                    height: 6.h,
                    width: 40.w,
                    child: Center(
                      child: Text("Proceed to pay",style: TextStyle(
                      fontFamily: "worksans",
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                )

            ],
          ),
        ),

      ),
    );
  }
}
