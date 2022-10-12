import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

Widget textFormField({required final String label}) => iconTextHorizontal(
      leading: Text(label).bodyText1(),
      trailing: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 2)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 2)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 2)),
        ),
      ),
    );
