import 'package:flutter/material.dart';
import 'package:json_placeholder_rest_dio/components.dart';
import 'package:json_placeholder_rest_dio/get_comments.dart';
import 'package:json_placeholder_rest_dio/get_images.dart';
import 'package:json_placeholder_rest_dio/get_posts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ButtonNav(page: GetPosts(), text: "Get posts"),
          ButtonNav(page: GetComments(), text: "Get comments"),
          ButtonNav(page: GetImages(), text: "Get images")
        ],
      ),
    );
  }
}
