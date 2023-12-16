import 'dart:math';

import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/APIServices/stereo_api_service.dart';
import 'package:_2geda/data/movie_data.dart';
import 'package:_2geda/models/audio_model.dart';

import 'package:_2geda/pages/widgets/businessDir/business_list.dart';
import 'package:_2geda/pages/widgets/movie/movie_caurosel.dart';
import 'package:_2geda/pages/widgets/people/user_list.dart';
import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/enums.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/post_comp.dart';

import 'package:_2geda/pages/widgets/post/presentation/state/posts_loading_state.dart';
import 'package:_2geda/pages/widgets/post/service/fetch_posts.dart';
import 'package:_2geda/pages/widgets/product/product_widget.dart';
import 'package:_2geda/pages/widgets/stereo/stereo-widget.dart';
import 'package:_2geda/pages/widgets/ticket/ticket_list.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: RecentActivityLoadingState(
                  itemCount: 2,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length * 2 + sectionTypes.length * 2,
                itemBuilder: (context, index) {
                  if (index % 2 == 0 && index ~/ 2 < snapshot.data!.length) {
                    final data = snapshot.data![index ~/ 2];
                    return Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            print(data.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: PostComponent(
                              postID: data.id!,
                              name: data.user!.username,
                              content: data.content,
                              timePosted: data.timeSince,
                              location: data.user!.email,
                              noOfLikes: data.likes.toString(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  } else {
                    // Sections
                    int sectionIndex = (index ~/ 2) % sectionTypes.length;
                    SectionType sectionType =
                        sectionTypes[sectionIndex % sectionTypes.length];
                    return _buildSectionWidget(sectionType);
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildSectionWidget(SectionType sectionType) {
    switch (sectionType) {
      case SectionType.audio:
        return AudioListWidget(audioList: audioList);
      case SectionType.ticket:
        return const TicketListWidget();
      case SectionType.business:
        return const BusinessListWidget();
      case SectionType.cards:
        return StackedCardCarousel(movies: movies);
      case SectionType.user:
        return const UserListWidget();
      case SectionType.product:
        return const ProductListWidget();

      default:
        return const SizedBox();
    }
  }
}
