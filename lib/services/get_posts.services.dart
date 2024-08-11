import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/models/post_model.dart';

class AllPostsService {
  Future<List<PostModel>> getAllPosts() async {
    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<PostModel> postList = [];
      for (var i = 0; i < data.length; i++) {
        postList.add(PostModel.fromJson(data[i]));
      }
      return postList;
    } else {
      throw Exception(
          'Thre is an error in status code : ${response.statusCode}');
    }
  }
}
