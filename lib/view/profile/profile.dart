import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../model/usermodel.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  String? businessLogo =
      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/management-business-logo-design-template-029c8183c7ec4ff641c3853170a304ed_screen.jpg?ts=1584223008";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            topMenuBar(context),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 7.sp, left: 15.sp, right: 15.sp, bottom: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.sp),
                        child: CachedNetworkImage(
                          imageUrl: businessLogo!,
                          width: 25.sp,
                          height: 25.sp,
                        ),
                      ),
                      SizedBox(
                        width: 15.sp,
                      ),
                      Container(
                        width: 70.w,
                        height: 85.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6.sp,
                                spreadRadius: 2.sp,
                              )
                            ]),
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: SizedBox(
                                        height: 20.sp,
                                        width: 20.sp,
                                        child: CircularProgressIndicator()));
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData) {
                                return Center(child: Text('No data available'));
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
                                  children: [
                                    Text("${user.name}"),
                                    Text("${user.email}"),
                                    Text(
                                      "${user.mobileNumber}",
                                    ),
                                    Text("${user.services}"),
                                    Text("${user.about_company}"),
                                    Text("${user.address}"),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
