import 'package:flutter/material.dart';

import 'api_service.dart';
import 'components.dart';
import 'models.dart';

class GetPosts extends StatefulWidget {
  const GetPosts({super.key});

  @override
  State<GetPosts> createState() => _GetPostsState();
}

class _GetPostsState extends State<GetPosts> {
  late var _postFuture;

  void initState() {
    super.initState();
    // Fetch posts when the screen loads
    _postFuture = ApiService().fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: _postFuture, // Future object to track the API call
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while waiting for data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Extract the posts from the snapshot when the data is available
            List<Post> posts = snapshot.data!;

            return ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    openSans(text: 'Title: ${posts[index].title}'),
                    openSans(text: 'Body: ${posts[index].body}'),
                    openSans(text: 'ID: ${posts[index].id}'),
                    openSans(text: 'UserID: ${posts[index].userId}'),
                    Divider(),
                  ],
                );
              },
            );
          } else {
            // In case there's no data
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
