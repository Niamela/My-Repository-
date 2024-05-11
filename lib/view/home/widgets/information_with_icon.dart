import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:sizer/sizer.dart';

Widget informationWithIcon(
    {IconData? icon, String? titleText, String? subtitle}) {
  return Padding(
    padding: EdgeInsets.all(3.sp),
    child: Container(
      height: 50.h,
      decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(10.sp)),
      padding: EdgeInsets.all(5.sp),
      child: Column(
        children: [
          Icon(icon, color: mainColor, size: 18.sp),
          SizedBox(
            height: 5.sp,
          ),
          SizedBox(
              width: 14.w,
              child: Text(titleText!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 5.sp, color: mainColor))),
          SizedBox(
            height: 5.sp,
          ),
          SizedBox(
              width: 18.w,
              child: Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 4.sp)))
        ],
      ),
    ),
  );
}

Widget informationWithIconMobile(
    {IconData? icon, String? titleText, String? subtitle}) {
  return Padding(
    padding: EdgeInsets.all(5.sp),
    child: Container(
      height: 20.h,
      width: 45.w,
      decoration: BoxDecoration(
          color: Color(0xFFCD7F32),
          borderRadius: BorderRadius.circular(10.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.sp,
            )
          ]),
      padding: EdgeInsets.all(5.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 35.sp),
          SizedBox(
            height: 5.sp,
          ),
          SizedBox(
              child: Text(titleText!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.sp, color: Colors.white))),
          SizedBox(
            height: 5.sp,
          ),
          SizedBox(
              child: Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8.sp, color: Colors.white)))
        ],
      ),
    ),
  );
}
