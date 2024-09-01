// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, curly_braces_in_flow_control_structures

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:jazzee/constants.dart/constants.dart';
import '../../backend/getdata/get_posts.dart';
import '../../core/theme/base_color.dart';
import '../../models/post/post_model.dart';
import 'add_post_screen.dart';

class postScreen extends StatelessWidget {
  const postScreen({Key? key, required this.name, this.college})
      : super(key: key);
  final String name;
  final String? college;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black,
          automaticallyImplyLeading: false,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.primarycolor2,
            unselectedLabelColor: AppColors.primarycolor2,
            labelColor: Colors.white,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.primarycolor2,
            ),
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 15),
            dividerHeight: 0,
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Add Post'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            postHomeScreen(),
            AddPostPage(name: name, college: college),
          ],
        ),
      ),
    );
  }
}

class postHomeScreen extends StatefulWidget {
  postHomeScreen({
    super.key,
  });

  @override
  State<postHomeScreen> createState() => _postHomeScreenState();
}

class _postHomeScreenState extends State<postHomeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.black,
              elevation: 4,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 90,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                ),
                                controller: searchController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {},
                        child: Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.only(left: 16.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child:
                                  Icon(Icons.search, color: AppColors.black)),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          SliverList(
            delegate: SliverChildListDelegate(
              [SocialMediaPostPage()],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMediaPostPage extends StatefulWidget {
  @override
  State<SocialMediaPostPage> createState() => _SocialMediaPostPageState();
}

class _SocialMediaPostPageState extends State<SocialMediaPostPage> {
  late Future<List<Post>> futurePostResponse;
  @override
  void initState() {
    futurePostResponse = GetPosts().GetPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
        stream: supabase.from('post').stream(primaryKey: ['post_id']).map(
            (event) => event.map(Post.fromMap).toList()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
                height: double.infinity,
                child: Center(child: CircularProgressIndicator()));
          } else {
            List<Post> posts = snapshot.data;
            return posts.isEmpty
                ? Center(
                    child: Text(
                      'No Post Yet',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PostWidget(post: posts[index]),
                      );
                    },
                  );
          }
        });
  }
}

class PostWidget extends StatefulWidget {
  final Post post;

  PostWidget({required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = widget.post.postImage.split(', ');
    final List<String> likes = widget.post.like.split(',');
    print(likes.length);
    bool isliked = widget.post.like.contains(supabase.auth.currentUser!.id);
    print(imageUrls);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.black.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(3, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Text(widget.post.postByName[0]),
                backgroundColor:
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(0.4),
                radius: 20,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.post.postByName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '${widget.post.collageName} · ${DateFormat('yMMMd').format(DateTime.parse(widget.post.postDate))}',
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(widget.post.postDes, maxLines: isExpanded ? null : 2),
          InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'Read less' : 'Read more',
                style: TextStyle(color: Colors.blue),
              )),
          SizedBox(height: 10),
          widget.post.postImage.isEmpty
              ? Container()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: 400,
                  child: PageView.builder(
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // color: Colors.black.withOpacity(0.7).withAlpha(200),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imageUrls[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          // child: Image.network(
                          //   imageUrls[index],
                          //   fit: BoxFit.contain,
                          // )
                        );
                      }),
                ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${likes.length - 1} Likes',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: isliked
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(Icons.favorite_outline),
                      onPressed: () async {
                        if (isliked) {
                          if (likes.remove(supabase.auth.currentUser!.id)) {
                            print(likes.length);
                            await supabase
                                .from('post')
                                .update({'likes': '${likes.join(',')}'})
                                .eq('post_id', widget.post.postId)
                                .then((value) {
                                  setState(() {
                                    isliked = false;
                                  });
                                });
                          }
                        } else
                          likes.add(supabase.auth.currentUser!.id);
                        await supabase
                            .from('post')
                            .update({'likes': '${likes.join(',')}'})
                            .eq('post_id', widget.post.postId)
                            .then((value) {
                              setState(() {
                                isliked = true;
                              });
                            });
                      }),
                  IconButton(
                      icon: Icon(Icons.comment_outlined), onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.share_outlined), onPressed: () {}),
                ],
              ),
              IconButton(icon: Icon(Icons.send_outlined), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  bool isExpanded = false;
}
