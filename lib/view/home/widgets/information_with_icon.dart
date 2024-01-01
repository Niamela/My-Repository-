import 'package:flutter/cupertino.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:sizer/sizer.dart';

Widget informationWithIcon(
    {IconData? icon, String? titleText, String? subtitle}) {
  return Padding(
    padding: EdgeInsets.all(3.sp),
    child: Container(
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
                  style: TextStyle(fontSize: 6.sp, color: mainColor))),
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
