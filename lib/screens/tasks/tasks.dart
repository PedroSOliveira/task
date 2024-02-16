import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/routes/app_routes.dart';
import 'package:task/theme/theme_helper.dart';
import 'package:task/utils/image_constant.dart';
import 'package:task/utils/size_utils.dart';
import 'package:task/widget/appbar_title.dart';

import 'controller/home_controller.dart';

// ignore_for_file: must_be_immutable
class TasksScreen extends StatefulWidget {
  TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  HomeController homeController = Get.put(HomeController());
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Container(
          color: appTheme.lightGray,
          width: mediaQueryData.size.width,
          child: Column(children: [
            // Padding(
            //   padding: EdgeInsets.only(left: 16.h, right: 16.h, top: 24.v),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       AppbarTitle(
            //         text: "msg_welcome_ronald",
            //       ),
            //       AppbarIconbutton(
            //         svgPath: ImageConstant().imgLockOnsecondarycontainer,
            //       ),
            //     ],
            //   ),
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 8.h, right: 8.h, top: 24.v, bottom: 16.v),
                child: Row(
                  children: List.generate(
                      controller.categoriesData.length,
                      (index) => GestureDetector(
                            onTap: () {
                              controller.currentPage = index;
                              pageController.animateToPage(index,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.bounceIn);
                              controller.update();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: controller.currentPage == index
                                      ? appTheme.buttonColor
                                      : appTheme.bgColor,
                                  borderRadius: BorderRadius.circular(
                                    12.h,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.h, vertical: 8.v),
                                  child: Text(
                                    controller.categoriesData[index].title!,
                                    style: TextStyle(
                                      color: controller.currentPage == index
                                          ? appTheme.bgColor
                                          : appTheme.black900,
                                      fontSize: 16.fSize,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: PageView.builder(
                  onPageChanged: (value) {
                    controller.currentPage = value;
                    controller.update();
                  },
                  controller: pageController,
                  itemCount: controller.categoriesData.length,
                  itemBuilder: (context, index) {
                    return TasksScreen();
                  },
                ),
              ),
            ),
          ])),
    );
  }

  onTapNotes() {
    Get.toNamed(
      AppRoutes.newNoteFilledScreen,
    );
  }
}
/*

 */