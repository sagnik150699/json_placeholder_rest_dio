import 'package:flutter/material.dart';
import 'package:json_placeholder_rest_dio/components.dart';

import 'api_service.dart';
import 'models.dart';

class GetImage extends StatefulWidget {
  @override
  _GetImageState createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  late Future<List<Photo>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = ApiService().fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: openSans(text: 'Photos')),
      body: FutureBuilder<List<Photo>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: openSans(text: 'Error: ${snapshot.error}'));
          } else {
            final photos = snapshot.data!;
            return ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading:
                      // Image(image: NetworkImage(photos[index].thumbnailUrl)),
                      Image.network(
                    photos[index].thumbnailUrl,
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      logger.d("Image Error: $error");
                      return Image.network(
                        'https://dummyimage.com/150x150/cccccc/000000.png&text=No+Image',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  title: openSans(text: photos[index].title),
                );
              },
            );
          }
        },
      ),
    );
  }
}
