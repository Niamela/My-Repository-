import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:local_mining_supplier/router/routes.dart';
import 'package:sizer/sizer.dart';

Widget rowOfSearch() {
  return Container(
    width: 40.w,
    padding: EdgeInsets.all(2.5.sp),
    decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10.sp),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 2.sp, blurRadius: 2.sp)
        ],
        backgroundBlendMode: BlendMode.lighten),
    child: Row(
      children: [
        Text("data"),
        SizedBox(
            height: 10.sp,
            child: VerticalDivider(
              width: 1.sp,
              color: Colors.black,
            ))
      ],
    ),
  );
}

Rx<TextEditingController> searchTextController = TextEditingController().obs;

List list1 = [
  "D",
  "P",
  "Niam",
  "Di",
  "Dip",
];

final list2 = [].obs;

Widget rowOfSearchWithTextField(context) {
  return SizedBox(
    width: 40.w,
    child: Obx(() {
      return Column(
        children: [
          Obx(() {
            return TextField(
              controller: searchTextController.value,
              onTap: () {},
              style: TextStyle(color: Colors.black),
              onTapOutside: (outside) {
                list2.value = [];
                // searchTextController.value.clear();
              },
              onChanged: (value) {
                if (searchTextController.value.text.isEmpty) {
                  list2.value = [];
                }

                if (list1.contains(value)) {
                  if (!list2.contains(value)) {
                    // Optional: To avoid adding duplicate values
                    list2.add(value);
                  }
                }
              
              },
              // onSubmitted: (value){
              //     GoRouter.of(context).push(
              //       '${AppPaths.searchPath}?query=${value}}');
              // },
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
                        bottomRight: list2.isNotEmpty
                            ? Radius.circular(0)
                            : Radius.circular(10.sp),
                        bottomLeft: list2.isNotEmpty
                            ? Radius.circular(0)
                            : Radius.circular(10.sp),
                      ),
                      borderSide: BorderSide(color: Colors.white)),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: mainColor,
                  )),
            );
          }),
          list2.isNotEmpty
              ? Container(
                  width: 40.w,
                  padding: EdgeInsets.all(3.sp),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.sp),
                          bottomLeft: Radius.circular(10.sp))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(list2.length, (index) {
                      return Padding(
                        padding: EdgeInsets.all(2.sp),
                        child: InkWell(
                          onTap: () {
                            GoRouter.of(context)
                                .push(AppPaths.supplierProfilePath);
                          },
                          hoverColor: mainColor.withOpacity(0.10),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 700),
                            padding: EdgeInsets.only(left: 7.5.sp),
                            child: Obx(() {
                              return Text(
                                list2[index],
                                style: TextStyle(color: mainColor),
                              );
                            }),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              : Container()
        ],
      );
    }),
  );
}

// final controller = StandardSearchController();
//
// Widget searchBar() {
//   return SizedBox(
//       width: 30.w,
//       child: StandardSearchAnchor(
//         controller: controller,
//         searchBar: const StandardSearchBar(
//
//           leading: StandardIcons(
//             icons: [Icon(Icons.search)],
//           ),
//         ),
//         suggestions: const StandardSuggestions(suggestions: [
//           StandardSuggestion(text: 'Mechanic'),
//           StandardSuggestion(text: 'Miner'),
//           StandardSuggestion(text: 'Trucker'),
//         ]),
//       ));
// }
