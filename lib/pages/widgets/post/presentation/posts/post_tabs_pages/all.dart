import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/APIServices/stereo_api_service.dart';
import 'package:_2geda/data/movie_data.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/businessDir/business_list.dart';
import 'package:_2geda/pages/widgets/movie/movie_caurosel.dart';
import 'package:_2geda/pages/widgets/people/user_list.dart';
import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/post_comp.dart';
import 'package:_2geda/pages/widgets/post/presentation/posts/post_container.dart';
import 'package:_2geda/pages/widgets/post/presentation/state/posts_loading_state.dart';
import 'package:_2geda/pages/widgets/post/service/fetch_posts.dart';
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
  List<Post> posts = [];
  List<AudioModel> audioList = [];
  bool isDataLoaded = false; // Add a flag to track whether data is loaded
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder<List<Post>>(
          future: fetchHomePGPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: RecentActivityLoadingState(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              // Display the data in a ListView
              print(snapshot.data![0].content);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PostComponent(
                      name: data.user!.username,
                      content: data.content,
                      timePosted: data.timeSince,
                      location: data.user!.email,
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
