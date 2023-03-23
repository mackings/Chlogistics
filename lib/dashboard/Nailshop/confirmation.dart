import 'dart:ffi';

import 'package:flutter/material.dart';

class Confirmation extends StatefulWidget {
  var text;
  final VoidCallback callback;
  final VoidCallback callback2;
  Confirmation({this.text, required this.callback,required this.callback2});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 180,
          width: double.infinity,
          child: Column(children: [
            Icon(Icons.notifications,size: 40,),
            Text(
              widget.text,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "worksans",
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: widget.callback2,
                    child: Container(
                        height: 50,
                        width: 100,
                        child: Center(
                            child: Text(
                          "No",
                          style: TextStyle(fontFamily: "worksans",
                          color: Colors.white),
                        )),
                        decoration: BoxDecoration(color: Colors.black,
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  GestureDetector(
                    onTap: widget.callback,
                    child: Container(
                        height: 50, 
                        width: 100,
                        child: Center(
                            child: Text(
                          "Yes",
                          style: TextStyle(fontFamily: "worksans"),
                        )),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black,width: 1.5),
                          borderRadius: BorderRadius.circular(10)
                          )),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
