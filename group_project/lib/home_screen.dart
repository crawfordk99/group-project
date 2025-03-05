// home_screen.dart
import 'package:flutter/material.dart';
import 'post_container.dart'; // Import the PostContainer
import 'colors.dart';
import 'post.dart';
import 'user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Sample users
    final User user1 = User(
      username: 'janedoe',
      profilePictureUrl: 'https://t3.ftcdn.net/jpg/05/83/41/98/360_F_583419866_97XPxjHDJkQ2RKMmGWdgrbqJhEZeQb55.jpg'
    );
    final User user2 = User(
        username: 'johndoe',
        profilePictureUrl: 'https://heroshotphotography.com/wp-content/uploads/2023/03/male-linkedin-corporate-headshot-on-white-square-1024x1024.jpg'
    );
    // Sa
    // Sample posts
    final List<Post> posts = [
      Post(
        user: user1,
        caption: '#EyeSpy lots of yellow things today! #banana',
        photoUrl: 'https://images.unsplash.com/photo-1603833665858-e61d17a86224?q=80&w=1254&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        postDate: DateTime.now(),
      ),
      Post(
        user: user2,
        caption: '#EyeSpy something yellow!',
        photoUrl: 'https://images.unsplash.com/photo-1615457938971-3ab61c1c0d57?q=80&w=2535&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        postDate: DateTime.now(),
      ),
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];

          return PostContainer(post: post);
        },
      ),
    );
  }
}
