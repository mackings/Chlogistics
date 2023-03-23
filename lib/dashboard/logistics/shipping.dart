import 'dart:async';
import 'dart:ui';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chstores/Auths/Signin.dart';
import 'package:chstores/dashboard/logistics/deliverysummary.dart';
import 'package:chstores/dashboard/spa/bottomsheet.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin;
import 'dart:math' as math;

import 'package:sizer/sizer.dart';

class Shipping extends ConsumerStatefulWidget {
  const Shipping({Key? key}) : super(key: key);

  @override
  ConsumerState<Shipping> createState() => _ShippingState();
}

class _ShippingState extends ConsumerState<Shipping> {
  final scolor = Colors.black;
  var ucolor = Colors.white;
  final pcolor = Colors.red;
  dynamic selecteddate;

 

  var gen = "";
  List<DropdownMenuItem<String>> genders = [
    const DropdownMenuItem(
      value: "",
      child: SizedBox(
        child: Text(
          "Select Dispatch Mode",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
    const DropdownMenuItem(
      value: "Delivery Car",
      child: SizedBox(
        child: Text(
          "Delivery Car",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
    const DropdownMenuItem(
      value: "Delivery Bike",
      child: SizedBox(
        child: Text(
          "Delivery Bike",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
    const DropdownMenuItem(
      value: "Delivery Lorry",
      child: SizedBox(
        child: Text(
          "Delivery Lorry",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
  ];

  var cat = "";
  List<DropdownMenuItem<String>> productcategory = [
    const DropdownMenuItem(
      value: "",
      child: SizedBox(
        child: Text(
          "Select Package Type",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
    const DropdownMenuItem(
      value: "Parcel package (Fits Envelope)",
      child: SizedBox(
        child: Text(
          "Parcel package (Fits Envelope)",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
    const DropdownMenuItem(
      value: "Small Box (Fits a Small Box)",
      child: SizedBox(
        child: Text(
          "Small Box (Fits a Small Box)",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
    const DropdownMenuItem(
      value: "Jumbo Package (Fits a Big Box)",
      child: SizedBox(
        child: Text(
          "Jumbo Package (Fits a Big Box)",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
    const DropdownMenuItem(
      value: "Orobo package (Fits a Skid)",
      child: SizedBox(
        child: Text(
          "Orobo package (Fits a Skid)",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
    const DropdownMenuItem(
      value: "Heavy weight(Fits a Big Skid)",
      child: SizedBox(
        child: Text(
          "Heavy weight(Fits a Big Skid)",
          style: TextStyle(
            fontSize: 14.5,
          ),
        ),
      ),
    ),
  ];

  dynamic Amount = 0;
  dynamic Amount2 = 0;
  dynamic Tax = 0;

  //Set<Marker> markers = {};
  List Mark = [];

  Marker marker = Marker(
    markerId: MarkerId('marker_1'),
    position: LatLng(37.7749, -122.4194),
    infoWindow: InfoWindow(
      title: 'San Francisco',
      snippet: 'The Golden Gate City',
    ),
  );

  Location location = new Location();
  LocationData? userLocation;

  Future<LatLng> getCurrentLocation() async {
    userLocation = await location.getLocation();
    return LatLng(userLocation!.latitude!, userLocation!.longitude!);
  }

  String? locationname;
  String? dropname;

  LatLng? theLat;

  Future GetDistance() async {
    Position Userposition = await Geolocator.getCurrentPosition();
    print(Userposition.longitude);
    print(Userposition.latitude);
  }

  dynamic totalD;

// Function to calculate the distance between two points
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // km

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * asin(sqrt(a));
    double distance = earthRadius * c;

    setState(() {
      totalD = distance.toInt() * 4.toInt() * 100 + 100;
      print("Total Distance is $totalD");
    });

    return distance;
    //print("Distance is $distance.");
  }

// Helper function to convert degrees to radians
  double _toRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  dynamic mylat1;
  dynamic mylat2;
  dynamic mylng1;
  dynamic mylng2;

  final pskey = "pk_live_e1bd7f3940dbf48ba9b658862a82ec1b55d9ec3d";
  final plugin = PaystackPlugin();

  chargecard() async {
    var charge = Charge()
      ..amount = totalD.toInt() + Amount2 * 100
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

  bool load = false;
  String? worth;
  String? description;

  @override
  void initState() {
    plugin.initialize(publicKey: pskey);

    //GetDistance();
    //getCurrentLocation();
    // TODO: implement initState
    super.initState();
  }

//pk_live_e1bd7f3940dbf48ba9b658862a82ec1b55d9ec3d
  @override
  Widget build(BuildContext context) {
    Mark.add(marker);

    return Sizer(builder: ((context, orientation, deviceType) {
      return Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 5.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(15.0),
                        //       child: Text(
                        //         "Where to Drop",
                        //         style: TextStyle(
                        //             fontFamily: "worksans",
                        //             color: Colors.white),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pick up Location",
                              style: TextStyle(
                                  fontFamily: "worksans", color: Colors.white),
                            ),
                          ),
                          subtitle: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 49, 45, 45),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 0.5, color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  onTap: () async {
                                    var pickedLocation =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PlacePicker(
                                          apiKey:
                                              'AIzaSyD6MS4bUOjkP0fYUklsVzIKYmGmb_MheGQ',
                                          onPlacePicked: (result) {
                                            print(result.formattedAddress);
                                            print(result.geometry);
                                            print(result.id);

                                            setState(() {
                                              mylat1 =
                                                  result.geometry!.location.lat;
                                              mylng1 =
                                                  result.geometry!.location.lng;
                                            });
                                            print("User Lng ${mylng1}");
                                            print("User Lat ${mylat1}");

                                            //getCurrentLocation();

                                            setState(() {
                                              locationname =
                                                  result.formattedAddress;
                                            });

                                            Timer(Duration(seconds: 2), () {
                                              Navigator.pop(context);
                                              //calculateDistance(lat1, lon1, lat2, lon2)
                                            });
                                          },
                                          //AIzaSyD6MS4bUOjkP0fYUklsVzIKYmGmb_MheGQ
                                          //AIzaSyCgeGrZMAyo5CWsgP6YcYTYaHmVcDkRYB4
                                          initialPosition:
                                              LatLng(37.77483, -122.41942),
                                          useCurrentLocation: true,
                                        ),
                                      ),
                                    );

                                    if (pickedLocation != null) {
                                      setState(() {
                                        locationname =
                                            pickedLocation.formattedAddress;
                                        print("Address $locationname");

                                        Timer(Duration(seconds: 0), () {
                                          Navigator.pop(context);
                                        });
                                      });
                                    } else {}
                                    print("Hello ff");
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: locationname == null
                                          ? "Select  Pickup Location"
                                          : locationname.toString(),
                                      hintStyle: TextStyle(
                                          fontFamily: "worksans",
                                          color: Colors.white)),
                                  style: TextStyle(
                                      fontFamily: "worksans",
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Drop Location",
                              style: TextStyle(
                                  fontFamily: "worksans", color: Colors.white),
                            ),
                          ),
                          subtitle: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 49, 45, 45),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 0.5, color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onTap: () async {
                                  var pickedLocation =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PlacePicker(
                                        apiKey:
                                            'AIzaSyD6MS4bUOjkP0fYUklsVzIKYmGmb_MheGQ',
                                        onPlacePicked: (result) {
                                          print(result.formattedAddress);
                                          setState(() {
                                            dropname = result.formattedAddress;
                                            mylat2 =
                                                result.geometry!.location.lat;
                                            mylng2 =
                                                result.geometry!.location.lng;

                                            print(
                                                "Lat2 is $mylat2 lng2 is $mylng2");

                                            calculateDistance(
                                                mylat1, mylng1, mylat2, mylng2);

                                            Timer(Duration(seconds: 0), () {
                                              Navigator.pop(context);
                                            });
                                          });
                                        },
                                        //AIzaSyD6MS4bUOjkP0fYUklsVzIKYmGmb_MheGQ
                                        //AIzaSyCgeGrZMAyo5CWsgP6YcYTYaHmVcDkRYB4
                                        initialPosition:
                                            LatLng(37.77483, -122.41942),
                                        useCurrentLocation: true,
                                      ),
                                    ),
                                  );

                                  if (pickedLocation != null) {
                                    setState(() {
                                      locationname =
                                          pickedLocation.formattedAddress;
                                      print("Address $locationname");

                                      Navigator.pop(context);
                                    });
                                  } else {}
                                  print("Hello ff");
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: dropname == null
                                        ? "Select Drop Location"
                                        : dropname.toString(),
                                    hintStyle: TextStyle(
                                        fontFamily: "worksans",
                                        color: Colors.white)),
                                style: TextStyle(
                                    fontFamily: "worksans",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Product Details",
                        style: TextStyle(
                            fontFamily: "worksans",
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),

                Container(
                  width: MediaQuery.of(context).size.width - 55,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black,width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Item Worth ",
                          prefix: Text("N"),
                          border: InputBorder.none),
                      style: TextStyle(fontFamily: "worksans"),
                      onChanged: (value) {
                        setState(() {
                          worth = value;
                          print("worth is $worth");
                        });
                      },
                    ),
                  ),
                ),
                //Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: DropdownButtonHideUnderline(
                //       child: DropdownButton(
                //     hint: Text("Select Vehicle",
                //         style: TextStyle(
                //             color: Colors.black, fontFamily: "worksans")),
                //     style: TextStyle(
                //         fontFamily: "worksans", color: Colors.black),
                //     items: genders,
                //     onChanged: (value) {
                //       setState(() {
                //         gen = value.toString();
                //         if (gen == "Delivery Car") {
                //           setState(() {
                //             Amount = 1000;
                //             print(Amount);
                //           });
                //         } else if (gen == "Delivery Bike") {
                //           setState(() {
                //             Amount = 3000;
                //             print(Amount);
                //           });
                //         } else {
                //           setState(() {
                //             Amount = 5000;
                //             print(Amount);
                //           });
                //         }

                //         print(gen);
                //       });
                //     },
                //     value: gen,
                //   )),
                // ),

                SizedBox(
                  height: 2.h,
                ),

                Container(
                  width: MediaQuery.of(context).size.width - 55,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black,width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: "Package Description ",
                          border: InputBorder.none),
                      style: TextStyle(fontFamily: "worksans"),
                      onChanged: (value) {
                        setState(() {
                          worth = value;
                          print("Description is $description");
                        });
                      },
                    ),
                  ),
                ),

                //Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: DropdownButtonHideUnderline(
                //       child: DropdownButton(
                //     hint: Text("Select Vehicle",
                //         style: TextStyle(
                //             color: Colors.black, fontFamily: "worksans")),
                //     style: TextStyle(
                //         fontFamily: "worksans", color: Colors.black),
                //     items: genders,
                //     onChanged: (value) {
                //       setState(() {
                //         gen = value.toString();
                //         if (gen == "Delivery Car") {
                //           setState(() {
                //             Amount = 1000;
                //             print(Amount);
                //           });
                //         } else if (gen == "Delivery Bike") {
                //           setState(() {
                //             Amount = 3000;
                //             print(Amount);
                //           });
                //         } else {
                //           setState(() {
                //             Amount = 5000;
                //             print(Amount);
                //           });
                //         }

                //         print(gen);
                //       });
                //     },
                //     value: gen,
                //   )),
                // ),

                  SizedBox(
                  height: 2.h,
                ),

                Container(
                  width: MediaQuery.of(context).size.width - 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black,width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      hint: Text("Select Package Type",
                          style: TextStyle(
                              color: Colors.black, fontFamily: "worksans")),
                      style: TextStyle(
                          fontFamily: "worksans", color: Colors.black),
                      items: productcategory,
                      onChanged: (value) {
                        setState(() {
                          cat = value.toString();
                          if (cat == "Parcel package (Fits Envelope)") {
                            setState(() {
                              Amount2 = 6000;
                              print(Amount2);
                            });
                          } else if (cat == "Small Box (Fits a Small Box)") {
                            setState(() {
                              Amount2 = 10000;
                              print(Amount2);
                            });
                          } else if (cat == "Jumbo Package (Fits a Big Box)") {
                            setState(() {
                              Amount2 = 12000;
                              print(Amount2);
                            });
                          } else if (cat == "Orobo package (Fits a Skid)") {
                            setState(() {
                              Amount2 = 15000;
                              print(Amount2);
                            });
                          } else if (cat == "Heavy weight(Fits a Big Skid)") {
                            setState(() {
                              Amount2 = 19000;
                              print(Amount2);
                            });
                          } else {
                            setState(() {
                              Amount2 = 5500;
                              print(Amount2);
                            });
                          }
                          print(cat);
                        });
                      },
                      value: cat,
                    )),
                  ),
                ),

                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      setState(() {
                        selecteddate = date;
                      });
                      print(selecteddate);
                    }, onChanged: (date) {});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 55,
                    height: 7.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                       border: Border.all(color: Colors.black,width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Select Date and Time"),
                            Icon(Icons.calendar_today)
                          ],
                        )),
                  ),
                ),

                SizedBox(
                  height: 2.h,
                ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 ucolor = scolor;
                //               });
                //             },
                //             child: Container(
                //               height: 12.h,
                //               width: 30.w,
                //               child: Image.asset("assets/biker.png"),
                //               decoration: BoxDecoration(
                //                   border: Border.all(width: 0.5, color: ucolor),
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(10)),
                //             ),
                //           ),
                //              GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 ucolor = scolor;
                //               });
                //             },
                //             child: Container(
                //               height: 12.h,
                //               width: 30.w,
                //               child: Image.asset("assets/biker.png"),
                //               decoration: BoxDecoration(
                //                   border: Border.all(width: 0.5, color: ucolor),
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(10)),
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 4.h,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //             GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 ucolor = scolor;
                //               });
                //             },
                //             child: Container(
                //               height: 12.h,
                //               width: 30.w,
                //               child: Image.asset("assets/biker.png"),
                //               decoration: BoxDecoration(
                //                   border: Border.all(width: 0.5, color: ucolor),
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(10)),
                //             ),
                //           ),
                //             GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 ucolor = scolor;
                //               });
                //             },
                //             child: Container(
                //               height: 12.h,
                //               width: 30.w,
                //               child: Image.asset("assets/biker.png"),
                //               decoration: BoxDecoration(
                //                   border: Border.all(width: 0.5, color: ucolor),
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(10)),
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // ),

               
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
                          chargecard();
                        });
                      });
                    }),
                    child: load
                        ? CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.black,
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
        ),
      );
    }));
  }
}
