import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

Widget textFormField({required final String label}) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    Text(label).bodyText1(),
    const SizedBox(width: 100),
    TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 2)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 2)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 2)),
      ),
    ),
  ],
);
