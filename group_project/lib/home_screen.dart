import 'package:flutter/material.dart';
import 'post_container.dart'; // Import the PostContainer
import 'sample_posts.dart'; // Import the sample posts

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: samplePosts.length,
        itemBuilder: (context, index) {
          final post = samplePosts[index];

          return PostContainer(post: post);
        },
      ),
    );
  }
}
