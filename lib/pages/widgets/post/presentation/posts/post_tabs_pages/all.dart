import 'dart:async';

import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/APIServices/stereo_api_service.dart';
import 'package:_2geda/data/movie_data.dart';
import 'package:_2geda/models/audio_model.dart';

import 'package:_2geda/pages/widgets/businessDir/business_list.dart';
import 'package:_2geda/pages/widgets/movie/movie_caurosel.dart';
import 'package:_2geda/pages/widgets/people/user_list.dart';
import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:_2geda/pages/widgets/post/data/store_posts.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/enums.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/post_comp.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/post_feeds_dtails.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:_2geda/pages/widgets/post/presentation/state/posts_loading_state.dart';
import 'package:_2geda/pages/widgets/post/service/fetch_posts.dart';
import 'package:_2geda/pages/widgets/product/product_widget.dart';
import 'package:_2geda/pages/widgets/stereo/stereo-widget.dart';
import 'package:_2geda/pages/widgets/ticket/presentation/comps/ticket_list.dart';

import 'package:_2geda/pages/widgets/video/video_widget.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllTabContent extends StatefulWidget {
  final int currentIndex;

  const AllTabContent({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<AllTabContent> createState() => _AllTabContentState();
}

class _AllTabContentState extends State<AllTabContent> {
  final PostService postService = PostService();
  final StereoApiService stereoApiService = StereoApiService();
  List<AudioModel> audioList = [];
  final ScrollController _scrollController = ScrollController();
  List<Post> dataList = [];
  final List<SectionType> sectionTypes = [
    SectionType.video,
    SectionType.audio,
    SectionType.image,
    SectionType.ticket,
    SectionType.product,
    SectionType.business,
    SectionType.user,
    SectionType.cards
  ];
  late StreamSubscription internetSubscription;
  bool isInternetAvailableProv = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      bool isInternetOn = status == InternetConnectionStatus.connected;
      setState(() {
        isInternetAvailableProv = isInternetOn;
      });
    });
  }

  fetchStoredPost() async {
    List<Post> oldPost = await LocalStor.getFeeds();
    setState(() {
      dataList = oldPost;
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      edgeOffset: 5.0,
      onRefresh: () {
        return fetchHomePGPosts();
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            isInternetAvailableProv
                ? FutureBuilder<List<Post>>(
                    future: fetchHomePGPosts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 15),
                          child: RecentActivityLoadingState(
                            itemCount: 3,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length * 2 +
                              sectionTypes.length * 2,
                          itemBuilder: (context, index) {
                            if (index % 2 == 0 &&
                                index ~/ 2 < snapshot.data!.length) {
                              final data = snapshot.data![index ~/ 2];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => PostFeedDetails(
                                            hashtags: data.hashtags,
                                            noOfLikes: data.likes.toString(),
                                            // country: data.user!.address!.currentCity,
                                            content: data.content,
                                            username: data.user!.username,
                                            imgUrl: data.media,
                                            postID: data.id,
                                            timePosted: data.timeSince,
                                            commentText: data.commentText,
                                            eachMedia: data.eachMedia)),
                                  );
                                },
                                child: PostComponent(
                                  commentText: data.commentText,
                                  hashtags: data.hashtags,
                                  postID: data.id!,
                                  name: data.user!.username ?? '',
                                  content: data.content,
                                  timePosted: data.timeSince,
                                  noOfLikes: data.likes,
                                  eachMedia: data.eachMedia,
                                  // location: data.user!.address!.currentCity ?? '',
                                  // locationCountry: data.user!.address!.country ?? '',
                                ),
                              );
                            } else {
                              // Sections
                              int sectionIndex =
                                  (index ~/ 2) % sectionTypes.length;
                              SectionType sectionType = sectionTypes[
                                  sectionIndex % sectionTypes.length];
                              return _buildSectionWidget(sectionType);
                            }
                          },
                        );
                      }
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: dataList.length * 2 + sectionTypes.length * 2,
                    itemBuilder: (context, index) {
                      if (index % 2 == 0 && index ~/ 2 < dataList.length) {
                        final data = dataList[index ~/ 2];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => PostFeedDetails(
                                      hashtags: data.hashtags,
                                      noOfLikes: data.likes.toString(),
                                      // country: data.user!.address!.currentCity,
                                      content: data.content,
                                      username: data.user!.username,
                                      imgUrl: data.media,
                                      postID: data.id,
                                      timePosted: data.timeSince,
                                      commentText: data.commentText,
                                      eachMedia: data.eachMedia)),
                            );
                          },
                          child: PostComponent(
                            commentText: data.commentText,
                            hashtags: data.hashtags,
                            postID: data.id!,
                            name: data.user!.username ?? '',
                            content: data.content,
                            timePosted: data.timeSince,
                            noOfLikes: data.likes,
                            eachMedia: data.eachMedia,
                            // location: data.user!.address!.currentCity ?? '',
                            // locationCountry: data.user!.address!.country ?? '',
                          ),
                        );
                      } else {
                        // Sections
                        int sectionIndex = (index ~/ 2) % sectionTypes.length;
                        SectionType sectionType =
                            sectionTypes[sectionIndex % sectionTypes.length];
                        return _buildSectionWidget(sectionType);
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionWidget(SectionType sectionType) {
    switch (sectionType) {
      case SectionType.audio:
        return AudioListWidget(audioList: audioList);
      case SectionType.ticket:
        return TicketListWidget(
          events: const [],
        );
      case SectionType.business:
        return const BusinessListWidget();
      case SectionType.cards:
        return StackedCardCarousel(movies: movies);
      case SectionType.user:
        return const UserListWidget();
      case SectionType.product:
        return const ProductListWidget();

      default:
        return const VideoListWidget();
    }
  }
}
