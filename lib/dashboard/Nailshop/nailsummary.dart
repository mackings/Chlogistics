import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chstores/Auths/Signin.dart';
import 'package:chstores/dashboard/spa/bookingdialog.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Nailsummary extends StatefulWidget {
  var name;
  var description;
  int? price;
  final VoidCallback callback;
  final VoidCallback addtocart;

  Nailsummary(
      {this.name, this.description, this.price, required this.callback, required this.addtocart});

  @override
  State<Nailsummary> createState() => _NailsummaryState();
}

class _NailsummaryState extends State<Nailsummary> {
  bool loading = false;

  final pskey = "pk_live_e1bd7f3940dbf48ba9b658862a82ec1b55d9ec3d";
  final plugin = PaystackPlugin();

  chargecard() async {
    var charge = Charge()
      ..amount = widget.price!.toInt() * 100
      ..reference = "Hello Reference"
      ..email = "Chlogistics@gmail.com";

    CheckoutResponse response = await plugin.checkout(context,
        charge: charge, method: CheckoutMethod.card);

    if (response.status = true) {
      print('Success');
    } else {
      print('Failed');
    }
  }

  getit() {
    print("hello Ann");
  }

  @override
  void initState() {
    plugin.initialize(publicKey: pskey);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            ListTile(
                title: Text(
                  widget.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      fontFamily: "worksans"),
                ),
                subtitle: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontFamily: "worksans"),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: widget.addtocart,
                          child: Container(
                              height: 6.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                  child: Text("N ${widget.price}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "worksans",
                                          fontWeight: FontWeight.bold)))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                )),
            ListTile(
              subtitle: Column(
                children: [
                  Text(
                    "Note: We will require this Payment receipt as evidence of your payment. It will also help us to resolve any queries you may have regarding your purchase.",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "worksans",
                        fontSize: 13.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            loading
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (() {
                        setState(() {
                          loading = true;
                        });
                        Timer(Duration(seconds: 2), (() {
                          setState(() {
                            loading = false;
                            chargecard();
                          });
                        }));
                      }),
                      child: Container(
                        height: 7.h,
                        width: MediaQuery.of(context).size.width - 10.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text("Pay Now",
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
    );
  }
}
