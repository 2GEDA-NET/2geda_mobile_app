import 'package:_2geda/APIServices/event_api_service.dart';
import 'package:_2geda/APIServices/post_api_service.dart';
import 'package:_2geda/APIServices/stereo_api_service.dart';
import 'package:_2geda/data/movie_data.dart';
import 'package:_2geda/models/audio_model.dart';
import 'package:_2geda/models/post_model.dart';
import 'package:_2geda/models/ticket.dart';
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
  TicketApiService ticketApiService = TicketApiService();
  final StereoApiService stereoApiService = StereoApiService();
  final TokenManager tokenManager = TokenManager();
  String? authToken;
  late List<Event> events = []; // Initialize tickets as an empty list
  List<Post> posts = [];
  List<AudioModel> audioList = [];
  bool isDataLoaded = false; // Add a flag to track whether data is loaded
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadAuthTokenAndFetchData();
    _loadTickets();

    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadAuthTokenAndFetchData() async {
    try {
      authToken = await tokenManager.getToken();
      if (!isDataLoaded) {
        await fetchPosts(authToken!, 0); // Fetch the initial set of posts
        fetchAudioListFromAI(authToken!);
        if (mounted) {
          setState(() {
            isDataLoaded = true;
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _loadTickets() async {
    try {
      // Instantiate the TicketApiService

      // Fetch the auth token
      authToken = await tokenManager.getToken();

      // Fetch tickets from the API
      List<Event> fetchedTickets =
          await ticketApiService.getTickets(authToken!);

      // Update the state with the fetched tickets
      if (mounted) {
        setState(() {
          events = fetchedTickets.cast<Event>();
        });
      }
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Error loading tickets: $e');
    }
  }

  Future<void> fetchAudioListFromAI(String? authToken) async {
    try {
      // Check if cached audio data is available
      List<AudioModel> cachedAudioList = await getCachedAudioList();
      if (cachedAudioList.isNotEmpty) {
        setState(() {
          audioList = cachedAudioList;
        });
      } else {
        // Fetch new audio data from the network
        List<AudioModel> fetchedAudioList =
            await stereoApiService.fetchQuickPickAudioList(authToken!);
        setState(() {
          audioList = fetchedAudioList;
        });
        // Save fetched audio data to cache
        saveAudioListToCache(fetchedAudioList);
      }
    } catch (e) {
      // Handle error
      print('Error fetching audio list: $e');
      // You can show a snackbar or a user-friendly error message here
    }
  }

  Future<void> fetchPosts(String authToken, int page) async {
    try {
      List<Post> fetchedPosts =
          await postService.fetchPosts(authToken, page: page);
      setState(() {
        posts.addAll(fetchedPosts);
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list
      if (!isDataLoaded) {
        // Fetch more posts only if data is not already loaded
        fetchPosts(
            authToken!, posts.length ~/ 10); // Adjust the page size as needed
      }
    }
  }

// Assuming getCachedPosts returns List<Post> directly
  Future<List<Post>> getCachedPosts() async {
    // Implement logic to get cached posts data (e.g., using shared preferences)
    // Return an empty list if no cached data is found
    return [];
  }

// Assuming savePostsToCache handles asynchronous operations correctly
  Future<void> savePostsToCache(List<Post> posts) async {
    // Implement logic to save posts data to cache (e.g., using shared preferences)
  }

  // Add methods to get and save cached audio and posts data
  Future<List<AudioModel>> getCachedAudioList() async {
    // Implement logic to get cached audio data (e.g., using shared preferences)
    // Return an empty list if no cached data is found
    return [];
  }

  Future<void> saveAudioListToCache(List<AudioModel> audioList) async {
    // Implement logic to save audio data to cache (e.g., using shared preferences)
  }

  Future<void> _handleRefresh() async {
    await _loadAuthTokenAndFetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ...posts
                .take(1) // Display the first post
                .map((post) => PostContainer(post: post))
                .toList(),
            const SizedBox(height: 24), // Remove "const" here
            // Display the audio list
            AudioListWidget(audioList: audioList),
            ...posts
                .skip(widget.currentIndex == 0
                    ? 1
                    : 4) // Skip the appropriate number of posts
                .take(1) // Take the next 3 posts
                .map((post) => PostContainer(post: post))
                .toList(),
            // TicketWidget(),
             TicketListWidget(events: events,),
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
              padding:
                  const EdgeInsets.all(16.0), // Adjust the padding as needed
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
                    color:
                        Colors.white, // Set the desired color of the play icon
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

            // ...posts.map((post) => PostContainer(post: post)).toList(),
            ...posts.take(5).map((post) => PostContainer(post: post)).toList(),
            // Define the content specific to the "All" tab here
          ],
        ),
      ),
    );
  }
}
