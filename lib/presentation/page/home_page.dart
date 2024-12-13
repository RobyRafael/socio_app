import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:socio_app/data/model/post_model.dart';
import 'package:socio_app/entity/post_entity.dart';
import 'package:socio_app/service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<PostEntity>? allPost;
  final service = ApiService();

  Future<void> setUp() async {
    allPost = await service.getAllPosts();
    setState(() {});
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Socio-App',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
      ),
      body: allPost?.isEmpty == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: allPost?.length ?? 0,
              itemBuilder: (context, index) {
                return FeedTile(
                  feed: allPost?[index],
                );
              },
            ),
    );
  }
}

class FeedTile extends StatefulWidget {
  const FeedTile({
    super.key,
    required this.feed,
  });
  final PostEntity? feed;

  @override
  State<FeedTile> createState() => _FeedTileState();
}

class _FeedTileState extends State<FeedTile> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          child: Image.network(widget.feed?.image ??
              'https://www.kpopmonster.jp/wp-content/uploads/2021/07/karina_01.jpg'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    IconlyBold.heart,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Text(widget.feed?.like_count.toString() ?? '0'),
                  Expanded(child: Container()),
                  Icon(
                    IconlyBold.chat,
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    widget.feed?.user?.username ?? 'Karina',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text(widget.feed?.content ?? 'My Photo'),
                ],
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      isShow = !isShow;
                      print(isShow);
                      setState(() {});
                    },
                    child: Text(
                      isShow
                          ? 'Hide Comments'
                          : 'View all ${widget.feed?.comment_count ?? 0} comments',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  if (isShow)
                    ListView.builder(
                      itemCount: widget.feed?.comment_count ?? 0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Row(
                        children: [
                          Text(
                            widget.feed?.comments?[index].username ?? 'Karina',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Text(widget.feed?.comments?[index].comment ??
                              'Great Post'),
                        ],
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
