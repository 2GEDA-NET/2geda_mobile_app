import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/pages/authentication/token_manager.dart';
import 'package:_2geda/pages/widgets/post/data/post_model.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/comment_fab.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/enums.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/post_feeds_headr.dart';
import 'package:_2geda/pages/widgets/post/service/post_reaction.dart';
import 'package:_2geda/utils/constant/app_color.dart';
import 'package:_2geda/utils/user_prefrences/user_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/reaction_model.dart';
import '../posts/comment/post_comment.dart';

class PostFeedDetails extends StatefulWidget {
  String? imgUrl;
  String? country;
  String? timePosted;
  int? postID;
  String? content;
  String? username;
  List<Hashtag>? hashtags;
  List<EachMedia> eachMedia;
  List<CommentText> commentText;
  String? noOfLikes;
  PostFeedDetails(
      {super.key,
      this.country,
      required this.commentText,
      this.noOfLikes,
      this.username,
      this.imgUrl,
      this.timePosted,
      this.content,
      required this.eachMedia,
      this.hashtags,
      this.postID});

  @override
  State<PostFeedDetails> createState() => _PostFeedDetailsState();
}

class _PostFeedDetailsState extends State<PostFeedDetails> {
  bool reactionView = false;
  ReactionType reactionType = ReactionType.none;
  bool isReacted = false;
  PostReactionServiceNotifier postReactionServiceNotifier =
      PostReactionServiceNotifier();
  late String getStoredReaction;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    getStoredReactionFnc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          toolbarHeight: 80,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff8e3bce), Color(0xff5816a2)],
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: const Text(
            'Feeds',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 80,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff8e3bce), Color(0xff5816a2)],
                  ),
                ),
                child: PostFeedDetailsHeader(
                  username: widget.username ?? '',
                  imgUrl: widget.imgUrl ?? '',
                  timePosted: widget.timePosted ?? '',
                  country: widget.country ?? '',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Text(widget.content ?? ''),
              ),
              const SizedBox(
                height: 5,
              ),
              widget.hashtags!.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 0),
                      child: Text(
                        widget.hashtags!
                            .map((hashtag) => hashtag.hashTags)
                            .join(', '),
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
              const SizedBox(
                height: 24,
              ),
              widget.eachMedia.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.eachMedia.length,
                              itemBuilder: (_, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.eachMedia[i].media ?? '',
                                    height:
                                        MediaQuery.of(context).size.width * 0.5,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }),
                          if (reactionView)
                            Positioned(
                              bottom: -10,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                width: 226,
                                height: 46.38,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: kPrimary2),
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: rs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    reactionType =
                                                        rs[index].reactionType;
                                                    reactionView = false;
                                                  });
                                                  await postReactionServiceNotifier
                                                      .postReactionService(
                                                          postId:
                                                              widget.postID!,
                                                          reactionType:
                                                              reactionType
                                                                  .name);
                                                  ////////
                                                  print(reactionType.name);
                                                },
                                                child: SvgPicture.asset(
                                                    rs[index].svg)),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 24,
              ),
              ///// Reactio nseg
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (reactionView) {
                          setState(() {
                            reactionView = false;
                          });
                        } else {
                          if (reactionType == ReactionType.none) {
                            reactionType = ReactionType.like;

                            ////////
                            await postReactionServiceNotifier
                                .postReactionService(
                                    postId: widget.postID!,
                                    reactionType: 'like');
                          } else {
                            reactionType = ReactionType.none;
                          }
                        }
                        setState(() {});
                      },
                      onLongPress: () {
                        setState(() {
                          reactionView = true;
                        });
                      },
                      child: getStoredReaction == ''
                          ? getReaction(reactionType)
                          : getStoredReactionFnc(),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.noOfLikes ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                        child: SvgPicture.asset('assets/ChatCentered.svg')),
                    const Text(
                      '3.2K',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset('assets/ShareNetwork.svg'),
                    const Text(
                      '3.2K',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),

              CommentSection(
                commentText: widget.commentText,
              ),
            ],
          ),
        ),
        floatingActionButton: CommentFABs(
          postID: widget.postID,
        ));
  }

  SvgPicture getStoredReactionFnc() {
    String? storedReaction =
        UserPreference.getReactionType(widget.postID.toString()) ?? '';
    setState(() {
      getStoredReaction = storedReaction;
    });

    switch (storedReaction) {
      case 'like':
        return SvgPicture.asset(
          'assets/liked.svg',
          width: 25,
        );
      case 'angry':
        return SvgPicture.asset(
          'assets/emoji _pouting face_.svg',
        );
      case 'dislike':
        return SvgPicture.asset(
          'assets/ulik.svg',
        );
      case 'hug':
        return SvgPicture.asset(
          'assets/emoji _hugging face_.svg',
        );
      case 'laugh':
        return SvgPicture.asset(
          'assets/emoji _face with tears of joy_ (1).svg',
        );
      case 'tears':
        return SvgPicture.asset(
          'assets/emoji _crying face_.svg',
        );
      case 'wow':
        return SvgPicture.asset(
          'assets/emoji _hushed face_.svg',
        );

      default:
        return SvgPicture.asset('assets/liked.svg');
    }
  }

  SvgPicture getReaction(ReactionType r) {
    // print(r.name);
    switch (r) {
      case ReactionType.like:
        return SvgPicture.asset(
          'assets/liked.svg',
          width: 25,
        );
      case ReactionType.angry:
        return SvgPicture.asset(
          'assets/emoji _pouting face_.svg',
        );
      case ReactionType.dislike:
        return SvgPicture.asset(
          'assets/ulik.svg',
        );
      case ReactionType.hug:
        return SvgPicture.asset(
          'assets/emoji _hugging face_.svg',
        );
      case ReactionType.laugh:
        return SvgPicture.asset(
          'assets/emoji _face with tears of joy_ (1).svg',
        );
      case ReactionType.tears:
        return SvgPicture.asset(
          'assets/emoji _crying face_.svg',
        );
      case ReactionType.wow:
        return SvgPicture.asset(
          'assets/emoji _hushed face_.svg',
        );

      default:
        return SvgPicture.asset('assets/like.svg');
    }
  }
}
