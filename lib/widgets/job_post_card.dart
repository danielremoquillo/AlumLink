import 'package:alumlink_app/models/job_post_dto.dart';
import 'package:alumlink_app/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobPostCard extends StatefulWidget {
  const JobPostCard(
      {super.key,
      this.profileImage = 'assets/images/default_profile.png',
      required this.jobPostDTO});

  final JobPostDTO jobPostDTO;
  final String profileImage;

  @override
  State<JobPostCard> createState() => _JobPostCardState();
}

class _JobPostCardState extends State<JobPostCard> {
  bool isBookMarked = false;
  @override
  Widget build(BuildContext context) {
    final int userId =
        Provider.of<SessionProvider>(context, listen: false).user.id;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              left: 20.0,
              top: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: AssetImage(widget.profileImage))),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.jobPostDTO.user['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF353535),
                              fontSize: 14),
                        ),
                        Text(
                          widget.jobPostDTO.user['email'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 14,
                              color: Color(0xFF353535)),
                        ),
                      ],
                    ),
                  ],
                ),
                userId == widget.jobPostDTO.user['id']
                    ? IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          size: 30,
                          color: const Color(0xFF216831),
                        ),
                        onPressed: () {},
                      )
                    : IconButton(
                        icon: Icon(
                          isBookMarked
                              ? Icons.bookmark
                              : Icons.bookmark_add_outlined,
                          size: 30,
                          color: const Color(0xFF216831),
                        ),
                        onPressed: () {
                          setState(() {
                            isBookMarked = !isBookMarked;
                          });
                        },
                      ),
              ],
            ),
          ),
          //Description
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.jobPostDTO.position,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF353535)),
                ),
                const Text(
                  'Posted 1 day ago',
                  style: TextStyle(fontSize: 13, color: Color(0xFF353535)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Salary',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF353535)),
                        ),
                        Text(
                          '${widget.jobPostDTO.salary.floor()}',
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFF353535)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF353535)),
                        ),
                        Text(
                          widget.jobPostDTO.location,
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFF353535)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.jobPostDTO.description,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF353535)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Action to perform when the button is pressed
                  },
                  style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF216831)))),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.check_outlined,
                          color: Color(0xFF216831),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Apply',
                          style:
                              TextStyle(color: Color(0xFF216831), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: () {
                    // Action to perform when the button is pressed
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF216831),
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF216831)))),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.chat_bubble_outline_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Message',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
