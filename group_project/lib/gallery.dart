import 'package:flutter/material.dart';
import 'package:group_project/settings.dart';
import 'package:group_project/services/posts_storage.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<Map<String, dynamic>> _images = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  // Load images from the posts
  Future<void> _loadImages() async {
    setState(() {
      _isLoading = true;
    });

    PostsStorage postsStorage = PostsStorage();
    final posts = await postsStorage.getUserPostImages();

    setState(() {
      _images = posts;
      _isLoading = false;
    });
  }


class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // If no images, show 4 placeholders.
    final int itemCount = _images.isNotEmpty ? _images.length : 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (_images.isNotEmpty) {
            final imageUrl = _images[index]['imageUrl'];
            return Container(
              margin: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.image, size: 50)),
                    );
                  },
                ),
              ),
            );
          } else {
            // If no images are available, show a placeholder.
            return Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(child: Icon(Icons.image, size: 50)),
            );
          }
        },
      ),
    );
  }
}
