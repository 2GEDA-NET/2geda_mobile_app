// ignore_for_file: library_private_types_in_public_api

import 'package:_2geda/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:_2geda/data/data.dart';
import 'dart:async';

class UserListWidget extends StatefulWidget {
  const UserListWidget({Key? key}) : super(key: key);

  @override
  _UserListWidgetState createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  List<User> stickiedUsers = [];
  List<User> remainingUsers = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateUserLists(); // Initial list update
    // Set up a timer to periodically update the list (every 5 seconds)
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _updateUserLists();
    });
  }

  void _updateUserLists() {
    setState(() {
      stickiedUsers = onlineUsers.where((user) => user.isSticked).toList();
      remainingUsers = onlineUsers.where((user) => !user.isSticked).toList();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void updateStickiedUsers(User user) {
    setState(() {
      if (stickiedUsers.contains(user)) {
        stickiedUsers.remove(user);
        remainingUsers.add(user);
      } else {
        if (stickiedUsers.length < 4) {
          stickiedUsers.add(user);
          remainingUsers.remove(user);
        }
      }
      user.isSticked = !user.isSticked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'People you may know',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text(
                      'View more',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4e0ca2),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Color(0xff4e0ca2),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              for (User user in stickiedUsers)
                _buildUserRow(user, updateStickiedUsers),
              for (User user in remainingUsers.take(4 - stickiedUsers.length))
                _buildUserRow(user, updateStickiedUsers),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserRow(User user, Function(User) onStickied) {
    return Column(
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.network(
                user.imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400,)),
                Text(
                  user.role,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 106, 105, 105)),
                ),
                Text(
                  user.state,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4e0ca2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                onStickied(user);
              },
              child: Text(user.isSticked ? 'Sticking' : 'Stick'),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
