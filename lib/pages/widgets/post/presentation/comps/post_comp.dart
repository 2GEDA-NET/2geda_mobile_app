import 'package:_2geda/pages/widgets/post/data/reaction_model.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/enums.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/image_detail_page.dart';
import 'package:_2geda/pages/widgets/post/presentation/comps/post_feeds_dtails.dart';
import 'package:_2geda/pages/widgets/post/service/post_reaction.dart';
import 'package:_2geda/utils/constant/app_color.dart';
import 'package:_2geda/utils/user_prefrences/user_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../data/post_model.dart';
import '../../service/fetch_comments_byid.dart';

class PostComponent extends StatefulWidget {
  String? imageUrl;
  String? name;
  String? locationCountry;
  String? location;
  String? timePosted;
  String? content;
  String? likes;
  String? noOfLikes;
  List<EachMedia> eachMedia;
  List<Hashtag> hashtags;
  List<CommentText> commentText;
  String? username;
  int postID;
  PostComponent(
      {super.key,
      required this.hashtags,
      required this.commentText,
      this.imageUrl,
      this.username,
      this.name,
      this.location,
      this.timePosted,
      this.likes,
      this.noOfLikes,
      required this.postID,
      required this.eachMedia,
      this.content});

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  bool reactionView = false;
  ReactionType reactionType = ReactionType.none;
  bool isReacted = false;
  PostReactionServiceNotifier postReactionServiceNotifier =
      PostReactionServiceNotifier();
  late String getStoredReaction;

  @override
  void initState() {
    super.initState();
    getStoredReactionFnc();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostFeedDetails(
                  commentText: widget.commentText,
                  timePosted: widget.timePosted,
                  imgUrl: widget.imageUrl,
                  country: widget.locationCountry,
                  postID: widget.postID.toString(),
                  eachMedia: widget.eachMedia,
                  content: widget.content,
                  hashtags: widget.hashtags,
                  username: widget.name,
                ),
              ),
            );
            print(widget.postID);
          },
          child: Card(
            color: kwhite,
            surfaceTintColor: kwhite,
            elevation: 1,
            shape: const RoundedRectangleBorder(
                side: BorderSide.none, borderRadius: BorderRadius.zero),
            // color: kwhite,
            // width: MediaQuery.sizeOf(context).width,
            // height: widget.eachMedia.isEmpty || widget.eachMedia.length == 2
            //     ? 250
            //     : 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(100),
                          shape: BoxShape.rectangle,
                          color: Colors.grey[300]!,
                        ),
                      ),
                      // Container(
                      //     alignment: Alignment.topLeft,
                      //     child: CachedNetworkImage(
                      //       imageUrl: imageUrl ?? '',
                      //       height: 42,
                      //       width: 42,
                      //     )),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              widget.name ?? '',
                              style: const TextStyle(
                                color: Color(0xFF4E0CA2),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                              child: Text(
                            '',
                            style: TextStyle(
                              color:
                                  Colors.black.withOpacity(0.4000000059604645),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        widget.timePosted ?? '',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Text(
                        widget.content ?? '',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.699999988079071),
                          fontSize: 13,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                          height: 0.11,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      widget.eachMedia.isEmpty
                          ? const SizedBox()
                          : Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 123,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      widget.eachMedia.length == 1 ? 1 : 2,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                  childAspectRatio: 3.0,
                                ),
                                itemCount: widget.eachMedia.length < 4
                                    ? widget.eachMedia.length
                                    : widget.eachMedia.take(4).length,
                                itemBuilder: (context, index) {
                                  // print(widget.eachMedia[index].media!);
                                  int mediaLen = widget.eachMedia.length - 4;
                                  if (index == 3) {
                                    return mediaLen < 1
                                        ? const SizedBox()
                                        : Positioned.fill(
                                            child: Text('+ $mediaLen'),
                                          );
                                  }

                                  return Stack(
                                    children: [
                                      SizedBox(
                                          child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      ImageDetailPage(
                                                          eachMedia: widget
                                                              .eachMedia)));
                                        },
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                widget.eachMedia[index].media!),
                                      )),
                                    ],
                                  );
                                },
                              ),
                            ),
                      if (reactionView)
                        Positioned(
                          bottom: -10,
                          child: Container(
                            padding: const EdgeInsets.all(10),
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
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
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
                                                      postId: widget.postID,
                                                      reactionType:
                                                          reactionType.name);
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
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/emoji _crying face_.svg'),
                      SvgPicture.asset('assets/emoji _hugging face_.svg'),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Ademola Kola and 3.2k others',
                        style: TextStyle(
                          color: Color(0xFF403F3F),
                          fontSize: 10,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
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
                                      postId: widget.postID,
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
                      SvgPicture.asset('assets/ChatCentered.svg'),
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
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
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
