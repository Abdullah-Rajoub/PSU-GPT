import 'package:flutter/material.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:provider/provider.dart';

class DrawerItem extends StatefulWidget {
  bool isSelected = false;
  int index = -1;
  Function changeSelected = (i) {};
  var closeDrawer = () {};
  DrawerItem(
      {required isSelected,
      required index,
      required changeSelected,
      required this.closeDrawer}) {
    this.isSelected = isSelected;
    this.index = index;
    this.changeSelected = changeSelected;
  }

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    var closeDrawer = widget.closeDrawer;
    return Consumer<AllChats>(
      builder: (context, child, allChat) {
        bool isDarkMood =
            Provider.of<AppSettings>(context, listen: true).isDarkMood;
        return Container();
        // return Provider.of<AllChats>(context, listen: true)
        //             .chatsList[widget.index]
        //             .messages
        //             .length >
        //         0
        //     ? Container(
        //         color: isDarkMood
        //             ? widget.isSelected
        //                 ? AppColors.DlightPurple
        //                 : AppColors.verydarkPurple
        //             : widget.isSelected
        //                 ? AppColors.selectedGreyContainer
        //                 : AppColors.greyContainers,
        //         child: ListTile(
        //           dense: true,
        //           visualDensity: VisualDensity.compact,
        //           contentPadding:
        //               EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        //           onTap: () {
        //             widget.changeSelected(widget.index);
        //           },
        //           tileColor: widget.isSelected
        //               ? AppColors.DlightPurple
        //               : AppColors.verydarkPurple,
        //           title: Row(
        //             children: [
        //               DrawerItemIcon(
        //                 closeDrawer: closeDrawer,
        //                 icon: Icons.chat_bubble_outline,
        //                 isSelected: widget.isSelected,
        //               ),
        //               SizedBox(
        //                 width: 6,
        //               ),
        //               Expanded(
        //                 child: Text(
        //                   'Chat ${widget.index}',
        //                   style: TextStyle(
        //                     fontSize: 12,
        //                     color: isDarkMood
        //                         ? widget.isSelected
        //                             ? AppColors.LlightPurple
        //                             : AppColors.accent
        //                         : AppColors.Laccent,
        //                   ),
        //                 ),
        //               ),
        //               DrawerIconButton(
        //                 isSelected: widget.isSelected,
        //                 icon: Icons.edit_outlined,
        //                 onPressed: () {
        //                   print("editing");
        //                 },
        //               ),
        //               SizedBox(
        //                 width: 4,
        //               ),
        //               DrawerIconButton(
        //                 isSelected: widget.isSelected,
        //                 icon: Icons.delete_outline,
        //                 onPressed: () {
        //                   print("deleting");
        //                   Provider.of<AllChats>(context, listen: false)
        //                       .deletChat(widget.index);
        //                   closeDrawer();
        //                 },
        //               )
        //             ],
        //           ),
        //         ),
        //       )
        //     : Container();
      },
    );
  }
}
