import 'package:get_storage/get_storage.dart';

import '../../data/model/user_model.dart';
import 'math_utils.dart';

class PrefUtils {
  static PrefUtils _shared;

  PrefUtils._();

  static PrefUtils get getInstance => _shared = _shared ?? PrefUtils._();

  final _box = GetStorage();

  String get userData => "userData";

  void writeUserData(String key, dynamic value) {
    _box.write(userData, value);
  }

  readUserData(String key) {
    dynamic jsonData = _box.read(key);
    return !isNullEmptyOrFalse(jsonData) ? UserModel.fromJson(jsonData) : null;
  }
}
