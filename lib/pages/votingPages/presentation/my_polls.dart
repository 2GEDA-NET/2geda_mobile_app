
import 'package:_2geda/pages/votingPages/presentation/create_poll.dart';
import 'package:_2geda/pages/widgets/polls/polls_carousel.dart';
import 'package:flutter/material.dart';

class MyPollScreen extends StatefulWidget {
  const MyPollScreen({super.key});

  @override
  State<MyPollScreen> createState() => _MyPollScreenState();
}

class _MyPollScreenState extends State<MyPollScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My polls',
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
            children: [
              Image.asset("assets/banner2.png"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton("All", 0),
                  _buildTabButton("Active", 1),
                  _buildTabButton("Ended", 2),
                ],
              ),
              const SizedBox(height: 10),
              _buildTabContent(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const CreatePollScreen(), // Replace with the actual screen
            ),
          );
        },
        child: const Icon(Icons.add), // Use any icon you prefer
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
    // Implement content for the "All" tab
    return const Column(
      children: [
        MyPollsCard(),

        // Add more items as needed
      ],
    );
  }

  Widget _buildPublicTabContent() {
    // Implement content for the "Public" tab
    return const Column(
      children: [
        MyPollsCard(),
      ],
    );
  }

  Widget _buildPrivateTabContent() {
    // Implement content for the "Private" tab
    return const Column(
      children: [
        MyPollsCard(),
      ],
    );
  }
}
