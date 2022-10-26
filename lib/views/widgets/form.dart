import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

Widget textFormField({
  required final String label,
  final double? width,
  final ValueChanged<String>? onChanged,
  final TextEditingController? controller,
  final TextInputType? keyboardType,
}) =>
    SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label).bodyText1(),
          const SizedBox(height: 8),
          TextFormField(
            onChanged: onChanged,
            controller: controller,
            keyboardType: keyboardType,
            decoration:  InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: context.theme.disabledColor.withOpacity(0.6), width: 2)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.theme.disabledColor.withOpacity(0.6), width: 2)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.theme.disabledColor.withOpacity(0.6), width: 2)),
            ),
          ),
        ],
      ),
    );

Widget textFormField2({
  required final String label,
  final double? width,
  final ValueChanged<String>? onChanged,
  final TextEditingController? controller,
}) =>
    iconTextHorizontal(
      leading: SizedBox(width: width, child: Text(label).bodyText1()),
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
