import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

Widget textFormField({
  required final String label,
  final double? titleWidth,
  final ValueChanged<String>? onChanged,
  final TextEditingController? controller,
}) =>
    iconTextHorizontal(
      leading: SizedBox(width: titleWidth, child: Text(label).bodyText1()),
      spaceBetween: 16,
      trailing: Expanded(
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          decoration: const InputDecoration(
            fillColor: Colors.red,
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 2)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 2)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87, width: 2)),
          ),
        ),
      ),
    );
