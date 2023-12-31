import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  CarouselController controller = CarouselController();
  List<String> countryList = [
    "PAKISTAN",
    "INDIA",
    "JAPAN",
    "AUSTRALIA",
    "RUSSIA",
    "BELIZE"
  ];

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
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 80,
        title: const Text(
          'Education',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 250,
                child: CarouselWithIndicator(
                  cards: <Widget>[
                    CardWidget(0),
                    CardWidget(1),
                    CardWidget(2),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Popular examinations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _examCard("JAMB", "assets/jamb-logo-big.png",
                  "Joint Admission and Matriculation Board"),
              _examCard("Post UTME", "assets/jamb-logo-big.png",
                  "University Entrance Examinations"),
              _examCard("WAEC", "assets/waecdirect.org.png",
                  "West African Examination Council"),
              _examCard("NECO", "assets/neco-logo.png",
                  "National Examinational Council"),
              const SizedBox(
                height: 10,
              ),
              const Text("Other examinations",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _otherExamination(
                      "NDA", "assets/nda-logo.png", "Nigerian Defence Academy"),
                  _otherExamination("NABTEB", "assets/nabteb.png",
                      "National Examinational Council"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _otherExamination("NIMASA", "assets/nimasa.png",
                      "National Examinational Council"),
                  _otherExamination("TRCN", "assets/trcn.png",
                      "Teachers' Registration Council of Nigeria Professional Qualifying Examination"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Resources",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              _resourceCard(
                "Nigerian Defence Academy entrance examination past questions 2012 to 2022",
                "assets/nda-logo.png",
              ),
              _resourceCard(
                "JAMB past questions 2012-2022",
                "assets/jamb-logo-big.png",
              ),
              _resourceCard(
                "LAUTECH Post- UTME past questions 2012 to 2023",
                "assets/waecdirect.org.png",
              ),
              _resourceCard("UNILAG Post- UTME past questions 2012 to 2023",
                  "assets/neco-logo.png"),
              _resourceCard("UI Post- UTME past questions 2012 to 2023",
                  "assets/neco-logo.png"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Latest news",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _latestNews(
                "UNILAG admission list first batch is out!",
                "assets/nda-logo.png",
              ),
              _latestNews(
                "LAUTECH Post-UTME screening form is out!",
                "assets/jamb-logo-big.png",
              ),
              _latestNews(
                "WAEC 2023 result is out!",
                "assets/waecdirect.org.png",
              ),
              _latestNews("JAMB result 2023 is out!",
                  "assets/neco-logo.png"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _examCard(String name, String image, String text) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 229, 229, 229),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset(image),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resourceCard(String name, String image) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 229, 229, 229),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset(image),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _latestNews(String name, String image) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 229, 229, 229),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset(image),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _otherExamination(String name, String image, String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 180,
      height: 210,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 224, 224, 224),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 80,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(
            height: 5,
          ),
          Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    );
  }
}

class CarouselWithIndicator extends StatefulWidget {
  final List<Widget> cards;

  const CarouselWithIndicator({super.key, required this.cards});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.cards.length; i++) {
      indicators.add(
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? const Color(0xff4f0da3) : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: widget.cards,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  final int cardIndex;

  const CardWidget(this.cardIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(10),
      // Customize your card here based on the cardIndex.
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage(
                "assets/exam_bg.png"), // Set your background image here
            fit: BoxFit.cover, // You can adjust the image fit as needed
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  "assets/waecdirect.org.png",
                  width: 100,
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("WAEC results are out",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                Text("2023 WAEC results are out. Check yours now!",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
