import 'package:_2geda/APIServices/polls_api_service.dart';
import 'package:_2geda/models/polls_model.dart';
import 'package:_2geda/pages/widgets/polls/polls_carousel.dart';
import 'package:flutter/material.dart';

class CastVoteScreen extends StatefulWidget {
  const CastVoteScreen({Key? key}) : super(key: key);

  @override
  _CastVoteScreenState createState() => _CastVoteScreenState();
}

class _CastVoteScreenState extends State<CastVoteScreen> {
  int _selectedIndex = 0;
  final PollApiService pollApiService = PollApiService();
  final TokenManager tokenManager = TokenManager();
  String? authToken;
  List<Poll> allPolls = [];
  List<Poll> publicPolls = [];
  List<Poll> privatePolls = [];

  @override
  void initState() {
    super.initState();
    // Fetch polls when the screen is first loaded
    _fetchPolls();
    _loadAuthToken();
  }

  _loadAuthToken() async {
    authToken = await tokenManager.getToken();
    print('Auth Token: $authToken');
    print('Token $authToken');
  }

  Future<void> _fetchPolls() async {
    try {
      final List<Poll> polls =
          await pollApiService.getPolls(authToken: authToken!);

      setState(() {
        allPolls = polls;
        publicPolls = polls.where((poll) => poll.privacy == 'Public').toList();
        privatePolls =
            polls.where((poll) => poll.privacy == 'Private').toList();
      });
    } catch (e) {
      print('Error fetching polls: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cast Vote',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Find polls',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset('assets/banner2.png'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Suggested polls",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // PollsCard(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton("All", 0),
                  _buildTabButton("Public", 1),
                  _buildTabButton("Private", 2),
                ],
              ),
              const SizedBox(height: 10),
              _buildTabContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedIndex == index
            ? const Color(0xff4e0ca2) // Selected color
            : null,
        minimumSize: const Size(80, 40),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: _selectedIndex == index ? Colors.white : null,
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildAllTabContent();
      case 1:
        return _buildPublicTabContent();
      case 2:
        return _buildPrivateTabContent();
      default:
        return Container(); // Default case, you can customize as needed
    }
  }

  Widget _buildAllTabContent() {
    return Column(
      children: allPolls.map((poll) => PollsCard(poll: poll)).toList(),
    );
  }

  Widget _buildPublicTabContent() {
    return Column(
      children: publicPolls.map((poll) => PollsCard(poll: poll)).toList(),
    );
  }

  Widget _buildPrivateTabContent() {
    return Column(
      children: privatePolls.map((poll) => PollsCard(poll: poll)).toList(),
    );
  }
}
