import 'package:flutter/material.dart';

import '../tools/extension/int_extension.dart';
import '../tools/extension/color_extension.dart';

enum SheetItemType {
  forgot,    //忘记密码
  report,    //举报用户
  feedback,  //我要反馈
  customer,  //联系客服
}

class SheetItem {
  const SheetItem({
    this.title,
    required this.type,
  });

  final String? title;
  final SheetItemType type;
}


///登录/重置密码/修改密码界面底部弹窗组件
class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    Key? key,
    this.title,
    this.items,
    this.cancelCallBack,
    this.selectedCallBack
  }) : super(key: key);

  final String? title;
  final List<SheetItem>? items;
  final VoidCallback? cancelCallBack;
  final ValueChanged<SheetItemType>? selectedCallBack;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {

  void handlerItemSelected(int idx) {
    final item = widget.items?[idx];
    if(item == null) return;
    widget.selectedCallBack?.call(item.type);
  }

  @override
  Widget build(BuildContext context) {
    return buildSheet(vChildren: [
      //头部
      buildSheetHeader(),

      //内容
      buildSheetContent(),

      //尾部
      buildSheetFooter(children: [
        //分割线
        Divider(thickness: 10.px, color: ColorExtension.lineColor),

        //取消
        _cancelView()
      ])
    ]);
  }

  ///构建sheet组件
  Widget buildSheet({required List<Widget> vChildren}) {
    return Container(
      padding: EdgeInsets.only(top: 20.px, bottom: 15.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.px)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: vChildren,
      ),
    );
  }

  ///构建sheet-头部组件
  Widget buildSheetHeader() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 15.px),
      color: Colors.white,
      child: Text(widget.title ?? "选择您遇到的问题",
        style: TextStyle(
          fontSize: 18.px,
          color: Colors.black87,
          fontWeight: FontWeight.w600
        )
      ),
    );
  }

  ///构建sheet-内容组件
  Widget buildSheetContent() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 10.px),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items?.length ?? 0,
      itemBuilder: (context,idx){
        return ListTile(
          onTap: () => handlerItemSelected(idx),
          visualDensity: const VisualDensity(vertical: -4),
          title: Text(widget.items?[idx].title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.px,
              color: Colors.black87,
              fontWeight: FontWeight.normal
            ),
          ),
        );
      },
      separatorBuilder: (context,idx) => Divider(thickness: 1.px, color: ColorExtension.lineColor)
    );
  }

  ///构建sheet-尾部组件
  Widget buildSheetFooter({required List<Widget> children}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _cancelView() {
    return InkWell(
      onTap: widget.cancelCallBack,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15.px),
        child: Text('取消',
          style: TextStyle(
            fontSize: 16.px,
            color: Colors.black87,
            fontWeight: FontWeight.normal
          )
        ),
      ),
    );
  }
}

