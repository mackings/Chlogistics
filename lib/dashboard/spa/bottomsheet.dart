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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Bottomsheet extends StatefulWidget {
  var title;
  var price;
  dynamic description;
  final VoidCallback callback;
  bool load;

  Bottomsheet(
      {required this.description,
      required this.price,
      required this.title,
      required this.callback,
      required this.load});

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  bool loading = false;
  bool loading2 = false;
  bool checked = false;
  bool checked2 = false;
  bool checked3 = false;
  dynamic selecteddate;
  String name = "";
  Color ucolor = Colors.white;
  Color scolor = Colors.black;

  Future getit(name, age) async {
    print(name);
    print(age);
  }

  Future SaveBooking(time) async {
    final adddata = await FirebaseFirestore.instance
        .collection("Bookings")
        .doc()
        .set({
          "Time": time,
          "Staff":name
          }).whenComplete(() {
      print("data Added $time $name");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/spa3.jpg"), fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          SizedBox(
            height: 35.h,
          ),
          Expanded(
            child: Container(
                height: 30.h,
                width: MediaQuery.of(context).size.width.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyle(
                                        fontFamily: "worksans",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  // Text("Charcole Face",style: TextStyle(
                                  //   fontFamily:"worksans",
                                  // ),),
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        widget.price.toString(),
                                        style: TextStyle(
                                            fontFamily: "worksans",
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    "3000",
                                    style: TextStyle(
                                      fontFamily: "worksans",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Whats Included",
                            style: TextStyle(
                                fontFamily: "worksans",
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp),
                          ),
                          subtitle: Text(
                            widget.description,
                            style: TextStyle(
                                fontFamily: "worksans", fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Text(
                                "Select a Staff",
                                style: TextStyle(
                                    fontFamily: "worksans",
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 2.h,
                        ),

                        CarouselSlider(
                            items: [

                                       Column(
                                         children: [
                                           CircleAvatar(
                                            radius: 35,
                                                 child:Checkbox(
                                                      checkColor: Colors.white,
                                                      value: checked,
                                                      focusColor: Colors.white,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          checked = value!;
                                                          if (checked == value) {
                                                            setState(() {
                                                              name = "Mac Vins";
                                                              print(name);
                                                            });
                                                          } else {
                                                            setState(() {
                                                              name = "";
                                                            });
                                                          }
                                                        });
                                                      }) ,
                              ),

                                             Padding(
                                               padding: const EdgeInsets.all(5.0),
                                               child: Text(
                                            "Mac Vins",
                                            style:
                                                  TextStyle(color: Colors.black,
                                                  fontFamily: "worksans"),
                                          ),
                                             ),
                                         ],
                                       ),

                                                                     Column(
                                         children: [
                                           CircleAvatar(
                                            radius: 35,
                                                 child:Checkbox(
                                                      checkColor: Colors.white,
                                                      value: checked,
                                                      focusColor: Colors.white,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          checked = value!;
                                                          if (checked == value) {
                                                            setState(() {
                                                              name = "Aries Vin";
                                                              print(name);
                                                            });
                                                          } else {
                                                            setState(() {
                                                              name = "";
                                                            });
                                                          }
                                                        });
                                                      }) ,
                              ),

                                             Padding(
                                               padding: const EdgeInsets.all(5.0),
                                               child: Text(
                                            "Mac Vins",
                                            style:
                                                  TextStyle(color: Colors.black,
                                                  fontFamily: "worksans"),
                                          ),
                                             ),
                                         ],
                                       ),
                              
                                                                    Column(
                                         children: [
                                           CircleAvatar(
                                            radius: 35,
                                                 child:Checkbox(
                                                      checkColor: Colors.white,
                                                      value: checked2,
                                                      focusColor: Colors.white,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          checked2 = value!;
                                                          if (checked2 == value) {
                                                            setState(() {
                                                              name = "Alan Walter";
                                                              print(name);
                                                            });
                                                          } else {
                                                            setState(() {
                                                              name = "";
                                                            });
                                                          }
                                                        });
                                                      }) ,
                              ),

                                          //    Padding(
                                          //      padding: const EdgeInsets.all(5.0),
                                          //      child: Text(
                                          //   "Mac Vins",
                                          //   style:
                                          //         TextStyle(color: Colors.black,
                                          //         fontFamily: "worksans"),
                                          // ),
                                          //    ),
                                         ],
                                       ),

                               
                                                                     Column(
                                         children: [
                                           CircleAvatar(
                                            radius: 35,
                                                 child:Checkbox(
                                                      checkColor: Colors.white,
                                                      value: checked3,
                                                      focusColor: Colors.white,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          checked3 = value!;
                                                          if (checked3 == value) {
                                                            setState(() {
                                                              name = "Kayd Nailer";
                                                              print(name);
                                                            });
                                                          } else {
                                                            setState(() {
                                                              name = "";
                                                            });
                                                          }
                                                        });
                                                      }) ,
                              ),

                                             Padding(
                                               padding: const EdgeInsets.all(5.0),
                                               child: Text(
                                            "Kayd Nailer",
                                            style:
                                                  TextStyle(color: Colors.black,
                                                  fontFamily: "worksans"),
                                          ),
                                             ),
                                         ],
                                       ),
                             
                             
                             
                            ],
                            options:
                                CarouselOptions(autoPlay: true, height: 13.h)),
                        SizedBox(
                          height: 2.h,
                        ),

                        loading2
                            ? CircularProgressIndicator()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      loading2 = true;
                                    });
                                    Timer(Duration(seconds: 2), (() {
                                      getit("Mac", "kingsley").whenComplete(() {
                                        setState(() {
                                          loading2 = false;
                                          DatePicker.showDateTimePicker(context,
                                              showTitleActions: true,
                                              onConfirm: (date) {
                                            setState(() {
                                              selecteddate = date;
                                            });
                                            print(selecteddate);
                                            SaveBooking(
                                                    "${selecteddate.toString()}")
                                                .whenComplete(
                                              () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        BookConfimed(
                                                            icon: Icons.check,
                                                            message:
                                                                "Booking Successful",
                                                            description:
                                                                "You Have sucessfully Booked a session",
                                                            callback: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }));
                                              },
                                            );
                                            print("Date Confirmed");
                                          }, onChanged: (date) {});
                                        });
                                      });
                                    }));
                                  }),
                                  child: Container(
                                    height: 7.h,
                                    width: MediaQuery.of(context).size.width -
                                        10.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.5),
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: Text("Schedule a session",
                                            style: TextStyle(
                                                fontFamily: "worksans",
                                                fontSize: 13.sp,
                                                color: Colors.white))),
                                  ),
                                ),
                              ),
                        // loading
                        //     ? CircularProgressIndicator()
                        //     : Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: GestureDetector(
                        //           onTap: (() {
                        //             setState(() {
                        //               loading = true;
                        //             });
                        //             Timer(Duration(seconds: 2), (() {
                        //               getit("Mac", "kingsley").whenComplete(() {
                        //                 setState(() {
                        //                   loading = false;
                        //                   print(widget.title);
                        //                 });
                        //               });
                        //             }));
                        //           }),
                        //           child: Container(
                        //             height: 7.h,
                        //             width: MediaQuery.of(context).size.width -
                        //                 10.w,
                        //             decoration: BoxDecoration(
                        //               border: Border.all(width: 0.5),
                        //               color: Colors.indigoAccent,
                        //               borderRadius: BorderRadius.circular(20),
                        //             ),
                        //             child: Center(
                        //                 child: Text("Pay Now",
                        //                     style: TextStyle(
                        //                         fontFamily: "worksans",
                        //                         fontSize: 13.sp,
                        //                         color: Colors.white))),
                        //           ),
                        //         ),
                        //       ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
