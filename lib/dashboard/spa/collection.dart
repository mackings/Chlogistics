import 'dart:ui';

import 'package:chstores/Auths/Signin.dart';
import 'package:chstores/dashboard/spa/bottomsheet.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:sizer/sizer.dart';

class FacialCollection extends ConsumerStatefulWidget {
  const FacialCollection({Key? key}) : super(key: key);

  @override
  ConsumerState<FacialCollection> createState() => _FacialCollectionState();
}

class _FacialCollectionState extends ConsumerState<FacialCollection> {
  dynamic des1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.2015";
  Future getit(name, age) async {
    print(name);
    print(age);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text("Collections",style: TextStyle(
                          fontFamily:"worksans",
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp
                        ),)
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 12.h,
                        width: MediaQuery.of(context).size.width-10.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5,color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                          
                        ),
                        child: Center(
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                    context: context,
                                    bounce: true,
                                    isDismissible: false,
                                    useRootNavigator: true,
                                    builder: (context) {
                                      return Bottomsheet(
                                          title: "Secondar Face",
                                          description: des1.toString(),
                                          price: 4000,
                                          load: false,
                                          callback: () {
                                            getit("Macs", "lawren");
                                            print("Completed");
                                          });
                                    });
                              },
                              child: Container(
                                  height: 100.h,
                                  width: 20.w,
                                  child: Center(
                                    child: Text(
                                      "F",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                            title: Text("Full Spa",style: TextStyle(
                              fontFamily:"worksans",
                              color: Colors.black
                            ),),
                            subtitle:
                                Text("Spa That beats the usual in terms of standard",style: TextStyle(
                              fontFamily:"worksans",
                              color: Colors.black
                            ),),
                            trailing: Icon(Icons.arrow_forward_ios),
                            selectedTileColor: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                 
                      
                      SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 12.h,
                        width: MediaQuery.of(context).size.width-10.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5,color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                          
                        ),
                        child: Center(
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                    context: context,
                                    bounce: true,
                                    isDismissible: false,
                                    useRootNavigator: true,
                                    builder: (context) {
                                      return Bottomsheet(
                                          title: "Secondar Face",
                                          description: des1.toString(),
                                          price: 4000,
                                          load: false,
                                          callback: () {
                                            getit("Macs", "lawren");
                                            print("Completed");
                                          });
                                    });
                              },
                              child: Container(
                                  height: 100.h,
                                  width: 20.w,
                                  child: Center(
                                    child: Text(
                                      "F",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                            title: Text("Full Spa",style: TextStyle(
                              fontFamily:"worksans",
                              color: Colors.black
                            ),),
                            subtitle:
                                Text("Spa That beats the usual in terms of standard",style: TextStyle(
                              fontFamily:"worksans",
                              color: Colors.black
                            ),),
                            trailing: Icon(Icons.arrow_forward_ios),
                            selectedTileColor: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                 
                   SizedBox(
                      height: 2.h,
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 12.h,
                        width: MediaQuery.of(context).size.width-10.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5,color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                          
                        ),
                        child: Center(
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                    context: context,
                                    bounce: true,
                                    isDismissible: false,
                                    useRootNavigator: true,
                                    builder: (context) {
                                      return Bottomsheet(
                                          title: "Secondar Face",
                                          description: des1.toString(),
                                          price: 4000,
                                          load: false,
                                          callback: () {
                                            getit("Macs", "lawren");
                                            print("Completed");
                                          });
                                    });
                              },
                              child: Container(
                                  height: 100.h,
                                  width: 20.w,
                                  child: Center(
                                    child: Text(
                                      "F",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                            title: Text("Full Spa",style: TextStyle(
                              fontFamily:"worksans",
                              color: Colors.black
                            ),),
                            subtitle:
                                Text("Spa That beats the usual in terms of standard",style: TextStyle(
                              fontFamily:"worksans",
                              color: Colors.black
                            ),),
                            trailing: Icon(Icons.arrow_forward_ios),
                            selectedTileColor: Colors.blue,
                          ),
                        ),
                      ),
                    ),

                   SizedBox(
                      height: 2.h,
                    ),
                     
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 12.h,
                        width: MediaQuery.of(context).size.width-10.w,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5,color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                          
                        ),
                        child: Center(
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                    context: context,
                                    bounce: true,
                                    isDismissible: false,
                                    useRootNavigator: true,
                                    builder: (context) {
                                      return Bottomsheet(
                                          title: "Secondar Face",
                                          description: des1.toString(),
                                          price: 4000,
                                          load: false,
                                          callback: () {
                                            getit("Macs", "lawren");
                                            print("Completed");
                                          });
                                    });
                              },
                              child: Container(
                                  height: 100.h,
                                  width: 20.w,
                                  child: Center(
                                    child: Text(
                                      "F",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                            title: Text("Full Spa",style: TextStyle(
                              fontFamily:"worksans",
                              color: Colors.black
                            ),),
                            subtitle:
                                Text("Spa That beats the usual in terms of standard",style: TextStyle(
                              fontFamily:"worksans",
                              color: Colors.black
                            ),),
                            trailing: Icon(Icons.arrow_forward_ios),
                            selectedTileColor: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                 
                 
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }
}


