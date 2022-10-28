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
          ListTile(title: Text(s.dashboard).headline5()),
          // ListTile(title: Text(s.category), onTap: () => push(const CategoriesPage())),
          ListTile(title: const Text("Ads Product").headline5(), onTap: () => push(const AdsProductPage())),
          ExpansionTile(
            title: Text(s.category).headline5(),
            children: <Widget>[
              drawerItem(title: s.ads, onTap: () => push(const AdsPage())),
              drawerItem(title: s.jobs, onTap: () => push(const JobsPage())),
              drawerItem(title: s.tenders, onTap: () => push(const TendersPage())),
              drawerItem(title: s.projects, onTap: () => push(const ProjectsPage())),
              drawerItem(title: s.dailyPrice, onTap: () => push(const DailyPricePage())),
              drawerItem(title: s.magazine, onTap: () => push(const MagazinePage())),
              drawerItem(title: s.learn, onTap: () => push(const LearnPage())),
            ],
          ).marginSymmetric(horizontal: 16),

          ListTile(title: Text(s.post).headline5(), onTap: () => push(const AdsProductPage())),
          ListTile(title: Text(s.users).headline5(), onTap: () => push(const UserPage())),
          ListTile(title: Text(s.inactiveUsers).headline5()),
          ListTile(title: Text(s.reports).headline5()),
          ListTile(
            title: Text(s.logout).headline5(),
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
