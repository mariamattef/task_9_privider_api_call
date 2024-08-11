import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/models/comments_model.dart';

class AllCommentsService {
  Future<List<CommentsModel>> getAllComments({required id}) async {
    http.Response response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$id/comments'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<CommentsModel> commentstList = [];
      for (var i = 0; i < data.length; i++) {
        commentstList.add(CommentsModel.fromJson(data[i]));
      }
      return commentstList;
    } else {
      throw Exception(
          'Thre is an error in status code : ${response.statusCode}');
    }
  }
}
