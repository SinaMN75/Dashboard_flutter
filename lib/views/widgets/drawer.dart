import 'package:dashboard/core/core.dart';
import 'package:dashboard/views/pages/category/ads/page.dart';
import 'package:dashboard/views/pages/category/daily_price/page.dart';
import 'package:dashboard/views/pages/category/jobs/page.dart';
import 'package:dashboard/views/pages/category/learn/page.dart';
import 'package:dashboard/views/pages/category/magazine/page.dart';
import 'package:dashboard/views/pages/category/projects/page.dart';
import 'package:dashboard/views/pages/category/tenders/page.dart';
import 'package:dashboard/views/pages/products/ads/page.dart';
import 'package:dashboard/views/pages/splash/splash_page.dart';
import 'package:dashboard/views/pages/user/page.dart';
import 'package:flutter/material.dart';
import 'package:utilities/utilities.dart';

Widget drawer() => Drawer(
      child: Column(
        children: <Widget>[
          ListTile(title: Text(s.dashboard)),
          // ListTile(title: Text(s.category), onTap: () => push(const CategoriesPage())),
          ListTile(title: Text(s.ads), onTap: () => push(const AdsPage())),
          ListTile(title: const Text("Ads Product"), onTap: () => push(const AdsProductPage())),
          ListTile(title: Text(s.jobs), onTap: () => push(const JobsPage())),
          ListTile(title: Text(s.tenders), onTap: () => push(const TendersPage())),
          ListTile(title: Text(s.projects), onTap: () => push(const ProjectsPage())),
          ListTile(title: Text(s.dailyPrice), onTap: () => push(const DailyPricePage())),
          ListTile(title: Text(s.magazine), onTap: () => push(const MagazinePage())),
          ListTile(title: Text(s.learn), onTap: () => push(const LearnPage())),
          ListTile(title: Text(s.post), onTap: () => push(const AdsProductPage())),
          ListTile(title: Text(s.users), onTap: () => push(const UserPage())),
          ListTile(title: Text(s.inactiveUsers)),
          ListTile(title: Text(s.reports)),
          ListTile(
            title: Text(s.logout),
            onTap: () {
              showYesCancelDialog(
                title: s.logout,
                description: s.areYouSureToExitFromYourAccount,
                onYesButtonTap: () {
                  clearData();
                  offAll(const SplashPage());
                },
              );
            },
          ),
        ],
      ),
    );
