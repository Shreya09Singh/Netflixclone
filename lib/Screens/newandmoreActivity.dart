import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflixclone/widgets/comingsoon.dart';

class NewandMoreScreen extends StatefulWidget {
  const NewandMoreScreen({super.key});

  @override
  State<NewandMoreScreen> createState() => _NewandMoreScreenState();
}

class _NewandMoreScreenState extends State<NewandMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actionsIconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              title: Text(
                "New & Hot",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.cast,
                      size: 30,
                    )),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8, left: 8, top: 8, bottom: 20),
                  child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.yellow)),
                ),
                SizedBox(
                  height: 23,
                ),
              ],
              bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.black,
                  // isScrollable: true,
                  unselectedLabelColor: Colors.white,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white),
                  labelColor: Colors.black,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  tabs: [
                    Tab(
                      text: " ❤️ Top 10 TV Shows ",
                    ),
                    Tab(
                      text: "🔥 Everyone's Watching",
                    ),
                    Tab(
                      text: "🍿 Coming Soon",
                    )
                  ]),
            ),
            body: TabBarView(children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    ComingSoonWidget(
                      day: '19',
                      month: 'June',
                      logourl:
                          'https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg',
                      imageurl:
                          'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                      overview:
                          'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ComingSoonWidget(
                      day: "07",
                      month: "Mar",
                      logourl:
                          'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                      overview:
                          'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
                      imageurl:
                          "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ComingSoonWidget(
                      imageurl:
                          'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                      overview:
                          'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                      logourl:
                          "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
                      month: "Feb",
                      day: "20",
                    ),
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
