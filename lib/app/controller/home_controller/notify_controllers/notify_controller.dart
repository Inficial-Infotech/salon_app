import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:salon_app/app/data/model/new_api.dart';
import 'package:salon_app/app/data/model/posts_model.dart';

import '../../../data/dioClient/NetworkClient.dart';
import '../../../data/dioClient/myApiClient.dart';
import '../../../ui/constants/ApiConstants.dart';

class NotifyController extends GetxController {
  List<PostsModel> postsList = [];
  final pagingController = PagingController(
    // 2
    firstPageKey: 15,
  );

  //Total page loaded at time....
  static const _pageSize = 5;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      // callApi(pageKey: 1);
      networkClientCallApi(pageKey: pageKey);
    });

    super.onInit();
  }

  ///api call using myapiclient.dart and api_request.dart
  // callApi({callback, int pageKey = 1}) {
  //   MyApiClient().getPostsList(
  //     onSuccess: (posts) {
  //       print("==============");
  //       // postsList.clear();
  //       postsList.addAll(posts);

  //       //For BaseList do it in all
  //       final isLastPage = postsList.length < _pageSize;
  //       if (isLastPage) {
  //         pagingController.appendLastPage(postsList);
  //       } else {
  //         final nextPageKey = pageKey + postsList.length;
  //         pagingController.appendPage(postsList, nextPageKey);
  //       }
  //       // callback();
  //       update();
  //     },
  //     onError: (error) {
  //       print(error);
  //       pagingController.error = error;
  //       update();
  //       print("Error");
  //     },
  //   );
  // }

  ///api call using netwrokclient.dart
  networkClientCallApi({int pageKey}) {
    // NetworkClient.getInstance.callApi(
    //     context, baseURL, "web/v1/diamond/reportno/paginate", MethodType.Post,
    //     headers: NetworkClient.getInstance.getAuthHeaders(),
    //     params: req, successCallback: (response, message) {
    //   arrList = [];
    //   if (response is List<dynamic>) {
    //     for (var item in response) {
    //       arrList.add(item);
    //     }
    //   }
    //   setState(() {});
    // }, failureCallback: (status, message) {
    //   print(message);
    // });

    Map<String, dynamic> req = {};
    NetworkClient.getInstance.callApi(
        ApiConstants.baseUrl, "page=0&size=$pageKey", MethodType.Get,
        params: req, successCallback: (response, message) {
      List<NewApi> postsList = [];
      if (response is List<dynamic>) {
        for (var item in response) {
          postsList.add(NewApi.fromJson(item));
        }
        //For BaseList do it in all
        final isLastPage = postsList.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(postsList);
        } else {
          final nextPageKey = pageKey + 15;
          pagingController.appendPage(postsList, nextPageKey);
        }
        // callback();
        update();
      }
    }, failureCallback: (status, message) {
      print("+++++++++++++++++++$message");
    });
  }
}
