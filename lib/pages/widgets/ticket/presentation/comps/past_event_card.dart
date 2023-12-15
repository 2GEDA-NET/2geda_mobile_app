import 'package:_2geda/models/ticket.dart';
import 'package:_2geda/pages/widgets/ticket/presentation/comps/summary_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PastEventCard extends StatelessWidget {
  final Event eventData;

  const PastEventCard({Key? key, required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 90,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      eventData.image ?? '',
                    ),
                    fit: BoxFit
                        .cover, // You can adjust the fit as needed (e.g., BoxFit.fill)
                  ),
                ),
                // The rest of your Container content goes here
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventData.title ?? '',
                      style: const TextStyle(
                        fontSize: 15.2809,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventData.date as String,
                      style: const TextStyle(
                        fontSize: 13.3708,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4e0ca2),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventData.location ?? eventData.platform ?? '',
                      style: const TextStyle(
                        fontSize: 13.3708,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventData.desc ?? '',
                      style: const TextStyle(
                        fontSize: 11.4607,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Summary button press
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SummaryDialog(eventData: eventData);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xff4e0ca2),
                    backgroundColor: Colors.white,
                    side:
                        const BorderSide(color: Color(0xff4e0ca2), width: 1.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.summarize),
                      SizedBox(width: 5),
                      Text('Summary'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Report button press
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xff4e0ca2),
                    backgroundColor: Colors.white,
                    side:
                        const BorderSide(color: Color(0xff4e0ca2), width: 1.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.report),
                      SizedBox(width: 5),
                      Text('Report'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

