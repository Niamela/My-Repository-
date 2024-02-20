import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:local_mining_supplier/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_mining_supplier/router/routes.dart';
import 'package:local_mining_supplier/view/home/widgets/information_with_icon.dart';
import 'package:local_mining_supplier/view/home/widgets/search_widget.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final backGroundImage1 = "assets/mining_bg.jpg";
  bool overlay = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor.withOpacity(0.10),
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
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
                          children: [
                            informationWithIcon(
                                icon: Icons.search,
                                titleText: AppLocalizations.of(context)!
                                    .discoverSuppliers,
                                subtitle: AppLocalizations.of(context)!
                                    .findAndCompareSuppliersInOver70000Categories),
                            informationWithIcon(
                                icon: Icons.currency_exchange,
                                titleText: AppLocalizations.of(context)!
                                    .getAnInstantQuote,
                                subtitle: AppLocalizations.of(context)!
                                    .uploadACADModelToGetAQuoteWithinSecondsForCNCMachining3DPrintingInjectionMoldingSheetMetalFabricationAndMore),
                            informationWithIcon(
                                icon: Icons.app_registration,
                                titleText: AppLocalizations.of(context)!
                                    .registerAsABuyer,
                                subtitle: AppLocalizations.of(context)!
                                    .registeredBuyersCanContactAndQuoteWithMultipleSuppliersCheckOutWithAQuoteAndPayOnTermsWithinOnePlatform),
                          ]))
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
                      return Center(
                          child: Text(
                              '${AppLocalizations.of(context)!.error}: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(
                          child: Text(
                              AppLocalizations.of(context)!.noDataAvailable));
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
                            AppLocalizations.of(context)!
                                .forAnyQueriesPleaseContactUs,
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
                                  label:
                                      "${AppLocalizations.of(context)!.contactInfo} :",
                                  value: data['email']),
                              informationRow(
                                  label:
                                      "${AppLocalizations.of(context)!.location} :",
                                  value: data['location']),
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
          if (overlay)
            Positioned.fill(
              child: Container(
                color: const Color.fromARGB(178, 255, 255, 255),
                height: 100.h,
                width: 100.w,
              ),
            ),
          if (overlay)
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
              child: Stack(children: [
                Container(
                    color: mainColor,
                    width: 90.w,
                    height: 60.h,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('sitedata')
                          .doc('Subscription_Data')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        final subscriptions = snapshot.data!;
                        return Center(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: subscriptions["Charges"].length,
                            itemBuilder: (context, index) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Container(
                                    height: 50.w,
                                    width: 22.w,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    child: Column(
                                      children: [
                                        Text(
                                          subscriptions["Sub_type"][index],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: mainColor),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            subscriptions["description"][index],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(
                                                  20.0), // Adjust padding as needed
                                              primary:
                                                  mainColor, // Button background color
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '\$',
                                                  style: TextStyle(
                                                    fontSize:
                                                        16.0, // Adjust font size as needed
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        8.0), // Adjust spacing between $ and price
                                                Text(
                                                  subscriptions["Charges"]
                                                          [index]
                                                      .toString(), // Sample price
                                                  style: TextStyle(
                                                    fontSize:
                                                        16.0, // Adjust font size as needed
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors
                                                        .white, // Price text color
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator(
                                  color: Colors.white,
                                );
                              }
                            },
                          ),
                        );
                      },
                    )),
                Positioned(
                  right: 1.w,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        overlay = false;
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    iconSize: 24.0,
                    splashRadius: 24.0,
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(),
                    splashColor: Colors.transparent,
                  ),
                ),
              ]),
            )
        ]),
      ),
    );
  }

  Widget informationRow({label, value}) {
    return Row(
      children: [
        Text(
          "$label ",
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
}
