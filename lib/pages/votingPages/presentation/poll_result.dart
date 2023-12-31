import 'package:_2geda/models/polls_model.dart';
import 'package:flutter/material.dart';

class PollResultScreen extends StatefulWidget {
  final String username;
  final String timestamp;
  final String question;
  final String imageUrl;
  final double progress;
  final String remainingDays;
  final String optionContent;
  final int votesCount;
  final Option? selectedOption;

  const PollResultScreen({
    Key? key,
    required this.username,
    required this.timestamp,
    required this.question,
    required this.imageUrl,
    required this.selectedOption,
    required this.progress,
    required this.remainingDays,
    required this.votesCount,
    required this.optionContent,
  }) : super(key: key);

  @override
  State<PollResultScreen> createState() => _PollResultScreenState();
}

class _PollResultScreenState extends State<PollResultScreen> {
  late final List<OptionItem> _optionItems;

  @override
  void initState() {
    super.initState();
    if (widget.selectedOption != null) {
      _optionItems = [generateOptionItem(widget.selectedOption!)];
    } else {
      _optionItems = [];
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
            'Poll result',
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
                Text(widget.question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                const Text("252 votes",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                const Divider(),
                ExpansionPanelList(
                  elevation: 1,
                  expandedHeaderPadding: EdgeInsets.zero,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _optionItems[index].isExpanded = !isExpanded;
                    });
                  },
                  children: _optionItems.map<ExpansionPanel>((OptionItem item) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(item.optionContent),
                        );
                      },
                      body: ListTile(
                        title: Text('Votes Count: ${item.votesCount}'),
                        subtitle: const Text('To Do: Add your content here'),
                      ),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
              ]),
        )));
  }
}

class OptionItem {
  OptionItem({
    required this.optionContent,
    required this.votesCount,
    this.isExpanded = false,
  });

  String optionContent;
  int votesCount;
  bool isExpanded;
}

OptionItem generateOptionItem(Option option) {
  return OptionItem(
    optionContent: option.content,
    votesCount: option.allVote,
  );
}
