import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:local_mining_supplier/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../model/usermodel.dart';

class SupplierProfile extends StatelessWidget {
  SupplierProfile({super.key});

  final isLoaded = false.obs;

  final titleTextStyle = TextStyle(
    fontSize: 8.sp,
    color: mainColor,
  );

  final subtitleTextStyle = TextStyle(
    fontSize: 5.sp,
    color: mainColor,
  );

  final valueTextStyle = TextStyle(
    fontSize: 5.sp,
    color: Colors.black,
  );

  final sizedBox = SizedBox(
    height: 2.5.sp,
  );

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      isLoaded.value = true;
    });
    return Obx(() {
      return isLoaded.value
          ? Scaffold(
              backgroundColor: mainColor.withOpacity(0.10),
              body: Column(
                children: [
                  topMenuBar(context),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc("GYjkKxMemeWDvgtb6pQmnLa57FY2")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: SizedBox(
                                  height: 10.sp,
                                  width: 10.sp,
                                  child: CircularProgressIndicator()));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('${AppLocalizations.of(context)!.error}: ${snapshot.error}'));
                        } else if (!snapshot.hasData) {
                          return Center(child: Text(AppLocalizations.of(context)!.noDataAvailable));
                        }
                        final data = snapshot.data!.data()!;
                        UserModel user = UserModel(
                            name: data['name'],
                            email: data['email'],
                            mobileNumber: data['mobileNumber'],
                            services: data['services'],
                            address: data['address'],
                            about_company: data['about_company']);
                        return Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.supplierDetails, style: titleTextStyle),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Row(
                                children: [
                                  Text("${AppLocalizations.of(context)!.supplierName}: ",
                                      style: subtitleTextStyle),
                                  SelectableText("${user.name}",
                                      style: valueTextStyle),
                                ],
                              ),
                              sizedBox,
                              Row(
                                children: [
                                  Text("${AppLocalizations.of(context)!.supplierEmail}: ",
                                      style: subtitleTextStyle),
                                  SelectableText("${user.email}",
                                      style: valueTextStyle),
                                ],
                              ),
                              sizedBox,
                              Row(
                                children: [
                                  Text("${AppLocalizations.of(context)!.supplierLocation}: ",
                                      style: subtitleTextStyle),
                                  SelectableText("${user.address}",
                                      style: valueTextStyle),
                                ],
                              ),
                              sizedBox,
                              Row(
                                children: [
                                  Text("${AppLocalizations.of(context)!.supplierContactNumber}: ",
                                      style: subtitleTextStyle),
                                  SelectableText("${user.mobileNumber}",
                                      style: valueTextStyle),
                                ],
                              ),
                              sizedBox,
                              user.services!.isNotEmpty
                                  ? Row(
                                      children: [
                                        Text("${AppLocalizations.of(context)!.servicesOffered}: ",
                                            style: subtitleTextStyle),
                                        Row(
                                          children: List.generate(
                                              user.services!.length, (index) {
                                            return SelectableText(
                                              index == user.services!.length - 1
                                                  ? "${user.services![index]}"
                                                  : "${user.services![index]}, ",
                                              style: valueTextStyle,
                                            );
                                          }),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${AppLocalizations.of(context)!.aboutSupplier}: ",
                                      style: subtitleTextStyle),
                                  SizedBox(
                                      width: 80.w,
                                      child: SelectableText(
                                        "${user.about_company}",
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.black,
                                            fontSize: 5.sp),
                                      )),
                                ],
                              )
                            ],
                          ),
                        );
                      })
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}
