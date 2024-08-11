import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/comments_model.dart';
import 'package:untitled/provider/comments_provider.dart';

class DetailsPostPage extends StatefulWidget {
  final int id;
  const DetailsPostPage({super.key, required this.id});

  @override
  State<DetailsPostPage> createState() => _DetailsPostPageState();
}

class _DetailsPostPageState extends State<DetailsPostPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommentProvider>(context);
    provider.getcomments();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details Post',
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.blue,
      ),
      body: provider.isLoading
          ? getLoadingUi()
          : provider.errorMassege.isNotEmpty
              ? getErrorUi(provider.errorMassege)
              : ListView.builder(
                  itemCount: provider.comments!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(provider.comments![index].email.toString()),
                    );
                  },
                ),

      // getPodyUi(provider.comments ?? [])),
    ));
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
                Provider.of<CommentProvider>(context, listen: false);
              },
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }

  getPodyUi(List<CommentsModel> comments) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return ListTile(
          title: Text(comment.name.toString()),
          subtitle: Text(comment.email.toString()),
          // trailing: Text(widget.id.toString()),
        );
      },
    );
  }
}
