import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

Widget gridHeader(final String title) => Center(child: Text(title, textAlign: TextAlign.center).headline3());

Widget gridRow(final String title) => Container(
      alignment: Alignment.center,
      child: Text(title, textAlign: TextAlign.center).bodyText1(),
    );

Widget gridSwipeButton({
  required final String title,
  required final VoidCallback onTap,
  required final Color backgroundColor,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        color: backgroundColor,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
