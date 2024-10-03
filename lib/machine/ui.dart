import 'package:flutter/material.dart';
import 'package:mechine_test/machine/api.dart';
import 'package:mechine_test/machine/model.dart';


class SocialMediaScreen extends StatefulWidget {
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPost(); 
  }

  Future<void> refreshPosts() async {
   
    setState(() {
      futurePosts = fetchPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding:  EdgeInsets.all(10.0),
          child: const CircleAvatar(
         backgroundImage: NetworkImage(
            'https://i.pinimg.com/736x/40/a2/f2/40a2f251e1a68b690d61449297f28ea9.jpg'
          ),
          backgroundColor: Colors.transparent,  // If there's no image, transparent color.
        ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Title(
              color: Colors.black,
              child: const Text(
                "Social Media Posts",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tab('Trending', isActive: true),
                  Tab('Relationship'),
                 Tab('Self Care'),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: futurePosts,  
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<Post> posts = snapshot.data!;
                    return RefreshIndicator(
                      onRefresh: refreshPosts,  
                      child: ListView.separated(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return Postdata(posts[index]);
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text('No posts available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Tab(String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black54,
        ),
      ),
    );
  }

 Widget Postdata(Post post) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
         backgroundImage: NetworkImage(
            'https://framerusercontent.com/images/ZCqpozBNlKmn25710Dsulze3d7Y.png'
          ),
          backgroundColor: Colors.transparent,  // If there's no image, transparent color.
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(post.body),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.orange),
                  SizedBox(width: 4),
                  Text('2'),
                  SizedBox(width: 30),
                  Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey),
                  Spacer(),
                  Icon(Icons.share_outlined, size: 16, color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
