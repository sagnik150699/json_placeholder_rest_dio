import 'package:flutter/material.dart';
import 'package:json_placeholder_rest_dio/components.dart';

import 'api_service.dart';
import 'models.dart';

class GetComments extends StatefulWidget {
  const GetComments({super.key});

  @override
  State<GetComments> createState() => _GetCommentsState();
}

class _GetCommentsState extends State<GetComments> {
  late var _postFuture;

  void initState() {
    super.initState();
    // Fetch posts when the screen loads
    _postFuture = ApiService().fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Comment>>(
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
            List<Comment> comments = snapshot.data!;

            return ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    openSans(text: 'Name: ${comments[index].name}'),
                    openSans(text: 'Email: ${comments[index].email}'),
                    openSans(text: 'Comment: ${comments[index].body}'),
                    openSans(text: 'ID: ${comments[index].id}'),
                    openSans(text: 'postID: ${comments[index].postId}'),
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
