import 'package:_2geda/pages/connect/data/story_model.dart';
import 'package:_2geda/pages/connect/presentation/widgets/comps/bars.dart';
import 'package:_2geda/pages/connect/services/getconnect_srv.dart';
import 'package:_2geda/utils/constant/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

final GetConnectNotifier cnnctProvider = GetConnectNotifier();

class StatusScreen extends StatefulWidget {
  final List<Story>? stories;
  const StatusScreen({super.key, this.stories});

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  PageController? _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    cnnctProvider.fetchData();
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);

    final Story firstStory = widget.stories!.first;
    _loadStory(story: firstStory, animateToPage: false);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();

        // _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.stories!.length) {
            _currentIndex += 1;
            _loadStory(story: widget.stories![_currentIndex]);
          } else {}
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDetails) {
        double tapPosition = TapDetails.globalPosition.dx;

        double screenWidth = MediaQuery.of(context).size.width;

        double threshold = screenWidth / 2;

        if (tapPosition > threshold) {
          // Right side tap
          _updateStatus(forward: true);
        } else {
          // Left side tap
          _updateStatus(forward: false);
        }
      },
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: cnnctProvider,
            builder: (context, dataState, child) {
              if (dataState.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataState.error != null) {
                return Center(
                  child: Text('Error: ${dataState.error.toString()}'),
                );
              } else if (dataState.data != null) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Media Content (Image or Video)
                    // for (var i in stories)
                    SizedBox(
                      // Example background color for media content
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cnnctProvider.value.data![0].media.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 630,
                            decoration: const BoxDecoration(
                                color: kPrimary2,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: CachedNetworkImage(
                              imageUrl: cnnctProvider
                                  .value.data![0].media[0].profileImage,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.error),
                                  Text(error.toString())
                                ],
                              ),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                    // Percent Indicators
                    Positioned(
                      top: 25.0,
                      left: 10.0,
                      right: 10.0,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: cnnctProvider.value.data![0].media
                                .asMap()
                                .map((i, e) {
                                  return MapEntry(
                                    i,
                                    AnimatedBar(
                                      animController: _animationController,
                                      position: i,
                                      currentIndex: _currentIndex,
                                    ),
                                  );
                                })
                                .values
                                .toList(),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 1.5,
                              vertical: 10.0,
                            ),
                            // child: UserInfo(user: story.imageName),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 35.0,
                        right: 24.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: kblckBtn,
                          ),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 16,
                          ),
                        )),
                    Positioned(
                        bottom: 78,
                        right: 19,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                          ),
                          width: 57,
                          height: 50,
                          padding: const EdgeInsets.symmetric(),
                          decoration: ShapeDecoration(
                            color:
                                Colors.white.withOpacity(0.20000000298023224),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 30,
                                  height: 30,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: const Icon(
                                    Icons.image_outlined,
                                    color: kblckBtn,
                                  )),
                              const SizedBox(width: 5),
                              // for (var i in stories)
                              Text(
                                cnnctProvider.value.data![0].media.length
                                    .toString(),
                                style: const TextStyle(
                                  color: Color(0xFF151313),
                                  fontSize: 16,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        bottom: 67,
                        left: 24.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Image.network(
                                cnnctProvider
                                    .value.data!.first.media.first.profileImage,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Mercy Aik',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '@${cnnctProvider.value.data![0].username}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Abeokuta, 56km from you',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              child: Text(
                                'No bio yet.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0.09,
                                ),
                              ),
                            )
                          ],
                        ))
                    // Text Overlay
                    ,
                    Positioned(
                      bottom: -20,
                      left: 20,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 143,
                            height: 51,
                            decoration: ShapeDecoration(
                              color: kPrimary1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Chat',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          Container(
                            width: 143,
                            height: 51,
                            decoration: ShapeDecoration(
                              color: kPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Stick',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Filling Animation
                  ],
                );
              }
              return const Center(
                child: Text('No connects available'),
              );
            }),
      ),
    );
  }

  void _loadStory({required Story story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    switch (story.media) {
      case MediaType.image:
        _animationController.duration = story.duration;
        _animationController.forward();

      case null:
        break;
      case MediaType.video:
        // TODO: Handle this case.
        break;
    }
  }

  void _updateStatus({required bool forward}) {
    setState(() {
      if (forward) {
        if (_currentIndex < widget.stories!.length) {
          _currentIndex++;
        } else {
          // Stop at the last item
          // You can add logic to restart from the beginning if needed
        }
      } else {
        if (_currentIndex > 0) {
          _currentIndex--;
        } else {
          // Optional: Wrap around to the last item
          // _currentIndex = 4;
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
