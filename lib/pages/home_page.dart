import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/post_model.dart';
import 'package:untitled/pages/details_post_page.dart';
import 'package:untitled/provider/posts_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<PostsProvider>(context, listen: false);
    provider.getposts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostsProvider>(
      context,
    );
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              'Provider Api Call',
              style: TextStyle(fontSize: 25),
            ),
          ),
          body: provider.isLoading
              ? getLoadingUi()
              : provider.errorMassege.isNotEmpty
                  ? getErrorUi(provider.errorMassege)
                  : getPodyUi(provider.posts)),
    );
  }

  Widget getLoadingUi() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitPulsingGrid(
            color: Colors.blue,
            size: 80.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Loading...',
            style: TextStyle(
              fontSize: 22,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget getErrorUi(String errorMassege) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'An error occurred: $errorMassege',
              style: const TextStyle(color: Colors.red, fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<PostsProvider>(context, listen: false);
              },
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPodyUi(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          child: ListTile(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPostPage(
                        id: post.id ?? 0,
                      )));
            },
            title: Text(
              posts[index].title.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(post.body.toString()),
          ),
        );
      },
    );
  }
}
