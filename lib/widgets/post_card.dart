import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard(
      {super.key,
      required this.name,
      required this.position,
      this.imageURL = '',
      this.description = '',
      this.profileImage = 'assets/images/default_profile.png'});

  final String name;
  final String position;
  final String imageURL;
  final String profileImage;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 3,
          ),
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 4,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF216831),
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(profileImage),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF353535)),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          position,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF353535)),
                        ),
                      ],
                    ),
                  ],
                ),
                //Follow Button
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.00)),
                          side: BorderSide(color: Color(0xFF216831)))),
                  child: const Text('Follow'),
                )
              ],
            ),
          ),
          //Description
          description.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description,
                    ),
                  ),
                )
              : Container(),

          //Image

          imageURL.isNotEmpty
              ? Image.asset(
                  imageURL,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )
              : Container(),

          //React count and shares
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('You and 69 others'),
                      Text('69 shares')
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.thumb_up_outlined,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Like'),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Comment'),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.share_outlined,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Share'),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.send_outlined,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Send'),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
