import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:techcity/api-networking-lesson/post.dart';
import 'package:techcity/api-networking-lesson/post_card.dart';
import 'package:techcity/api-networking-lesson/post_service.dart';


/// step 1: get the apiEndpoint eg. https://dummyjson.com/posts
/// step 2: create a mapper/decoder class eg. json2dart or app.quicktype.io
/// Step 3: use client to fetch inside your service class
/// Step 4: use state management to fetch and hold parsed response
/// step 5: in your use scopedModel and ScopeDescendant to request the data from service
/// step 6: Render response on screen

class TechCityBlog extends StatefulWidget {
  const TechCityBlog({super.key});

  @override
  State<TechCityBlog> createState() => _TechCityBlogState();
}

class _TechCityBlogState extends State<TechCityBlog> {
  final provider = PostProvider();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await provider.fetchPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PostProvider>(
      model: provider,
      child: ScopedModelDescendant<PostProvider>(
        builder: (
          context,
          _,
          model,
        ) {
          final posts = model.posts;
          return model.isBusy
              ? const Material(
                child: Center(
                    child: CircularProgressIndicator(),
                  ),
              )
              : Scaffold(
                  appBar: AppBar(
                    title: Text('TechCity Wall'),
                  ),
                  body: ListView(
                    children: [
                      TextFormField(
                        onChanged: (v) {
                          Future.delayed(Duration(seconds: 5), () {});
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ...posts.map((post) => PostCard(
                          id: post.id ?? 0,
                          title: post.title ?? '',
                          body: post.body ?? '',
                          tags: post.tags ?? [],
                          reactions: post.reactions ?? Reactions(),
                          views: post.views ?? 0)).toList()
                    ],
                  ),
                );
        },
      ),
    );
  }
}
