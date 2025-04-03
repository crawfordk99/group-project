import 'dart:math';
import 'package:intl/intl.dart';
import 'post.dart';
import 'user.dart';

// Function to generate a random past date
DateTime getRandomDate() {
  final random = Random();
  final now = DateTime.now();
  return now.subtract(Duration(days: random.nextInt(30), hours: random.nextInt(24), minutes: random.nextInt(60)));
}

// Function to format date as "hour:minute month/day"
String formatDateTime(DateTime dateTime) {
  return DateFormat('HH:mm MM/dd').format(dateTime);
}

// Sample users
final User user1 = User(
  username: 'janedoe',
  profilePictureUrl: 'https://t3.ftcdn.net/jpg/05/83/41/98/360_F_583419866_97XPxjHDJkQ2RKMmGWdgrbqJhEZeQb55.jpg',
);

final User user2 = User(
  username: 'johndoe',
  profilePictureUrl: 'https://heroshotphotography.com/wp-content/uploads/2023/03/male-linkedin-corporate-headshot-on-white-square-1024x1024.jpg',
);

final User user3 = User(
  username: 'sunseeker',
  profilePictureUrl: 'https://images.unsplash.com/photo-1557862921-37829c790f19?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
);

final User user4 = User(
  username: 'brightvibes',
  profilePictureUrl: 'https://images.unsplash.com/photo-1664575600850-c4b712e6e2bf?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
);

final User user5 = User(
  username: 'goldenhour',
  profilePictureUrl: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
);

// Sample posts
final List<Post> samplePosts = [
  Post(
    user: user1,
    caption: '#HiddenGem A bright yellow background to start the day! 🌻',
    photoUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1260&auto=format&fit=crop',
    postDate: getRandomDate(),
  ),
  Post(
    user: user2,
    caption: '#HiddenGem Found this classic yellow car on the streets! 🚗💛',
    photoUrl: 'https://images.unsplash.com/photo-1511919884226-fd3cad34687c?q=80&w=1260&auto=format&fit=crop',
    postDate: getRandomDate(),
  ),
  Post(
    user: user3,
    caption: '#HiddenGem Golden bananas for a healthy snack! 🍌✨',
    photoUrl: 'https://images.unsplash.com/photo-1603833665858-e61d17a86224?q=80&w=1260&auto=format&fit=crop',
    postDate: getRandomDate(),
  ),
  Post(
    user: user4,
    caption: '#HiddenGem A stunning yellow bird brightened my morning! 🐦☀️',
    photoUrl: 'https://images.unsplash.com/photo-1480044965905-02098d419e96?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    postDate: getRandomDate(),
  ),
  Post(
    user: user5,
    caption: '#HiddenGem Can’t get enough of these yellow fall leaves! 🍂💛',
    photoUrl: 'https://images.unsplash.com/photo-1516700675895-b2e35cae333c?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    postDate: getRandomDate(),
  ),
];

// Format the dates when displaying
void printSamplePosts() {
  for (var post in samplePosts) {
    print('${post.user.username} posted at ${formatDateTime(post.postDate)}: ${post.caption}');
  }
}

void main() {
  printSamplePosts();
}
