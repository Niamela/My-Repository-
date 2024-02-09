import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/usermodel.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  String? businessLogo =
      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/management-business-logo-design-template-029c8183c7ec4ff641c3853170a304ed_screen.jpg?ts=1584223008";

  final isHovered = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            topMenuBar(context),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                        height: 90.h,
                        width: 100.w,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
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
                      about_company: data['about_company'],
                      displayPicture: data['displayPicture'],
                      websites: data['websites']);
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 7.sp, left: 15.sp, right: 15.sp, bottom: 10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20.w,
                          height: 85.h,
                          padding: EdgeInsets.only(top: 10.sp),
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
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  pickProfilePicture();
                                },
                                onHover: (value) {
                                  isHovered.value = value;
                                },
                                radius: 8.sp,
                                borderRadius: BorderRadius.circular(10.sp),
                                child: Obx(() {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      user.displayPicture != null &&
                                              user.displayPicture != ""
                                          ? CircleAvatar(
                                              minRadius: 10.sp,
                                              maxRadius: 12.sp,
                                              backgroundImage: NetworkImage(
                                                  "${user.displayPicture}"),
                                            )
                                          : CircleAvatar(
                                              minRadius: 10.sp,
                                              maxRadius: 12.sp,
                                            ),
                                      isHovered.value
                                          ? CircleAvatar(
                                              minRadius: 10.sp,
                                              maxRadius: 12.sp,
                                              backgroundColor: Colors.black38,
                                              child: Text(
                                                "Change Profile Picture",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 3.sp),
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  );
                                }),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              SizedBox(
                                height: 12.h,
                                width: 17.w,
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "${user.name}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 6.sp,
                                              color: Color(0xFFDAA520)),
                                        ),
                                        Text(
                                          "${user.email}",
                                          style: textStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Text("${user.mobileNumber}",
                                            style: textStyle,
                                            overflow: TextOverflow.ellipsis),
                                        Text("${user.address}",
                                            style: textStyle,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                    Positioned(
                                      top: -10,
                                      right: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    actionsAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    actionsPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.sp,
                                                            horizontal: 3.sp),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.sp),
                                                        side: BorderSide(
                                                            color: Color(
                                                                0xFFB8860B))),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            personalDataUpdate(
                                                              name: personalDataControllers[
                                                                          0]
                                                                      .value
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? personalDataControllers[
                                                                          0]
                                                                      .value
                                                                      .text
                                                                  : user.name,
                                                              email: personalDataControllers[
                                                                          1]
                                                                      .value
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? personalDataControllers[
                                                                          1]
                                                                      .value
                                                                      .text
                                                                  : user.email,
                                                              number: personalDataControllers[
                                                                          2]
                                                                      .value
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? personalDataControllers[
                                                                          2]
                                                                      .value
                                                                      .text
                                                                  : user
                                                                      .mobileNumber,
                                                              address: personalDataControllers[
                                                                          3]
                                                                      .value
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? personalDataControllers[
                                                                          3]
                                                                      .value
                                                                      .text
                                                                  : user
                                                                      .address,
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Update")),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("Cancel"))
                                                    ],
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: List.generate(4,
                                                          (index) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  2.sp),
                                                          child: TextField(
                                                            controller:
                                                                personalDataControllers[
                                                                        index]
                                                                    .value,
                                                            cursorColor: Color(
                                                                0xFFDAA520),
                                                            decoration: InputDecoration(
                                                                labelText:
                                                                    hintText[
                                                                        index],
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color: HexColor(
                                                                                "#FFB8860B")),
                                                                    borderRadius:
                                                                        BorderRadius.circular(5
                                                                            .sp)),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(5
                                                                            .sp),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                HexColor("#FFB8860B")))),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  );
                                                });
                                          },
                                          hoverColor: Color(0xFFFFD700),
                                          icon: Icon(
                                            Icons.edit,
                                            color: Color(0xFFB8860B),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              SizedBox(
                                width: 17.w,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Websites",
                                          style: TextStyle(
                                              fontSize: 5.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            websites.value =
                                                user.websites ?? [];
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    actionsAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    actionsPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3.sp,
                                                            horizontal: 3.sp),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.sp),
                                                        side: BorderSide(
                                                            color: Color(
                                                                0xFFB8860B))),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            websiteUpdate(
                                                                websites: websites
                                                                    .toList());
                                                            websiteController
                                                                .value
                                                                .clear();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Update")),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("Cancel"))
                                                    ],
                                                    content: SizedBox(
                                                      width: 50.w,
                                                      height: 60.h,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Obx(() {
                                                          return Column(
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: List
                                                                    .generate(1,
                                                                        (index) {
                                                                  return Padding(
                                                                    padding: EdgeInsets
                                                                        .all(2
                                                                            .sp),
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          websiteController
                                                                              .value,
                                                                      cursorColor:
                                                                          Color(
                                                                              0xFFDAA520),
                                                                      onSubmitted:
                                                                          (value) {
                                                                        if (websiteController.value.text.isNotEmpty &&
                                                                            websites.length <
                                                                                3) {
                                                                          websites.add(websiteController
                                                                              .value
                                                                              .text);
                                                                          websiteController
                                                                              .value
                                                                              .clear();
                                                                        } else {
                                                                          toast(
                                                                              msg: "You can add upto 3 websites only.");
                                                                        }
                                                                      },
                                                                      decoration: InputDecoration(
                                                                          suffixIcon: IconButton(
                                                                              onPressed: () {
                                                                                if (websiteController.value.text.isNotEmpty && websites.length < 3) {
                                                                                  websites.add(websiteController.value.text);
                                                                                  websiteController.value.clear();
                                                                                } else {
                                                                                  toast(msg: "You can add upto 3 websites only.");
                                                                                }
                                                                              },
                                                                              splashRadius: 4.sp,
                                                                              icon: Icon(Icons.add)),
                                                                          labelText: "website url",
                                                                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: HexColor("#FFB8860B")), borderRadius: BorderRadius.circular(5.sp)),
                                                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp), borderSide: BorderSide(color: HexColor("#FFB8860B")))),
                                                                    ),
                                                                  );
                                                                }),
                                                              ),
                                                              SizedBox(
                                                                height: 2.sp,
                                                              ),
                                                              websites.isNotEmpty
                                                                  ? Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5
                                                                              .sp),
                                                                          border:
                                                                              Border.all(color: HexColor("#FFB8860B"))),
                                                                      padding: EdgeInsets
                                                                          .all(2
                                                                              .sp),
                                                                      child: Obx(
                                                                          () {
                                                                        return Wrap(
                                                                          direction:
                                                                              Axis.vertical,
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment.start,
                                                                          children: List.generate(
                                                                              websites.length,
                                                                              (index) {
                                                                            return Padding(
                                                                              padding: EdgeInsets.all(1.sp),
                                                                              child: Container(
                                                                                padding: EdgeInsets.all(2.sp),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.sp), color: HexColor("#FFB8860B")),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Obx(() {
                                                                                      return Text(
                                                                                        "${websites[index]}",
                                                                                        style: TextStyle(fontSize: 4.sp, color: Colors.white),
                                                                                      );
                                                                                    }),
                                                                                    IconButton(
                                                                                        onPressed: () {
                                                                                          websites.remove(websites[index]);
                                                                                        },
                                                                                        padding: EdgeInsets.zero,
                                                                                        constraints: BoxConstraints(),
                                                                                        splashRadius: 5.sp,
                                                                                        icon: Icon(
                                                                                          Icons.clear,
                                                                                          color: Colors.white,
                                                                                          size: 5.sp,
                                                                                        ))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      }),
                                                                    )
                                                                  : Container()
                                                            ],
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            size: 5.sp,
                                          ),
                                          splashRadius: 5.sp,
                                        )
                                      ],
                                    ),
                                    user.websites != null &&
                                            user.websites!.length > 0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(3, (index) {
                                              return InkWell(
                                                onTap: () {
                                                  launch(
                                                    user.websites![index],
                                                  );
                                                },
                                                child: Text(
                                                  "${user.websites![index]}",
                                                  style: TextStyle(
                                                      fontSize: 4.sp,
                                                      color: Colors.blue),
                                                ),
                                              );
                                            }),
                                          )
                                        : Text("Please add websites"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    addedServices.value = user.services != null
                                        ? user.services!
                                        : [];
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actionsPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 3.sp,
                                                    horizontal: 3.sp),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3.sp),
                                                side: BorderSide(
                                                    color: Color(0xFFB8860B))),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    companyUpdate(
                                                      aboutComapny:
                                                          companyUpdateControllers[
                                                                      0]
                                                                  .value
                                                                  .text
                                                                  .isNotEmpty
                                                              ? companyUpdateControllers[
                                                                      0]
                                                                  .value
                                                                  .text
                                                              : user
                                                                  .about_company,
                                                      services: addedServices
                                                          .toList(),
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Update")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel"))
                                            ],
                                            content: SizedBox(
                                              width: 50.w,
                                              height: 60.h,
                                              child: SingleChildScrollView(
                                                child: Obx(() {
                                                  return Column(
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: List.generate(
                                                            2, (index) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.sp),
                                                            child: TextField(
                                                              maxLines:
                                                                  index == 0
                                                                      ? 4
                                                                      : 1,
                                                              controller:
                                                                  companyUpdateControllers[
                                                                          index]
                                                                      .value,
                                                              cursorColor: Color(
                                                                  0xFFDAA520),
                                                              onSubmitted:
                                                                  (value) {
                                                                if (companyUpdateControllers[
                                                                        1]
                                                                    .value
                                                                    .text
                                                                    .isNotEmpty) {
                                                                  addedServices.add(
                                                                      companyUpdateControllers[
                                                                              1]
                                                                          .value
                                                                          .text);
                                                                  companyUpdateControllers[
                                                                          1]
                                                                      .value
                                                                      .clear();
                                                                }
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                      suffixIcon: index ==
                                                                              1
                                                                          ? IconButton(
                                                                              onPressed:
                                                                                  () {
                                                                                if (companyUpdateControllers[1].value.text.isNotEmpty) {
                                                                                  addedServices.add(companyUpdateControllers[1].value.text);
                                                                                  companyUpdateControllers[1].value.clear();
                                                                                }
                                                                              },
                                                                              splashRadius: 4
                                                                                  .sp,
                                                                              icon: Icon(Icons
                                                                                  .add))
                                                                          : SizedBox(),
                                                                      labelText:
                                                                          hintText2[
                                                                              index],
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: HexColor(
                                                                                  "#FFB8860B")),
                                                                          borderRadius: BorderRadius.circular(5
                                                                              .sp)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(5
                                                                              .sp),
                                                                          borderSide:
                                                                              BorderSide(color: HexColor("#FFB8860B")))),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                      SizedBox(
                                                        height: 2.sp,
                                                      ),
                                                      addedServices.isNotEmpty
                                                          ? Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(5
                                                                              .sp),
                                                                  border: Border.all(
                                                                      color: HexColor(
                                                                          "#FFB8860B"))),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          2.sp),
                                                              child: Obx(() {
                                                                return Wrap(
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .start,
                                                                  children: List.generate(
                                                                      addedServices
                                                                          .length,
                                                                      (index) {
                                                                    return Padding(
                                                                      padding: EdgeInsets
                                                                          .all(1
                                                                              .sp),
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(2.sp),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(2.sp),
                                                                            color: HexColor("#FFB8860B")),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Obx(() {
                                                                              return Text(
                                                                                "${addedServices[index]}",
                                                                                style: TextStyle(fontSize: 4.sp, color: Colors.white),
                                                                              );
                                                                            }),
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  addedServices.remove(addedServices[index]);
                                                                                },
                                                                                padding: EdgeInsets.zero,
                                                                                constraints: BoxConstraints(),
                                                                                splashRadius: 5.sp,
                                                                                icon: Icon(
                                                                                  Icons.clear,
                                                                                  color: Colors.white,
                                                                                  size: 5.sp,
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                );
                                                              }),
                                                            )
                                                          : Container()
                                                    ],
                                                  );
                                                }),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text("Edit company info"))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.sp,
                        ),
                        Container(
                          width: 65.w,
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
                          child: Padding(
                            padding: EdgeInsets.all(5.sp),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5.sp),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.sp),
                                      border:
                                          Border.all(color: Color(0xFFDAA520))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Services:",
                                        style: TextStyle(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 10.sp,
                                      ),
                                      Container(
                                        width: 40.w,
                                        child: user.services != null
                                            ? Wrap(
                                                direction: Axis.horizontal,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                alignment: WrapAlignment.start,
                                                children: List.generate(
                                                    user.services!.length,
                                                    (index) {
                                                  return Text(
                                                    user.services!.length - 1 ==
                                                            index
                                                        ? "${user.services![index]}"
                                                        : "${user.services![index]}, ",
                                                    style: TextStyle(
                                                        fontSize: 6.sp,
                                                        color:
                                                            Color(0xFFDAA520)),
                                                  );
                                                }),
                                              )
                                            : Text("Please add services.  "),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Products",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 5.sp),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          addedProducts.value =
                                              data['products'] ?? [];
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  actionsAlignment:
                                                      MainAxisAlignment.center,
                                                  actionsPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 3.sp,
                                                          horizontal: 3.sp),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.sp),
                                                      side: BorderSide(
                                                          color: Color(
                                                              0xFFB8860B))),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          productsUpdate(
                                                              products:
                                                                  addedProducts
                                                                      .toList());
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Update")),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Cancel"))
                                                  ],
                                                  content: SizedBox(
                                                    width: 50.w,
                                                    height: 60.h,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Obx(() {
                                                        return Column(
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children:
                                                                  List.generate(
                                                                      2,
                                                                      (index) {
                                                                return Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(2
                                                                              .sp),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        productsControllers[index]
                                                                            .value,
                                                                    cursorColor:
                                                                        Color(
                                                                            0xFFDAA520),
                                                                    onSubmitted:
                                                                        (value) {
                                                                      if (productsControllers[1]
                                                                              .value
                                                                              .text
                                                                              .isNotEmpty &&
                                                                          productsControllers[0]
                                                                              .value
                                                                              .text
                                                                              .isNotEmpty) {
                                                                        Map map =
                                                                            {
                                                                          "name": productsControllers[0]
                                                                              .value
                                                                              .text,
                                                                          "image": productsControllers[1]
                                                                              .value
                                                                              .text,
                                                                        };
                                                                        addedProducts
                                                                            .add(map);
                                                                      }
                                                                    },
                                                                    decoration: InputDecoration(
                                                                        suffixIcon: index == 1
                                                                            ? IconButton(
                                                                                onPressed: () {
                                                                                  if (productsControllers[1].value.text.isNotEmpty && productsControllers[0].value.text.isNotEmpty) {
                                                                                    Map map = {
                                                                                      "name": productsControllers[0].value.text,
                                                                                      "image": productsControllers[1].value.text,
                                                                                    };
                                                                                    addedProducts.add(map);
                                                                                  }
                                                                                },
                                                                                splashRadius: 4.sp,
                                                                                icon: Icon(Icons.add))
                                                                            : SizedBox(),
                                                                        labelText: hintText3[index],
                                                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: HexColor("#FFB8860B")), borderRadius: BorderRadius.circular(5.sp)),
                                                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.sp), borderSide: BorderSide(color: HexColor("#FFB8860B")))),
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                            SizedBox(
                                                              height: 2.sp,
                                                            ),
                                                            addedProducts
                                                                    .isNotEmpty
                                                                ? Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5
                                                                                .sp),
                                                                        border: Border.all(
                                                                            color:
                                                                                HexColor("#FFB8860B"))),
                                                                    padding: EdgeInsets
                                                                        .all(2
                                                                            .sp),
                                                                    child:
                                                                        Obx(() {
                                                                      return Wrap(
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        crossAxisAlignment:
                                                                            WrapCrossAlignment.start,
                                                                        children: List.generate(
                                                                            addedProducts.length,
                                                                            (index) {
                                                                          return Padding(
                                                                            padding:
                                                                                EdgeInsets.all(1.sp),
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.all(2.sp),
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.sp), color: HexColor("#FFB8860B")),
                                                                              child: Column(
                                                                                children: [
                                                                                  Obx(() {
                                                                                    return Image.network(
                                                                                      "${addedProducts[index]["image"]}",
                                                                                      width: 8.sp,
                                                                                      height: 8.sp,
                                                                                    );
                                                                                  }),
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Obx(() {
                                                                                        return Text(
                                                                                          "${addedProducts[index]["name"]}",
                                                                                          style: TextStyle(fontSize: 4.sp, color: Colors.white),
                                                                                        );
                                                                                      }),
                                                                                      IconButton(
                                                                                          onPressed: () {
                                                                                            addedProducts.remove(addedProducts[index]);
                                                                                          },
                                                                                          padding: EdgeInsets.zero,
                                                                                          constraints: BoxConstraints(),
                                                                                          splashRadius: 5.sp,
                                                                                          icon: Icon(
                                                                                            Icons.clear,
                                                                                            color: Colors.white,
                                                                                            size: 5.sp,
                                                                                          ))
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                                      );
                                                                    }),
                                                                  )
                                                                : Container()
                                                          ],
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        splashRadius: 5.sp,
                                        icon: Icon(
                                          Icons.add,
                                          size: 5.sp,
                                        ))
                                  ],
                                ),
                                data['products'] != null &&
                                        data['products'].length > 0
                                    ? Wrap(
                                        direction: Axis.horizontal,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.start,
                                        children: List.generate(
                                            data['products'].length,
                                            (gridIndex) {
                                          return Padding(
                                            padding: EdgeInsets.all(1.sp),
                                            child: Container(
                                              width: 30.w,
                                              padding: EdgeInsets.all(1.sp),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.sp),
                                                    child: Image.network(
                                                      data['products']
                                                          [gridIndex]['image'],
                                                      width: 10.sp,
                                                      height: 10.sp,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.sp,
                                                  ),
                                                  Text(
                                                    "${data['products'][gridIndex]['name']}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 4.sp,
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      )
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Please add products.")),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text("About company",
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 3.h,
                                ),
                                user.about_company != null
                                    ? SelectableText("${user.about_company}",
                                        style: TextStyle(
                                            fontSize: 5.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500))
                                    : Text("Please add company information"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  final productsControllers =
      List.generate(2, (index) => TextEditingController().obs);

  final personalDataControllers =
      List.generate(4, (index) => TextEditingController().obs);
  final websiteController = TextEditingController().obs;

  final hintText = ["Name", "Email", "Mobile number", "Address"];
  final hintText2 = ["About company", "Service"];
  final hintText3 = ["Product Name", "Product image url"];

  websiteUpdate({websites}) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'websites': websites,
      });
      websiteController.value.clear();
      toast(msg: "Websites updated.");
    } catch (e) {
      print("productsUpdate : $e");
      toast(msg: "Could not update the website.");
    }
  }

  personalDataUpdate({name, number, email, address}) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'name': name,
        'email': email,
        'mobileNumber': number,
        "address": address
      });
      personalDataControllers.forEach((element) {
        element.value.clear();
      });
      toast(msg: "Data updated successfully.");
    } catch (e) {
      print("Error : $e");
      toast(msg: "Could not update the data.");
    }
  }

  final companyUpdateControllers =
      List.generate(2, (index) => TextEditingController().obs);

  final addedServices = [].obs;
  final addedProducts = [].obs;
  final websites = [].obs;

  companyUpdate({services, aboutComapny}) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'services': services, 'about_company': aboutComapny});
      companyUpdateControllers.forEach((element) {
        element.value.clear();
      });
      toast(msg: "Details updated successfully.");
    } catch (e) {
      print("companyUpdate : $e");
      toast(msg: "Could not update the details.");
    }
  }

  productsUpdate({products}) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'products': products,
      });
      productsControllers.forEach((element) {
        element.value.clear();
      });
      toast(msg: "Details updated successfully.");
    } catch (e) {
      print("productsUpdate : $e");
      toast(msg: "Could not update the details.");
    }
  }

  final textStyle = TextStyle(fontSize: 4.sp, color: Color(0xFFDAA520));

  Rx<Uint8List?> profilePictureBytes = Rx<Uint8List?>(null);
  final ppName = ''.obs;

  Future<void> pickProfilePicture() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        // Use `bytes` instead of `path` for web
        profilePictureBytes.value = result.files.single.bytes;
        ppName.value = result.files.first.name;
        uploadProfilePicture();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick a file. $e');
    }
  }

  Future<void> uploadProfilePicture() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not authenticated.');
        return;
      }

      if (profilePictureBytes.value == null) {
        Get.snackbar('Error', 'Please select a profile picture to upload.');
        return;
      }

      final resumeRef = FirebaseStorage.instance.ref(
          'profilePictures/${FirebaseAuth.instance.currentUser!.email}/${DateTime.now().millisecondsSinceEpoch}_$ppName');

      // Use `putData` instead of `putFile` for web
      await resumeRef.putData(profilePictureBytes.value!);

      final ppUrl = await resumeRef.getDownloadURL();

      // Update the resume link in the user's document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'displayPicture': ppUrl,
      });
      toast(msg: "Profile picture changed.");
    } catch (e) {
      print("uploadProfilePicture $e");
      toast(msg: "Error: 'Profile picture upload failed.");
    }
  }
}
