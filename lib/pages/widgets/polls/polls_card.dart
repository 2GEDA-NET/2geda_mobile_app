import 'package:flutter/material.dart';
import 'package:_2geda/models/polls_model.dart';
import 'package:_2geda/pages/widgets/polls/polls_details.dart';
import 'package:_2geda/pages/widgets/polls/vote_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PollsCard extends StatelessWidget {
  final Poll poll;
  final int index; // Include index here

  const PollsCard({required this.poll, Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PollDetailsPage(
              username: poll.username,
              timestamp: poll.timeSince,
              question: poll.question,
              imageUrl: poll.media.image,
              progress: poll.voteCount.toDouble(),
              remainingDays: poll.remainingDays,
              votesCount: poll.voteCount,
              selectedOption:
                  poll.optionsList != null && poll.optionsList!.length > index
                      ? poll.optionsList![index]
                      : null,

              optionContent: poll.options
                  .map((option) => option.content)
                  .join(", "), // Combine option content if needed
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: ClipOval(
                  child: CachedNetworkImage(
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    imageUrl: poll.profileImage,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      poll.username,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      poll.timeSince, // Convert to local time
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  poll.question,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Visibility(
                visible: poll.media.image.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: poll.media.image,
                  ),
                ),
              ),

              // Dynamic list of options with progress bars
              ListView.builder(
                shrinkWrap: true,
                itemCount: poll.optionsList?.length ??
                    0, // Check if optionsList is not null
                itemBuilder: (BuildContext context, int index) {
                  final option = poll.optionsList?[index];
                  return VotingProgressBar(
                    progress: poll.voteCount.toDouble(),
                    text: option!.content,
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.watch_later),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      poll.remainingDays,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${poll.voteCount}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
