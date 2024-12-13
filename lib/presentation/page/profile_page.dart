import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socio_app/entity/post_entity.dart';
import 'package:socio_app/entity/user_entity.dart';
import 'package:socio_app/presentation/page/curd_feed_page.dart';
import 'package:socio_app/presentation/page/signin_page.dart';
import 'package:socio_app/service/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ApiService service = ApiService();
  UserEntity? user;
  List<PostEntity>? post;

  Future<void> setUp() async {
    user = await service.getCurrentUser();
    post = await service.getCurrentUserPosts();
    log('ini setup', name: 'profile');
    log(user?.username ?? 'kosong', name: 'profile');
    setState(() {});
  }

  @override
  initState() {
    setUp();
    log('ini init', name: 'profile');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('ini build', name: 'profile');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user?.username ?? 'Karina',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SigninPage(),
                  ),
                  (route) => true,
                );
              },
              icon: Icon(Icons.logout))
        ],
        elevation: 4,
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          SizedBox.fromSize(
            size: Size.fromHeight(170),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    radius: 110,
                    backgroundImage: NetworkImage(user?.profilePicture ??
                        'https://wallpapercave.com/wp/wp8315545.jpg'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user?.postsCount.toString() ?? '0',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text('Post'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user?.followersCount.toString() ?? '0',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text('Folowers'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user?.followingCount.toString() ?? '0',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text('Folowing'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: post?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 5,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1),
            itemBuilder: (context, index) => UserFeed(post: post?[index]),
          )
        ],
      ),
    );
  }
}

class UserFeed extends StatelessWidget {
  const UserFeed({
    super.key,
    required this.post,
  });

  final PostEntity? post;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ProfilePageState> profileKey = GlobalKey();
    return InkWell(
      onTap: () => showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => Dialog(
          child: CrudPage(
            initData: post,
          ),
        ),
      ).then(
        (value) async {
          log('then', name: 'profile');
          ProfilePageState? profileState =
              context.findAncestorStateOfType<ProfilePageState>();
          if (profileState != null) {
            await profileState.setUp();
          }
        },
      ),
      child: SizedBox(
        child: Image.network(
          post?.image ?? 'https://wallpapercave.com/wp/wp8315545.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
