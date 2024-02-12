import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:local_mining_supplier/router/routes.dart';
import 'package:local_mining_supplier/view/home/widgets/information_with_icon.dart';
import 'package:local_mining_supplier/view/home/widgets/search_widget.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final backGroundImage1 = "assets/mining_bg.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor.withOpacity(0.10),
      body: SingleChildScrollView(
        child: Column(
          children: [
            topMenuBar(context),
            // Text('${LocalizationHelper.of(context)!.appName}'),
            Stack(
              children: [
                Container(
                  child: Image.asset(backGroundImage1),
                ),
                // Positioned(top: 10.sp, left: 10.sp, child: rowOfSearch()),
                Positioned(
                    top: 10.sp,
                    left: 10.sp,
                    child: InkWell(
                        onTap: () {
                          GoRouter.of(context).push(AppRoutes.searchpage);
                        },
                        child: rowOfSearchWithTextField(context))),
                Positioned(
                    bottom: 30.sp,
                    left: 25.sp,
                    right: 25.sp,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(listOfTitle.length, (index) {
                        return informationWithIcon(
                            icon: listOfIcons[index],
                            titleText: listOfTitle[index],
                            subtitle: listOfSubTitle[index]);
                      }),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  List listOfIcons = [
    Icons.search,
    Icons.currency_exchange,
    Icons.app_registration
  ];

  List listOfTitle = [
    "Discover Suppliers",
    "Get an Instant Quote",
    "Register as a Buyer"
  ];
  List listOfSubTitle = [
    "Find and compare suppliers in over 70,000 categories. Our team keeps listings up to date and assists with strategic sourcing opportunities.",
    "Upload a CAD model to get a quote within seconds for CNC machining, 3D printing, injection molding, sheet metal fabrication, and more.",
    "Registered buyers can contact and quote with multiple suppliers, check out with a quote, and pay on terms within one platform."
  ];
}
