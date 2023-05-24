import 'package:flutter/material.dart';
import 'package:jokemusic/widgets/custom_button.dart';
import '../../tools/extension/int_extension.dart';

class UserEditorPage extends StatefulWidget {
  static const String routeName = "/user_editor";
  const UserEditorPage({Key? key}) : super(key: key);

  @override
  State<UserEditorPage> createState() => _UserEditorPageState();
}

class _UserEditorPageState extends State<UserEditorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return CustomScrollView(
      slivers: [
        buildSliverAppBar(),
        // buildBody()
      ],
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      // floating: true,
      expandedHeight: 300.px,
      actions: [
        IconButton(
          onPressed: (){},
          icon: const Icon(Icons.more_horiz)
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: const Text("测试"),
        background: Column(
          children: [
            buildFlexibleSpaceBarImg(),
            Expanded(child: buildFlexibleSpaceBarBody())
          ],
        ),
      ),
    );
  }

  Widget buildFlexibleSpaceBarImg() {
    return SizedBox(
      height: 130.px,
      width: double.infinity,
      child: Image.asset("assets/images/sources/joke_logo.png",fit: BoxFit.fitWidth)
    );
  }

  Widget buildFlexibleSpaceBarBody() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        buildFlexibleSpaceBarBodyContent(),
        Positioned(
          top: -20.px,
          left: 15.px,
          child: buildFlexibleSpaceBarBodyIcon()
        ),
        Positioned(
          top: 8.px,
          right: 15.px,
          child: buildFlexibleSpaceBarBodyEditButton()
        ),
      ],
    );
  }

  Widget buildFlexibleSpaceBarBodyIcon() {
    return SizedBox(
      width: 80.px,
      height: 80.px,
      child: const CircleAvatar(backgroundImage: AssetImage("assets/images/sources/joke_logo.png")),
    );
  }

  Widget buildFlexibleSpaceBarBodyEditButton() {
    return CustomButton(
      radius: 17.px,
      backgroundColor: Colors.white,
      textColor: Colors.orangeAccent,
      enableColor: Colors.transparent,
      onPressed: (){},
      title: "编辑资料"
    );
  }

    Widget buildFlexibleSpaceBarBodyContent() {
    return Container(
      color: Colors.blue,
    );
  }



  Widget buildSliverBody() {
    return Container(
      color: Colors.blue,
      child: const Center(child: Text("端资源")),
    );
  }

}
