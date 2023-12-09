import 'package:flutter/material.dart';

class TagFriendsPage extends StatefulWidget {
  final List<String> initialSelectedFriends;

  const TagFriendsPage({super.key, required this.initialSelectedFriends});

  @override
  _TagFriendsPageState createState() => _TagFriendsPageState();
}

class _TagFriendsPageState extends State<TagFriendsPage> {
  late List<String> selectedFriends;
  List<String> allFriends = [
    "Friend 1",
    "Friend 2",
    "Friend 3",
    // Add more friends as needed
  ];
  late TextEditingController searchController;
  late List<String> filteredFriends;

  @override
  void initState() {
    super.initState();
    selectedFriends = List.from(widget.initialSelectedFriends);
    searchController = TextEditingController();
    filteredFriends = allFriends;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tag Friends",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (query) {
                setState(() {
                  filteredFriends = allFriends
                      .where((friend) =>
                          friend.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                hintText: "Type a name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),

            // Display selected friends as chips
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: selectedFriends.map((friend) {
                return InputChip(
                  label: Text(friend),
                  onDeleted: () {
                    setState(() {
                      selectedFriends.remove(friend);
                    });
                  },
                );
              }).toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFriends.length,
                itemBuilder: (context, index) {
                  final friend = filteredFriends[index];
                  return CheckboxListTile(
                    title: Text(friend),
                    value: selectedFriends.contains(friend),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null) {
                          if (value) {
                            selectedFriends.add(friend);
                          } else {
                            selectedFriends.remove(friend);
                          }
                        }
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedFriends);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e0ca2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
