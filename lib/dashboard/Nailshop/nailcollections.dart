import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chstores/dashboard/Nailshop/cartpage.dart';
import 'package:chstores/dashboard/Nailshop/confirmation.dart';
import 'package:chstores/dashboard/Nailshop/nailsummary.dart';
import 'package:chstores/dashboard/dashboard.dart';
import 'package:chstores/dialogs/registerdialog.dart';
import 'package:chstores/firebase_options.dart';
import 'package:chstores/models/nailmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sizer/sizer.dart';

class Nailcollections extends ConsumerStatefulWidget {
  const Nailcollections({Key? key}) : super(key: key);

  @override
  ConsumerState<Nailcollections> createState() => _NailcollectionsState();
}

class _NailcollectionsState extends ConsumerState<Nailcollections> {
  int? Amount;

  final pskey = "pk_live_e1bd7f3940dbf48ba9b658862a82ec1b55d9ec3d";
  final plugin = PaystackPlugin();

  final CartModel cart = CartModel();

  chargecard(amt) async {
    var charge = Charge()
      ..amount = amt * 100
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

  dynamic allprice = 0;

  @override
  void initState() {
    // TODO: implement initState
    plugin.initialize(publicKey: pskey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return Scaffold(
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Nails").snapshots(),
              builder: ((BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }
                List<Product> products = snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  return Product(
                    name: data['name'],
                    type: data['type'],
                    description: data['description'],
                    price: data['price'],
                    imageUrl: data['image'],
                  );
                }).toList();

                return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: ((BuildContext context, int index) {
                      Product mynails = products[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Amount = mynails.price;
                                  print(Amount);
                                });
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Nailsummary(
                                          addtocart: () {},
                                          name: mynails.name,
                                          description: mynails.description,
                                          price: mynails.price,
                                          callback: () {});
                                    });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width - 10.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      30.0, 10.0, 30.0, 10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 15.h,
                                        width: 35.w,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    mynails.imageUrl),
                                                fit: BoxFit.cover)),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                mynails.name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "worksans",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.sp),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                mynails.type,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "worksans",
                                                    fontSize: 10.sp),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                "N ${mynails.price}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "worksans",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.sp),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Confirmation(
                                                            text:
                                                                "Add This product to Cart?",
                                                            callback2: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            callback: () {
                                                              cart.addItem(
                                                                  Product(
                                                                name: mynails
                                                                    .name,
                                                                description: mynails
                                                                    .description,
                                                                price: mynails
                                                                    .price,
                                                                imageUrl: mynails
                                                                    .imageUrl,
                                                                type: mynails
                                                                    .type,
                                                              ));

                                                              Timer(
                                                                  Duration(
                                                                      seconds:
                                                                          0),
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                                final snack =
                                                                    SnackBar(
                                                                  content: Text(
                                                                      "Added To cart Successfully"),
                                                                );
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        snack);
                                                              });
                                                            });
                                                      });
                                                },
                                                child: Container(
                                                  height: 5.h,
                                                  width: 25.w,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black),
                                                  child: Center(
                                                    child: Text(
                                                      "Add To Cart",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }));
              })),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(Icons.shopping_basket),
              onPressed: () {
                print(cart.items.length);

                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return cart.items.length == 0
                          ? Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.shopping_basket,
                                    color: Colors.black,
                                    size: 80,
                                  ),
                                  Text(
                                    "Your Cart is Empty",
                                    style: TextStyle(fontFamily: "worksans"),
                                  ),
                                ],
                              ),
                            )
                          : Scaffold(
                              body: ListView.builder(
                                  itemCount: cart.items.length,
                                  itemBuilder: ((context, index) {
                                    final allitems = cart.items[index];

                                    if (cart.items.isEmpty) {
                                      return Text("Empty cart");
                                    } else {
                                      return SingleChildScrollView(
                                        child: cart.items.length == 0
                                            ? Text("Empty cart")
                                            : Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20.0, 30.0, 20.0, 5.0),
                                                    child: Container(
                                                      height: 10.h,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              20.w,
                                                      child: ListTile(
                                                        title: Text(
                                                          allitems.name == null
                                                              ? "No items"
                                                              : allitems.name,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        subtitle: Text(
                                                          "N ${allitems.price}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        trailing:
                                                            GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Confirmation(
                                                                          text:
                                                                              "Remove This product?",
                                                                          callback:
                                                                              () {
                                                                            cart.items.removeAt(index);

                                                                            final snack =
                                                                                SnackBar(
                                                                              content: Text("Product Removed Successfully"),
                                                                            );
                                                                            ScaffoldMessenger.of(context).showSnackBar(snack);
                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          callback2:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        );
                                                                      });
                                                                  //cart.items.removeAt(index);
                                                                },
                                                                child: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      );
                                    }
                                  })),
                              floatingActionButton: FloatingActionButton(
                                  backgroundColor: Colors.black,
                                  child: Text(
                                    "Pay", 
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    chargecard(cart.total.toInt());
                                  }),
                            );
                    });
              }),
        );
      }),
    );
  }
}
