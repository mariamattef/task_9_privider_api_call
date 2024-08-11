import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/home_page.dart';
import 'package:untitled/provider/comments_provider.dart';
import 'package:untitled/provider/posts_provider.dart';
import 'package:untitled/services/get_comments.sevices.dart';
import 'package:untitled/services/get_posts.services.dart';

void main() {
  runApp(const UseProvidor());
}

// This widget is the root of your application.
@override
class UseProvidor extends StatelessWidget {
  const UseProvidor({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              PostsProvider(allPostsService: AllPostsService()),
        ),
        ChangeNotifierProvider(
          create: (context) => CommentProvider(
            allCommentsService: AllCommentsService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Provider Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme:
              const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
        ),
        home: const HomePage(),
      ),
    );
  }
}
