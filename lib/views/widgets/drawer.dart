import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/categories/page.dart';
import 'package:dashboard/views/pages/products/page.dart';
import 'package:dashboard/views/pages/splash/splash_page.dart';
import 'package:dashboard/views/pages/tenders/page.dart';
import 'package:dashboard/views/pages/user/page.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

Widget drawer() => Drawer(
      child: Column(
        children: <Widget>[
          ListTile(title: Text(s.dashboard)),
          ListTile(title: Text(s.post), onTap: () => push(const ProductsPage())),
          ListTile(title: Text(s.users),onTap: () => push(const UserPage())),
          ListTile(title: Text(s.tenders), onTap: () => push(const TendersPage())),
          ListTile(title: Text(s.category), onTap: () => push(const CategoriesPage())),
          ListTile(title: Text(s.inactiveUsers)),
          ListTile(title: Text(s.reports)),
          ListTile(title: Text(s.logout),onTap: () {
            showYesCancelDialog(
              title: s.logout,
              description: s.areYouSureToExitFromYourAccount,
              onYesButtonTap: () {
                clearData();
                offAll(const SplashPage());
              },
            );

          },),
        ],
      ),
    );
