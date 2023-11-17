import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/APIServices/stereo_api_service.dart';
import 'package:_2geda/data/movie_data.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/businessDir/business_list.dart';
import 'package:_2geda/pages/widgets/movie/movie_caurosel.dart';
import 'package:_2geda/pages/widgets/people/user_list.dart';
import 'package:_2geda/pages/widgets/posts/post_container.dart';
import 'package:_2geda/pages/widgets/product/product_widget.dart';
import 'package:_2geda/pages/widgets/stereo/stereo-widget.dart';
import 'package:_2geda/pages/widgets/ticket/ticket_list.dart';
import 'package:_2geda/pages/widgets/video/video_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AllTabContent extends StatefulWidget {
  final int currentIndex; // Add this line

  const AllTabContent({
    Key? key,
    required this.currentIndex, // Add this parameter
  }) : super(key: key);

  @override
  State<AllTabContent> createState() => _AllTabContentState();
}

class _AllTabContentState extends State<AllTabContent> {
  final PostService postService = PostService();
  final StereoApiService stereoApiService = StereoApiService();
  final TokenManager tokenManager = TokenManager();
  String? authToken;
  List<Post> posts = [];
  List<AudioModel> audioList = []; // Declare audioList in the state class

  @override
  void initState() {
    super.initState();
    _loadAuthTokenAndFetchData();
  }

  // Future<void> _loadAuthTokenAndFetchPosts() async {
  //   authToken = await tokenManager.getToken();
  //   try {
  //     await fetchPosts(authToken);
  //   } catch (e) {
  //     // Handle error
  //     print('Error fetching posts: $e');
  //   }
  // }

  Future<void> _loadAuthTokenAndFetchData() async {
    authToken = await tokenManager.getToken();
    try {
      await fetchPosts(authToken);
      await fetchAudioListFromAI(authToken); // Fetch audio data directly
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchAudioListFromAI(String? authToken) async {
    try {
      List<AudioModel> fetchedAudioList =
          await stereoApiService.fetchQuickPickAudioList(authToken!);
      setState(() {
        audioList = fetchedAudioList;
      });
    } catch (e) {
      // Handle error
      print('Error fetching audio list: $e');
    }
  }

  Future<void> fetchPosts(String? authToken) async {
    try {
      List<Post> fetchedPosts = await postService.fetchPosts(authToken!);
      print('Response Body: $fetchedPosts');
      setState(() {
        posts = fetchedPosts;
      });
    } catch (e) {
      // Handle error
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...posts
            .take(1) // Display the first post
            .map((post) => PostContainer(post: post))
            .toList(),
        const SizedBox(height: 24), // Remove "const" here
        AudioListWidget(audioList: audioList),
        // SizedBox(height: 24), // Remove "const" here
        ...posts
            .skip(widget.currentIndex == 0
                ? 1
                : 4) // Skip the appropriate number of posts
            .take(1) // Take the next 3 posts
            .map((post) => PostContainer(post: post))
            .toList(),
        // TicketWidget(),
        const TicketListWidget(),
        // SizedBox(height: 24), // Remove "const" here
        ...posts
            .skip(widget.currentIndex == 0
                ? 1
                : 4) // Skip the appropriate number of posts
            .take(1) // Take the next 2 posts
            .map((post) => PostContainer(post: post))
            .toList(),

        VideoListWidget(),
        ...posts
            .skip(widget.currentIndex == 0
                ? 1
                : 2) // Skip the appropriate number of posts
            .take(1) // Take the next 2 posts
            .map((post) => PostContainer(post: post))
            .toList(),

        const ProductListWidget(),
        ...posts
            .skip(widget.currentIndex == 0 ? 1 : 2)
            .take(1)
            .map((post) => PostContainer(post: post))
            .toList(),
        Padding(
          padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width, // Set the desired width of the image
                height: 100, // Set the desired height of the image
                child: CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
                  fit: BoxFit.cover,
                ),
              ),
              const Icon(
                Icons.play_arrow,
                size: 48, // Set the desired size of the play icon
                color: Colors.white, // Set the desired color of the play icon
              ),
            ],
          ),
        ),

        ...posts
            .skip(widget.currentIndex == 0 ? 1 : 2)
            .take(1)
            .map((post) => PostContainer(post: post))
            .toList(),
        StackedCardCarousel(movies: movies),

        ...posts
            .skip(widget.currentIndex == 0 ? 1 : 2)
            .take(1)
            .map((post) => PostContainer(post: post))
            .toList(),

        const SizedBox(
          height: 20,
        ),

        const UserListWidget(),

        const SizedBox(
          height: 20,
        ),

        const BusinessListWidget(),

        const SizedBox(
          height: 20,
        ),

        ...posts.map((post) => PostContainer(post: post)).toList(),
        // Define the content specific to the "All" tab here
      ],
    );
  }
}
