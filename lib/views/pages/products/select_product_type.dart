import 'package:dashboard/views/widgets/appbar.dart';
import 'package:dashboard/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

class SelectProductType extends StatefulWidget {
  const SelectProductType({final Key? key}) : super(key: key);

  @override
  _SelectProductTypeState createState() => _SelectProductTypeState();
}

class _SelectProductTypeState extends State<SelectProductType> {
  @override
  Widget build(final BuildContext context) => scaffold(
    appBar: appbar(title: "Select Product Type"),
    body: column(
      isScrollable: true,
      children: <Widget>[
        button(onTap: (){},title: "Ad",maxWidth: true).marginSymmetric(vertical: 20),
        button(onTap: (){},title: "Daily Price",maxWidth: true),
        button(onTap: (){},title: "Tender",maxWidth: true).marginSymmetric(vertical: 20),
        button(onTap: (){},title: "Auction",maxWidth: true),
        button(onTap: (){},title: "Project",maxWidth: true).marginSymmetric(vertical: 20),
        button(onTap: (){},title: "Service",maxWidth: true),
        button(onTap: (){},title: "Consultant",maxWidth: true).marginSymmetric(vertical: 20),
        button(onTap: (){},title: "Company",maxWidth: true),
        button(onTap: (){},title: "Tutorial",maxWidth: true).marginSymmetric(vertical: 20),
        button(onTap: (){},title: "Magazine",maxWidth: true),
        const SizedBox(height: 20),
      ]
    )
  );
}
