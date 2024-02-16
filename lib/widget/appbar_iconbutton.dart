// import 'package:flutter/material.dart';
// import 'package:task/utils/size_utils.dart';
// import 'package:task/widget/custom_icon_button.dart';

// // ignore: must_be_immutable
// class AppbarIconbutton extends StatelessWidget {
//   AppbarIconbutton({
//     Key? key,
//     this.imagePath,
//     this.svgPath,
//     this.margin,
//     this.onTap,
//   }) : super(
//           key: key,
//         );

//   String? imagePath;

//   String? svgPath;

//   EdgeInsetsGeometry? margin;

//   Function? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap?.call();
//       },
//       child: Padding(
//         padding: margin ?? EdgeInsets.zero,
//         child: CustomIconButton(
//           height: 40.adaptSize,
//           width: 40.adaptSize,
//           padding: EdgeInsets.all(8.h),
//           decoration: IconButtonStyleHelper.fillGray,
//           child: CustomImageView(
//             svgPath: svgPath,
//             imagePath: imagePath,
//           ),
//         ),
//       ),
//     );
//   }
// }
