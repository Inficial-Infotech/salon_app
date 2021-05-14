import 'package:salon_app/app/data/dioClient/api_request.dart';
import 'package:salon_app/app/data/model/posts_model.dart';
import 'package:salon_app/app/ui/constants/ApiConstants.dart';

const baseUrl = 'https://jsonplaceholder.typicode.com/posts/';

class MyApiClient {
  void getPostsList({
    int pagination = 50,
    Function() beforeSend,
    Function(List<PostsModel> posts) onSuccess,
    Function(dynamic error) onError,
  }) {
    ApiRequest(
      url: '${ApiConstants.baseURL + pagination.toString()}',
    ).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        onSuccess((data as List)
            .map((postJson) => PostsModel.fromJson(postJson))
            .toList());
      },
      onError: (error) {
        if (onError != null) {
          onError(error);
        }
      },
    );
  }

// getAll() async {
//   try {
//     var response = await httpClient.get(baseUrl);
//     if(response.statusCode == 200){
//       Iterable jsonResponse = json.decode(response.body);
//         List<MyModel> listMyModel = jsonResponse.map((model) => MyModel.fromJson(model)).toList();
//       return listMyModel;
//     }else print ('erro');
//   } catch(_){ }
// }

// getId(id) async {
//   try {
//       var response = await httpClient.get('baseUrlid');
//     if(response.statusCode == 200){
//       //Map<String, dynamic> jsonResponse = json.decode(response.body);
//     }else print ('erro -get');
//   } catch(_){ }
// }

}
