import 'package:flutter/material.dart';
import 'package:untitled/models/post_model.dart';
import 'package:untitled/services/get_posts.services.dart';

class PostsProvider extends ChangeNotifier {
  String errorMassege = '';
  bool isLoading = true;
  List<PostModel> posts = [];
  final AllPostsService _allPostsService;

  PostsProvider({required AllPostsService allPostsService})
      : _allPostsService = allPostsService;

  getposts() async {
    await _allPostsService.getAllPosts().then((value) {
      posts = value;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      errorMassege = error.toString();
      isLoading = false;
      notifyListeners();
    });
  }
}
