import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:local_mining_supplier/constants/constants.dart';
import 'package:local_mining_supplier/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final backGroundImage =
      "https://cdn.pixabay.com/photo/2024/01/05/16/04/rocks-8489732_1280.jpg";

  // "https://images.pexels.com/photos/592753/pexels-photo-592753.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";

  // "https://images.pexels.com/photos/7412094/pexels-photo-7412094.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";

  bool isPhone = false;

  @override
  Widget build(BuildContext context) {
    isPhone = MediaQuery.of(context).size.width < 600;
    final texts = [
      AppLocalizations.of(context)!.forSuppliers,
      AppLocalizations.of(context)!.easyToUse,
      AppLocalizations.of(context)!.servicesOffers,
    ];
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppLocalizations.of(context)!.aboutUs),
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
              imageUrl: backGroundImage,
              fit: BoxFit.fill,
              placeholder: (context, string) => Center(
                    child: SizedBox(
                        height: 20.sp,
                        width: 20.sp,
                        child: CircularProgressIndicator()),
                  ),
              colorBlendMode: BlendMode.colorBurn),
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.50)),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isPhone ? SizedBox() : topMenuBar(context),
                  Padding(
                    padding: EdgeInsets.only(top: isPhone ? 30.sp : 0.sp),
                    child: SizedBox(
                      width: 90.w,
                      child: Text(
                        AppLocalizations.of(context)!.aboutHeader,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: isPhone ? 10.sp : 4.sp),
                      ),
                    ),
                  ),
                  isPhone
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(3, (index) {
                            return colWithImage(
                                image: images[index],
                                text: texts[index],
                                isPhone: isPhone);
                          }),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(3, (index) {
                            return colWithImage(
                                image: images[index],
                                text: texts[index],
                                isPhone: isPhone);
                          }),
                        ),
                  SizedBox(
                    height: 15.sp,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final images = [
    "https://png.pngtree.com/png-clipart/20230824/original/pngtree-business-teams-communication-in-internet-picture-image_8367483.png",
    "https://png.pngtree.com/png-clipart/20220131/original/pngtree-idea-concept-png-image_7257117.png",
    "https://png.pngtree.com/png-clipart/20230825/original/pngtree-business-team-character-having-finance-management-creative-ideas-picture-image_8723573.png",
  ];

  Widget colWithImage({required String text, required String image, isPhone}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
          imageUrl: image,
          width: isPhone ? 90.w : 30.w,
          height: 35.h,
        ),
        SizedBox(
            width: isPhone ? 80.w : 30.w,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: isPhone ? 14.sp : 4.sp),
            ))
      ],
    );
  }
}
