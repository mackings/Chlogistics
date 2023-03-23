import 'dart:async';
import 'dart:ui';

import 'package:chstores/dashboard/Nailshop/onboarding.dart';
import 'package:chstores/dashboard/logistics/onboarding.dart';
import 'package:chstores/dashboard/spa/collection.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sizer/sizer.dart';
import 'dart:typed_data';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  int currentindex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(""),
                      Text("Hello, What are you getting today?",
                      style: TextStyle(
                        fontFamily: "worksans"
                      ),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 200,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      setState(() {
                        currentindex = index;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.5,color: Colors.black),
                              image: const DecorationImage(
                                  image: AssetImage("assets/spa2.jpg"),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(Color.fromARGB(255, 156, 0, 0), BlendMode.darken)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 30.0, 10.0, 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full Healthy\nBody Massages and More..",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "worksans"
                                ),),
                                SizedBox(
                                  height: 2.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FacialCollection()));
                                  },
                                  child: Container(
                                      height: 5.h,
                                      width: 30.w,
                                      child: Center(
                                        child: Text(
                                          " Start Now",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 0,
                          width: MediaQuery.of(context).size.width - 90,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 156, 33, 24),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 0,
                          width: MediaQuery.of(context).size.width - 90,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 24, 21, 179),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 150, right: 150),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(""),
                          for (var i = 0; i < 3; i++)
                            buildindicator(currentindex == i),
                          Text(""),
                        ]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 7.h,
                    width: MediaQuery.of(context).size.width - 10.w,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5,color: Colors.black),
                        //color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.black,
                          ),
                          Text(
                            "Notifications...",
                            style: TextStyle(
                                color: Colors.black, fontFamily: "worksans"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //Cards

                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    25.0,
                    10.0,
                    25.0,
                    10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                                 Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FacialCollection()));
                        },
                        child: Container(
                          height: 17.h,
                          width: 35.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.5,color: Colors.black),
                             // color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 15.0, 10.0, 15.0),
                            child: Column(
                              children: [
                                Text(
                                  "Spar",
                                  style: TextStyle(
                                      //color: Colors.white,
                                      fontFamily: "worksans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp),
                                ),

                                //   Text("All Massge Types",style: TextStyle(
                                //   color: Colors.white,
                                //   fontFamily: "worksans"
                                // ),),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/spa.png",
                                    width: 60,
                                    height: 60,
                                    //color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Nailonboarding()));
                        },
                        child: Container(
                          height: 17.h,
                          width: 35.w,
                          decoration: BoxDecoration(
                             // color: Colors.black,
                             border: Border.all(width: 1.5,color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 15.0, 10.0, 15.0),
                            child: Column(
                              children: [
                                Text(
                                  "Nail Shop",
                                  style: TextStyle(
                                     // color: Colors.white,
                                      fontFamily: "worksans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/nails.png",
                                    width: 60,
                                    height: 60,
                                   // color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    25.0,
                    10.0,
                    25.0,
                    10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                                                              Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Logisticsonboarding()));
                        },
                        child: Container(
                          height: 17.h,
                          width: 35.w,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.5,color: Colors.black),
                              //color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                            child: Column(
                              children: [
                                Text(
                                  "Logistics",
                                  style: TextStyle(
                                    //  color: Colors.white,
                                      fontFamily: "worksans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/logistics.png",
                                    width: 60,
                                    height: 60,
                                   // color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 17.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5,color: Colors.black),
                           
                            borderRadius: BorderRadius.circular(10),
                            ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 15.0, 10.0, 15.0),
                            child: Column(
                              children: [
                                Text(
                                  "Refreshments",
                                  style: TextStyle(
                                     // color: Colors.white,
                                      fontFamily: "worksans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/cofee.png",
                                    width: 60,
                                    height: 60,
                                   // color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(
              fontFamily: "worksans",
            ),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.home,
                      )),
                  label: "Thiago"),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.wallet,
                      )),
                  label: "Sell"),
              BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Logisticsonboarding()));
                    },
                    child: Icon(Icons.delivery_dining)),
                label: "Logistics",
              ),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.person,
                      )),
                  label: "Profile"),
            ]),
      );
    }));
  }
}

Widget buildindicator(bool isSelected) {
  return Container(
      height: isSelected ? 10 : 8,
      width: isSelected ? 10 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Color(0xff2c0794) : Color(0xffc4c4c4),
      ));
}
