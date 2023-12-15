import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:_2geda/pages/widgets/post/presentation/posts/post_container.dart';
import 'package:flutter/material.dart';

class SavedPosts extends StatefulWidget {
  const SavedPosts({super.key});

  @override
  _SavedPostsState createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> {
  final PostService postService =
      PostService(); // Create an instance of PostService
  final TokenManager tokenManager = TokenManager();
  String? authToken;
  late List<Post> savedPosts;

  @override
  void initState() {
    super.initState();
    _loadAuthToken();
    // Fetch saved posts from API during widget initialization
  }

  _loadAuthToken() async {
    authToken = await tokenManager.getToken();
    print('Auth Token: $authToken');
    print('Token $authToken');

    fetchSavedPosts();
  }

  Future<void> fetchSavedPosts() async {
    // Replace this with your actual API call
    savedPosts = await postService.fetchSavedPosts(authToken!);

    // Update the widget state to trigger a rebuild
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Saved Posts',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children:
              savedPosts.map((post) => PostContainer(post: post)).toList(),
        ),
      ),
    );
  }
}
