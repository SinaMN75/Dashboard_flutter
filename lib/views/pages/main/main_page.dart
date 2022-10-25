import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/widgets/drawer.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({final Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(),
        drawer: drawer(),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                AppImages.backImage,
                repeat: ImageRepeat.repeat,

              ),
            ),
            Container(),
          ],
        ),
      );
}
