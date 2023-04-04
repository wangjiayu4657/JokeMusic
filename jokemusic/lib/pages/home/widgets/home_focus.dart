import 'package:flutter/material.dart';
import '../../../widgets/user_item_header.dart';
import '../../../widgets/user_item_footer.dart';

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
       itemBuilder: (context,idx) {
         return const UserItemFooter();
       }
    );
  }

  Widget buildListViewItem() {
    return Text("");
  }

}
