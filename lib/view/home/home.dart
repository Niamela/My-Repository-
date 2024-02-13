import 'package:cloud_firestore/cloud_firestore.dart';
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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("sitedata")
                    .doc("about")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                        height: 10.h,
                        width: 100.w,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No data available'));
                  }
                  final data = snapshot.data;
                  return Container(
                    // height: 10.h,
                    width: 100.w,
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(color: Color(0xFFB8860B)),
                    child: Column(
                      children: [
                        Text(
                          "For any queries please contact us.",
                          style: TextStyle(
                              fontSize: 5.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            informationRow(
                                label: "Email: ", value: data['email']),
                            informationRow(
                                label: "Call: ", value: data['number']),
                            informationRow(
                                label: "Location: ", value: data['location']),
                          ],
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget informationRow({label, value}) {
    return Row(
      children: [
        Text(
          "$label",
          style: TextStyle(
              fontSize: 5.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SelectableText(
          "$value",
          style: TextStyle(color: Colors.white, fontSize: 5.sp),
        )
      ],
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
