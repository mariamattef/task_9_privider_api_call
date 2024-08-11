import 'package:flutter/material.dart';
import 'package:untitled/models/comments_model.dart';
import 'package:untitled/models/post_model.dart';
import 'package:untitled/provider/posts_provider.dart';
import 'package:untitled/services/get_comments.sevices.dart';

class CommentProvider extends ChangeNotifier {
  String errorMassege = '';
  bool isLoading = true;

  List<CommentsModel>? comments;
  List<PostModel>? posts;
  final AllCommentsService _allCommentsService;

  CommentProvider({required AllCommentsService allCommentsService})
      : _allCommentsService = allCommentsService;

  getcomments() async {
    _allCommentsService
        .getAllComments(id: posts ?? [].map((post) => post.id))
        .then((value) {
      comments = value;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      errorMassege = error.toString();
      isLoading = false;
      notifyListeners();
    });
  }
}
