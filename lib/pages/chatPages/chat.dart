// account_screen.dart

import 'package:_2geda/data/chat.dart';
import 'package:_2geda/pages/chatPages/widgets/message_tile.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _changePage(int page) {
    setState(() {
      _currentPage = page;
      _pageController.jumpToPage(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/2geda-purple.png',
            width: 40,
            height: 40,
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: const Text(
          'Chats',
          style: TextStyle(color: Color(0xff4e0ca2)),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
            color: Colors.black,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _changePage(0),
                  child: TabButton(
                    activeImagePath: "assets/chatbg1_active.png",
                    inactiveImagePath: "assets/chatbg1_inactive.png",
                    messageType: 'Private Messages',
                    isSelected: _currentPage == 0,
                    value: 220,
                    additionalIcon:
                        Icons.message, // Set your additional icon here
                    onAddPressed: () {
                      // Handle the "Add" button press for Private Messages
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => _changePage(1),
                  child: TabButton(
                    activeImagePath: "assets/chatbg2_active.png",
                    messageType: 'Public Messages',
                    inactiveImagePath: "assets/chatbg2_inactive.png",
                    value: 220,
                    isSelected: _currentPage == 1,
                    additionalIcon: Icons
                        .broadcast_on_personal, // Set your additional icon here
                    onAddPressed: () {
                      // Handle the "Add" button press for Private Messages
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => _changePage(2),
                  child: TabButton(
                    activeImagePath: "assets/chatbg3_active.png",
                    messageType: 'Active Friends',
                    value: 220,
                    inactiveImagePath: "assets/chatbg3_inactive.png",
                    isSelected: _currentPage == 2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset('assets/banner4.png'),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    _changePage(page);
                  },
                  children: const [
                    PrivateMessageChatTab(title: "Private Messages"),
                    PublicMessageChatTab(title: "Public Messages"),
                    ActiveFriendTab(title: "Active Messages"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset('assets/banner5.png'),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String activeImagePath;
  final String inactiveImagePath;
  final String messageType;
  final bool isSelected;
  final int value;
  final IconData? additionalIcon;
  final Function()? onAddPressed;

  const TabButton({
    Key? key,
    required this.activeImagePath,
    required this.inactiveImagePath,
    required this.messageType,
    required this.value,
    required this.isSelected,
    this.additionalIcon,
    this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(isSelected ? activeImagePath : inactiveImagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (additionalIcon != null)
                Icon(
                  additionalIcon,
                  size: 20,
                  color: Colors.black,
                )
              else
                Container(
                  height: 30,
                ), // Return an empty container
              if (onAddPressed != null)
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: onAddPressed,
                    icon: const Icon(Icons.add),
                    color: Colors.black,
                    iconSize: 15,
                  ),
                )
              else
                Container(), // Return an empty container
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment:
                Alignment.bottomLeft, // Align the text to the bottom center
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value.toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  messageType,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrivateMessageChatTab extends StatelessWidget {
  final String title;

  const PrivateMessageChatTab({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    List<Widget> messageTiles = [];

    for (int index = 0; index < messages.length; index++) {
      messageTiles.add(MessageListTile(message: messages[index]));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.grey)),
                child: const Center(
                  child: Text("10",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Unread messages",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: messageTiles,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PublicMessageChatTab extends StatelessWidget {
  final String title;

  const PublicMessageChatTab({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.grey)),
            child: const Center(
              child: Text("10",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveFriendTab extends StatelessWidget {
  final String title;

  const ActiveFriendTab({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.grey)),
            child: const Center(
              child: Text("10",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
