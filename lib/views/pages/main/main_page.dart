import 'package:dashboard/views/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class MainPage extends StatefulWidget {
  const MainPage({final Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(final BuildContext context) => scaffold(
        appBar: AppBar(),
        drawer: drawer(),
        body: Container(),
      );
}
