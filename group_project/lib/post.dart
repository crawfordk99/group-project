import 'package:flutter/material.dart';
import 'user.dart';

class Post {
  final User user;
  final String caption;
  final String photoUrl; // You can use an image URL or Image Asset
  final DateTime postDate;

  Post({
    required this.user,
    required this.caption,
    required this.photoUrl,
    required this.postDate,
  });
}
