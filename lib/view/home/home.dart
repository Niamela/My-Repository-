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
