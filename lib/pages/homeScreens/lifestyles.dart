import 'package:_2geda/pages/widgets/lifestyle/lifestyles.dart';
import 'package:flutter/material.dart';

class Lifestyle extends StatelessWidget {
  const Lifestyle({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding:
            const EdgeInsets.all(8.0), // Add your desired padding values here
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Your existing code for the first circular button and text
            _buildCircularButton("Your lifestyle", Icons.add),
            const SizedBox(width: 15.0),
            // Add your _buildStory widgets here with circular buttons and text
            _buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),
            _buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),
            _buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),_buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),_buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),_buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),_buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),_buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),_buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),_buildStory(
              name: "First Story",
              thumbnailUrl:
                  "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              storyImages: [
                "https://wallpaperaccess.com/full/16568.png",
                "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg",
              ],
            ),
            // Add more _buildStory widgets here if needed
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton(String buttonText, IconData iconData) {
    return Column(
      children: [
        Container(
          width: 54.0,
          height: 54.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 237, 236, 238),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff4e0ca2).withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff4e0ca2), // Purple border color
                width: 2.0, // Adjust border width as needed
              ),
            ),
            child: IconButton(
              onPressed: () {
                // Add your onPressed logic here
              },
              icon: Icon(iconData, color: const Color(0xff4e0ca2)),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          buttonText,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xff4e0ca2),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildStory({
    required String name,
    required String thumbnailUrl,
    required List<String> storyImages,
    String? lastStoryText,
  }) {
    return SizedBox(
      width: 80,
      child: Stories(
        circlePadding: 0,
        storyItemList: [
          StoryItem(
            name: name,
            thumbnail: NetworkImage(thumbnailUrl),
            stories: [
              for (String image in storyImages)
                Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(image),
                      ),
                    ),
                  ),
                ),
              if (lastStoryText != null)
                Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: Text(
                      lastStoryText,
                      style: const TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 25,
                      ),
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
