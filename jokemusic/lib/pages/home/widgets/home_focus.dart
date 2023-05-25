import 'package:flutter/material.dart';
import '../../../widgets/operation_tool.dart';
import '../../../widgets/user_item_header.dart';
// import '../../../widgets/operation_tool.dart';
import '../../../widgets/list_video_item.dart';

//首页 - 关注
class HomeFocus extends StatefulWidget {
  const HomeFocus({Key? key}) : super(key: key);

  @override
  State<HomeFocus> createState() => _HomeFocusState();
}

class _HomeFocusState extends State<HomeFocus> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       itemCount: 10,
       shrinkWrap: true,
       itemBuilder: (context,idx) {
         return buildListViewItem();
       }
    );
  }

  Widget buildListViewItem() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserItemHeader(),
        // ListVideoItem(),
        // OperationTool()
      ],
    );
  }

}
