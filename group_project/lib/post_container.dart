import 'package:flutter/material.dart';
import 'post.dart'; // Import the Post model
import 'colors.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.post,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Aspect Ratio for proportional resizing
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Rounded corners
            child: AspectRatio(
              aspectRatio: 16 / 9, // Adjust the aspect ratio to match typical images
              child: Image.network(
                post.photoUrl,
                width: double.infinity, // Take full width
                fit: BoxFit.cover, // Cover the entire aspect ratio box
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Profile Picture & Username (Below Image)
          Row(
            children: [
              CircleAvatar(
                radius: 20, // Adjust size as needed
                backgroundImage: NetworkImage(post.user.profilePictureUrl),
              ),
              const SizedBox(width: 10),
              Text(
                post.user.username,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Caption
          Text(
            post.caption,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.text,
            ),
          ),

          const SizedBox(height: 8),

          // Date
          Text(
            post.postDate.toString(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
