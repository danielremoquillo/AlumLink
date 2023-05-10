import 'package:alumlink_app/main.dart';
import 'package:alumlink_app/widgets/post_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: const TextSpan(
                text: 'Alum',
                style: TextStyle(
                    fontSize: 24.0,
                    letterSpacing: -1.5,
                    color: Color(0xFF353535),
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: 'Link',
                    style: TextStyle(
                      fontSize: 24.0,
                      letterSpacing: -2,
                      color: Color(0xFF216831),
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.green,
                ))

            // //Actions
            // Row(
            //   children: [
            //     const CircleAvatar(
            //       radius: 18,
            //       child: Icon(
            //         Icons.search_outlined,
            //         size: 18,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         border: Border.all(
            //           color: const Color(0xFF216831),
            //           width: 2.0,
            //         ),
            //       ),
            //       child: const CircleAvatar(
            //         backgroundColor: Colors.white,
            //         radius: 16,
            //         child: Icon(
            //           Icons.menu_outlined,
            //           size: 16,
            //           color: Color(0xFF216831),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            //Sample
            PostCard(
              name: 'Random Guy',
              position: 'Software Architect at NCF',
              imageURL: 'assets/images/sample_post.png',
              description:
                  'The sun was setting over the vast expanse of the desert, casting a warm glow over the sand dunes. In the distance, a caravan of camels could be seen, their silhouettes stark against the orange sky. A lone traveler trudged through the sand, his face covered by a scarf to protect him from the blowing sand. He had been walking for days, and his water was running low. He knew he needed to find shelter soon, or he would not survive.',
            ),
            PostCard(
              name: 'MrBeast',
              position: 'Content Creator',
              imageURL: 'assets/images/mrbeast.jpg',
              profileImage: 'assets/images/mrbeast_logo.jpg',
            ),
            PostCard(
              name: 'Kyle Alexander Alvarez',
              position: 'Software Existentialist at BGC',
              description: '''
Title: Software Engineer

Company: XYZ Technology

Location: New York, NY

Job Type: Full-time

Salary: Commensurate with experience

Job Description:

XYZ Technology is seeking a highly motivated and experienced Software Engineer to join our growing team. The successful candidate will be responsible for designing, developing, and maintaining software applications that meet the needs of our clients.

Responsibilities:

Collaborate with cross-functional teams to identify business requirements and translate them into technical specifications.
Design and develop software solutions that meet business needs and requirements.
Write clean, efficient, and maintainable code using modern software development practices.
Conduct code reviews and provide feedback to other developers on the team.
Perform unit and integration testing to ensure the quality of software solutions.
Troubleshoot and debug software issues in a timely and effective manner.
Continuously improve software engineering processes and practices.
Stay up-to-date with emerging trends and technologies in software development.
Requirements:

Bachelor's degree in Computer Science, Software Engineering, or a related field.
3+ years of experience in software engineering.
Strong proficiency in at least one programming language, such as Java, Python, or C++.
Experience with software development frameworks such as React, Angular, or Vue.js.
Knowledge of software design patterns and principles, and experience applying them in software development.
Familiarity with Agile development methodologies.
Strong problem-solving skills and ability to think creatively.
Excellent verbal and written communication skills.
Preferred qualifications:

Master's degree in Computer Science, Software Engineering, or a related field.
Experience with cloud computing platforms such as AWS or Azure.
Familiarity with containerization technologies such as Docker and Kubernetes.
Experience with database technologies such as SQL and NoSQL.
XYZ Technology is an equal opportunity employer and encourages applications from all qualified individuals. If you are passionate about software development and are looking for an exciting opportunity to work on innovative projects, we want to hear from you!
''',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
