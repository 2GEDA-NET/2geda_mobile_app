
import 'package:_2geda/pages/profilePages/presentation/post_an_advert.dart';
import 'package:flutter/material.dart';

class AdvertPolicy extends StatelessWidget {
  const AdvertPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Advert Policy',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/2geda-purple.png'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                  "Our Adverts Policy are the rules guiding posting of Ads on 2geda as a Platform to reach out to Potential Clients and Investors. \n \n(1) Our Audience \n \nOur Community of users are Elites and they have right to tailor the content they prefer to see per time and how it is being shown. \n \n(2) Content Being a curated platform : \n \nwe are concerned about the content of the Adverts that’ll be shown to users. \nThis assure the users that we have them in mind always. \n \n(3) Ad sizes \n \nOur Community of users are Elites and they have right to tailor the content they prefer to see per time and how it is being shown. \n \n(4) Prices \n \n Our Community of users are Elites and they have right to tailor the content they prefer to see per time and how it is being shown.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text("Homepage Leader Board",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 68,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 217, 217, 217),
                ),
                child: const Center(
                  child: Text("308 x 68",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("In-page Ad",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 217, 217, 217),
                ),
                child: const Center(
                  child: Text("1200 x 80",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Pop-Up Ads",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 217, 217, 217),
                ),
                child: const Center(
                  child: Text("All Pages",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PostAnAdvert(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4e0ca2),
                    minimumSize: const Size(300, 60),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(1),
                    // ),
                  ),
                  child: const Text(
                    "Post an Advert",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
