import 'package:flutter/material.dart';

AppBar appbar({required final String title, final List<Widget>? actions}) => AppBar(
      title: Text(title),
      actions: actions,
    );
