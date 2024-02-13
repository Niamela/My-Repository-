import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:local_mining_supplier/router/routes.dart';
import 'package:sizer/sizer.dart';

Rx<TextEditingController> searchTextController = TextEditingController().obs;

Widget rowOfSearchWithTextField(context) {
  return SizedBox(
    width: 40.w,
    child: TextField(
      controller: searchTextController.value,
      onTap: () {
        GoRouter.of(context).pushNamed(AppRoutes.searchpage);
      },
      style: TextStyle(color: Colors.black),
      onTapOutside: (outside) {},
      onChanged: (value) {},
      onSubmitted: (value) {
        GoRouter.of(context).push('${AppPaths.searchPath}?query=${value}');
      },
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.sp),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
                bottomLeft: Radius.circular(10.sp),
              ),
              borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: mainColor,
          )),
    ),
  );
}
