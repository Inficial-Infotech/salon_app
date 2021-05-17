import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:salon_app/app/controller/home_controller/notify_controllers/notify_controller.dart';
import 'package:salon_app/app/data/model/new_api.dart';
import 'package:salon_app/app/data/model/posts_model.dart';
import 'package:salon_app/app/ui/theme/app_colors.dart';
import 'package:salon_app/app/ui/theme/app_text_theme.dart';
import 'package:salon_app/app/ui/utils/base/BaseList.dart';

import 'package:salon_app/app/ui/utils/math_utils.dart';
import 'package:salon_app/app/ui/constants/image_constants.dart';

class Notify extends StatelessWidget {
  final controller = Get.put<NotifyController>(NotifyController());
  // RefreshController refreshController =
  //     RefreshController(initialRefresh: false);

  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: getSize(50), left: getSize(20)),
            padding: EdgeInsets.only(bottom: getSize(10)),
            child: Text(
              "Notify",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    getSize(25),
                  ),
                  topRight: Radius.circular(
                    getSize(25),
                  ),
                ),
              ),
              child: GetBuilder<NotifyController>(
                init: controller,
                builder: (controller) {
                  return BaseList(
                    controller: controller.pagingController,
                    pagedListView: PagedListView(
                      padding: EdgeInsets.all(getSize(30)),
                      pagingController: controller.pagingController,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, item, index) {
                          return getItem(item, context);
                        },
                        firstPageErrorIndicatorBuilder: (_) =>
                            FirstPageErrorIndicator(
                          onTryAgain: () =>
                              controller.pagingController.refresh(),
                        ),
                        newPageErrorIndicatorBuilder: (_) =>
                            NewPageErrorIndicator(
                          onTryAgain: () => controller.pagingController
                              .retryLastFailedRequest(),
                        ),
                        firstPageProgressIndicatorBuilder: (_) =>
                            FirstPageProgressIndicator(),
                        newPageProgressIndicatorBuilder: (_) =>
                            NewPageProgressIndicator(),
                        noItemsFoundIndicatorBuilder: (_) =>
                            NoItemsFoundIndicator(),
                        noMoreItemsIndicatorBuilder: (_) =>
                            NoMoreItemsIndicator(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  getItem(NewApi model, context) {
    return Container(
      padding: EdgeInsets.only(bottom: getSize(20)),
      margin: EdgeInsets.only(top: getSize(10)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).shadowColor),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: getSize(80),
            width: getSize(120),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(15)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getSize(15)),
              child: Image.asset(
                logo,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: getSize(8),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: getSize(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: getSize(10),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: getSize(18),
                        color: ColorConstants.greyText,
                      ),
                      Expanded(
                        child: Text(
                          "301 Dorthy Walks,Chicago,Us.",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getSize(10),
                  ),
                  Row(
                    children: [
                      Text(
                        "4.5",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      RatingBar.builder(
                        itemSize: getSize(16),
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 1,
                        itemPadding: EdgeInsets.symmetric(
                          horizontal: getSize(4),
                        ),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: ColorConstants.primaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        "7.5 km",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
