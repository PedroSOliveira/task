// import 'package:flutter/material.dart';
// import 'package:task/utils/image_constant.dart';


// // ignore: must_be_immutable
// class CustomBottomBar extends StatelessWidget {
//   CustomBottomBar({
//     Key? key,
//     this.onChanged,
//   }) : super(
//           key: key,
//         );

//   RxInt selectedIndex = 0.obs;

//   List<BottomMenuModel> bottomMenuList = [
//     BottomMenuModel(
//       icon: ImageConstant.imgNavhomeUnSelected,
//       activeIcon: ImageConstant.imgNavhomeSelected,
//       title: "lbl_home".tr,
//       type: BottomBarEnum.Home,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavfinishedUnSelected,
//       activeIcon: ImageConstant.imgNavfinishedSelected,
//       title: "lbl_finished".tr,
//       type: BottomBarEnum.Finished,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgPlus,
//       activeIcon: ImageConstant.imgPlus,
//       title: "lbl_home".tr,
//       type: BottomBarEnum.Home,
//       isCircle: true,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavsearchUnselected,
//       activeIcon: ImageConstant.imgNavsearchSelected,
//       title: "lbl_search".tr,
//       type: BottomBarEnum.Search,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavprofileUnselcted,
//       activeIcon: ImageConstant.imgNavprofileSelected,
//       title: "lbl_profile".tr,
//       type: BottomBarEnum.Profile,
//     )
//   ];

//   Function(BottomBarEnum)? onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: appTheme.bgColor,
//         boxShadow: [
//           BoxShadow(
//             color:appTheme.black900.withOpacity(0.03),
//             spreadRadius: 2.h,
//             blurRadius: 16,
//             offset: Offset(
//               0,
//               -6,
//             ),
//           ),
//         ],
//       ),
//       child: GetBuilder<CustomBottomBarController>(
//         init: CustomBottomBarController(),
//         builder:(controller) =>  BottomNavigationBar(
//           backgroundColor: Colors.transparent,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           elevation: 0,
//           currentIndex: controller.selectedIndex,
//           type: BottomNavigationBarType.fixed,
//           items: List.generate(bottomMenuList.length, (index) {
//             return
//                 BottomNavigationBarItem(
//               icon:index==2?Container(
//                 height: 56.v,
//                 width: 56.v,
//                 decoration: BoxDecoration(
//                     color: appTheme.buttonColor,
//                     shape: BoxShape.circle
//                 ),
//                 child: Padding(
//                   padding:  EdgeInsets.all(14.56.v),
//                   child: CustomImageView(
//                     svgPath: bottomMenuList[index].activeIcon,
//                     height: 24.v,
//                     width: 24.v,
//                     // color: ColorConstant.indigo800,
//                   ),
//                 ),
//               ): Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   CustomImageView(
//                     svgPath: bottomMenuList[index].icon,
//                     height: 24.v,
//                     width: 24.v,
//                     // color: ColorConstant.indigo800,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: 8.v,
//                     ),
//                     child: Text(
//                       bottomMenuList[index].title ?? "",
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.left,
//                       style: CustomTextStyles.bodyMediumPrimary.copyWith(
//                         color: appTheme.black40,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               activeIcon: index==2?Container(
//                 height: 56.v,
//                 width: 56.v,
//                 decoration: BoxDecoration(
//                   color: appTheme.buttonColor,
//                   shape: BoxShape.circle
//                 ),
//                 child: Padding(
//                   padding:  EdgeInsets.all(14.56.v),
//                   child: CustomImageView(
//                     svgPath: bottomMenuList[index].activeIcon,
//                     height: 24.v,
//                     width: 24.v,
//                     // color: ColorConstant.indigo800,
//                   ),
//                 ),
//               ):Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   CustomImageView(
//                     svgPath: bottomMenuList[index].activeIcon,
//                     height: 24.v,
//                     width: 24.v,
//                     // color: ColorConstant.indigo800,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: 8.v,
//                     ),
//                     child: Text(
//                       bottomMenuList[index].title ?? "",
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.left,
//                       style: CustomTextStyles.bodyMediumPrimary.copyWith(
//                         color: theme.colorScheme.primary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               label: '',
//             );
//           }),
//           onTap:  (index) {
//             index==2?Get.toNamed(AppRoutes.addNewNoteScreen):
//             controller.getIndex(index);
//           },
//         ),
//       ),
//     );
//   }
// }

// enum BottomBarEnum {
//   Home,
//   Finished,
//   Search,
//   Profile,
// }

// class BottomMenuModel {
//   BottomMenuModel({
//     required this.icon,
//     required this.activeIcon,
//     this.title,
//     required this.type,
//     this.isCircle = false,
//   });

//   String icon;

//   String activeIcon;

//   String? title;

//   BottomBarEnum type;

//   bool isCircle;
// }

// class DefaultWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.all(10),
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Please replace the respective Widget here',
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
