import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socio_app/entity/post_entity.dart';
import 'package:socio_app/service/api_service.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({super.key, this.initData});
  final PostEntity? initData;

  @override
  State<CrudPage> createState() => CrudPageState();
}

class CrudPageState extends State<CrudPage> {
  final contentControll = TextEditingController();
  final imageControll = TextEditingController.fromValue(TextEditingValue(
      text:
          'https://www.kpopmonster.jp/wp-content/uploads/2021/07/karina_01.jpg'));

  final service = ApiService();
  bool isCreate = true;

  @override
  void initState() {
    if (widget.initData != null) {
      contentControll.text = widget.initData?.content ?? '';
      imageControll.text = widget.initData?.image ??
          'https://www.kpopmonster.jp/wp-content/uploads/2021/07/karina_01.jpg';
      isCreate = false;
      log('value dari image : ${widget.initData?.image} ', name: 'crud');
      log('value dari content : ${widget.initData?.content} ', name: 'crud');
      setState(() {
        log('kepangil ulang ', name: 'crud');
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('value dari isCreate : $isCreate', name: 'crud');
    log('value(build) dari image : ${imageControll.text} ', name: 'crud');

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 24),
        child: Column(
          children: [
            Text(isCreate ? 'Create Feed' : 'Edit Feed',
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 84, vertical: 8),
              child: AspectRatio(
                aspectRatio: 5 / 4,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Image.network(
                    imageControll.text.isEmpty == false
                        ? imageControll.text
                        : 'https://www.kpopmonster.jp/wp-content/uploads/2021/07/karina_01.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text('ImagePreview'),
            SizedBox(height: 16),
            TextField(
              controller: imageControll,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image Url',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentControll,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Caption',
              ),
            ),
            Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isCreate)
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                    ),
                    onPressed: () async {
                      await execute(context, 0);
                    },
                    child: Text('Delete'),
                  ),
                SizedBox(width: 16),
                FilledButton(
                  onPressed: () async {
                    isCreate
                        ? await execute(context, 1)
                        : await execute(context, 2);
                  },
                  child: Text(isCreate ? 'Save' : 'Edit'),
                ),
              ],
            ),
            SizedBox(height: 62),
          ],
        ),
      ),
    );
  }

  Future<void> execute(BuildContext context, int option) async {
    try {
      String message = "";
      switch (option) {
        case 0: // Delete
          // Implement delete logic here
          message = await service.deletePost(widget.initData!.id!);
          Navigator.pop(context);
          break;
        case 1: // Create
          message = await service.createPost(
              contentControll.text, imageControll.text);
          contentControll.clear();
          break;
        case 2: // Edit
          // Implement edit logic here
          message = await service.updatePost(
              contentControll.text, imageControll.text, widget.initData!.id!);
          Navigator.pop(context);
          break;
        default:
          message = "Invalid option";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
