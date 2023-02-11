import 'dart:convert';
import 'package:http/http.dart';
import 'package:random_userdata/user_data.dart';
import 'package:random_userdata/apiUtil.dart';

class HttpService {
  Future<List<Result>> getData() async {
    Response response = await get(Uri.parse(ApiString.URL));
    print(response.statusCode);
    if (response.statusCode == 200) {
      User userData = User.fromJson(json.decode(response.body));
      List<Result> resultList = [];
      resultList.addAll(userData.results!);
      print('List:: ${resultList}');
      return resultList;
    } else {
      print("error");
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<Result>> getMultipleData() async {
    Response response = await get(Uri.parse(ApiString.URL+ApiString.user));
    print(response.statusCode);
    if (response.statusCode == 200) {
      User userData = User.fromJson(json.decode(response.body));
      List<Result> resultList = [];
      resultList.addAll(userData.results!);
      print('List:: ${resultList}');
      return resultList;
    } else {
      print("error");
      throw "Unable to retrieve posts.";
    }
  }
}