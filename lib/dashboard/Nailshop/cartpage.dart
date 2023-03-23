import 'package:chstores/models/nailmodel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({Key? key}) : super(key: key);

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  
  final CartModel cart = CartModel();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: ((context, index) {
          final allitems = cart.items[index];
          return Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(allitems.name),
              Text("${allitems.price}"),
              Text("yellow")
            ],
          );
        }));
  }
}
