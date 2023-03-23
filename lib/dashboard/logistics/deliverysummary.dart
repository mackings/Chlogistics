import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chstores/Auths/Signin.dart';
import 'package:chstores/dashboard/spa/bottomsheet.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:sizer/sizer.dart';

class Deliverysummary extends StatefulWidget {
  var dispatchmode;
  var category;
  int amount;
  int amount2;
  int tax;
  final VoidCallback callback;

  Deliverysummary(
      {this.dispatchmode,
      this.category,
      required this.callback,
      required this.amount,
      required this.amount2,
      required this.tax});

  @override
  State<Deliverysummary> createState() => _DeliverysummaryState();
}

class _DeliverysummaryState extends State<Deliverysummary> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      height: 70.h,
      child: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Text(
            "Shipping Summary",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "worksans",
                fontWeight: FontWeight.bold,
                fontSize: 15.sp),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 35.h,
                width: MediaQuery.of(context).size.width - 20.w,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Delivery Mode",
                            style: TextStyle(
                                fontFamily: "worksans",
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  widget.dispatchmode == null
                                      ? "Select An Option"
                                      : "${widget.dispatchmode}",
                                  style: TextStyle(
                                      fontFamily: "worksans", fontSize: 12.sp)),
                              Text(
                                "N ${widget.amount}",
                                style: TextStyle(
                                    fontFamily: "worksans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Product Category",
                            style: TextStyle(
                                fontFamily: "worksans",
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  widget.dispatchmode == null
                                      ? "Select An Option"
                                      : "${widget.category}",
                                  style: TextStyle(
                                      fontFamily: "worksans", fontSize: 12.sp)),
                              Text(
                                "N ${widget.amount2}",
                                style: TextStyle(
                                    fontFamily: "worksans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Amount Payable",
                            style: TextStyle(
                                fontFamily: "worksans",
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "N ${widget.amount2 + widget.amount * 1.5}",
                                style: TextStyle(
                                    fontFamily: "worksans",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: 2.h,
          ),
          GestureDetector(
            onTap: widget.callback,
            child: loading? CircularProgressIndicator() :Container(
              height: 7.h,
              width: MediaQuery.of(context).size.width - 20.w,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Continue",
                  style: TextStyle(fontFamily: "worksans", color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
