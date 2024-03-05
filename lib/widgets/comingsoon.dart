// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:netflixclone/module/upcomingmodule.dart';
import 'package:netflixclone/services/apiservices.dart';

// ignore: must_be_immutable
class ComingSoonWidget extends StatefulWidget {
  String day;
  String month;
  String logourl;
  String imageurl;
  String overview;
  ComingSoonWidget({
    Key? key,
    required this.day,
    required this.month,
    required this.logourl,
    required this.imageurl,
    required this.overview,
  }) : super(key: key);

  @override
  State<ComingSoonWidget> createState() => _ComingSoonWidgetState();
}

class _ComingSoonWidgetState extends State<ComingSoonWidget> {
  final ApiServices apiservise = ApiServices();
  late Future<Comingsoon> comingsoon;

  @override
  void initState() {
    comingsoon = apiservise.getComingSoonmovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: comingsoon,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.results;
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.month),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.day,
                          style: TextStyle(
                              fontSize: 29,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: size.height * .4,
                              width: size.width,
                              child: CachedNetworkImage(
                                  imageUrl: widget.imageurl)),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * .1,
                                width: size.width * .4,
                                child: CachedNetworkImage(
                                  imageUrl: widget.logourl,
                                ),
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Icon(
                                    Icons.notification_add_outlined,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                  Text(
                                    'Remind me',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                  Text(
                                    'Info',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 7,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Coming on ${widget.day} ${widget.month}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            widget.overview,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        });
  }
}
