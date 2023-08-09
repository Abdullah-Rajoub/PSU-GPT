import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpt_clone/components/shared_components/drawer_components/drawer_item.dart';
import 'package:gpt_clone/components/shared_components/drawer_components/drawer_item_icon.dart';
import 'package:gpt_clone/global_data/app_setting.dart';
import 'package:gpt_clone/global_data/chats.dart';
import 'package:gpt_clone/global_data/user.dart';
import 'package:gpt_clone/screens/login_screen.dart';
import 'package:gpt_clone/screens/profile_page.dart';
import 'package:gpt_clone/translations/locale_keys.g.dart';
import 'package:gpt_clone/utility/constant/colors.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  DrawerItem createDrawerItem(index, isSelected) {
    return DrawerItem(
        closeDrawer: () {
          Scaffold.of(context).closeDrawer();
        },
        isSelected: isSelected,
        index: index,
        changeSelected: (indexOfItem) {
          print(indexOfItem);
          setState(() {
            Provider.of<AllChats>(context, listen: false)
                .setCurrentChat(indexOfItem);
          });
        });
  }

  void onAddChat() {
    // adding a new chat
    setState(() {
      // first find where we should add the element + make it the new selected chat
      Provider.of<AllChats>(context, listen: false)
          .setCurrentChat(Provider.of<AllChats>(context, listen: false));
      // then we add it to the specified index
      Provider.of<AllChats>(context, listen: false).addChat(chatID: "chat id");
      Scaffold.of(context).closeDrawer();
    });
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  // This function transfers user to the login page
  void navigateToLogin() {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  void logout() {
    Provider.of<AllChats>(context, listen: false).deleteAllChats();
    Provider.of<User>(context, listen: false).logout();
    Scaffold.of(context).closeDrawer();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  var firstChat;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isLoggedin = Provider.of<User>(context, listen: true).isLoggedin();
      // Constrains on size are saved here, so we can make the design responsive.
      final maxWidth = constraints.maxWidth;
      double titleSize;
      double arrowBackSize;
      double sliverTitleFontSize;

      // Adjust the font size based on the device width
      if (maxWidth >= 600) {
        titleSize = 16;
        arrowBackSize = 30;
        sliverTitleFontSize = 14;
      } else if (maxWidth >= 400) {
        titleSize = 14;
        arrowBackSize = 25;
        sliverTitleFontSize = 12;
      } else {
        titleSize = 12;
        arrowBackSize = 20;
        sliverTitleFontSize = 10;
      }

      return Consumer<AllChats>(builder: (context, allChats, child) {
        bool isDarkMood =
            Provider.of<AppSettings>(context, listen: true).isDarkMood;
        return FractionallySizedBox(
          widthFactor: 0.55,
          child: Drawer(
            backgroundColor:
                isDarkMood ? AppColors.verydarkPurple : Colors.white,
            key: _drawerKey,
            child: Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    titleSpacing: 0,
                    pinned: true,
                    leading: IconButton(
                      icon: Icon(
                        size: arrowBackSize,
                        Icons.arrow_back,
                        color: isDarkMood ? Colors.white : AppColors.Laccent,
                      ),
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                      },
                    ),
                    backgroundColor:
                        isDarkMood ? AppColors.verydarkPurple : Colors.white,
                    title: Text(
                      LocaleKeys.appBarTitle.tr(),
                      style: TextStyle(
                        fontSize: titleSize,
                        color: isDarkMood ? Colors.white : AppColors.Laccent,
                      ),
                    ),
                  ),
                  // This part is for displaying the chat
                  // SliverList(
                  //   delegate: SliverChildBuilderDelegate(
                  //     (context, index) {
                  //       return Column(
                  //         children: [
                  //           createDrawerItem(index, false),
                  //           Container(
                  //             height: 1,
                  //             color:
                  //                 isDarkMood ? AppColors.accent : Colors.white,
                  //           )
                  //         ],
                  //       );
                  //     },
                  //     childCount: 2,
                  //   ),
                  // ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    fillOverscroll: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 1,
                          color: isDarkMood ? AppColors.accent : Colors.white,
                        ),
                        // Container(
                        //   color: isDarkMood
                        //       ? AppColors.verydarkPurple
                        //       : AppColors.greyContainers,
                        //   alignment: Alignment.center,
                        //   child: ListTile(
                        //     dense: true,
                        //     visualDensity: VisualDensity.compact,
                        //     contentPadding: EdgeInsets.symmetric(
                        //         vertical: 0, horizontal: 10),
                        //     onTap: onAddChat,
                        //     title: Row(
                        //       children: [
                        //         DrawerItemIcon(
                        //           closeDrawer: () {
                        //             Scaffold.of(context).closeDrawer();
                        //           },
                        //           isSelected: false,
                        //           icon: Icons.add,
                        //         ),
                        //         SizedBox(width: 6),
                        //         Text(
                        //           LocaleKeys.newChat.tr(),
                        //           style: TextStyle(
                        //               fontSize: sliverTitleFontSize,
                        //               color: isDarkMood
                        //                   ? Colors.white
                        //                   : AppColors.Laccent),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   height: 1,
                        //   color: isDarkMood ? AppColors.accent : Colors.white,
                        // ),
//                         isLoggedin
//                             ? Container()
//                             : Container(
//                                 color: isDarkMood
//                                     ? AppColors.verydarkPurple
//                                     : AppColors.greyContainers,
//                                 alignment: Alignment.center,
//                                 child: ListTile(
//                                   dense: true,
//                                   visualDensity: VisualDensity.compact,
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: 0, horizontal: 10),
//                                   onTap: () {
//                                     Provider.of<AllChats>(context,
//                                             listen: false)
//                                         .deleteAllChats();
//                                     setState(() {});
//                                   },
//                                   title: Row(
//                                     children: [
//                                       DrawerItemIcon(
//                                         closeDrawer: () {
// // not needed here.
//                                         },
//                                         isSelected: false,
//                                         icon: Icons.delete_outline,
//                                       ),
//                                       SizedBox(width: 6),
//                                       Text(
//                                         LocaleKeys.deleteConvo.tr(),
//                                         style: TextStyle(
//                                             fontSize: sliverTitleFontSize,
//                                             color: isDarkMood
//                                                 ? Colors.white
//                                                 : AppColors.Laccent),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                         isLoggedin
//                             ? Container()
//                             : Container(
//                                 height: 1,
//                                 color: isDarkMood
//                                     ? AppColors.accent
//                                     : Colors.white,
//                                 width: double.infinity,
//                               ),
                        Container(
                          color: isDarkMood
                              ? AppColors.verydarkPurple
                              : AppColors.greyContainers,
                          alignment: Alignment.center,
                          child: ListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            onTap: !isLoggedin ? navigateToLogin : logout,
                            title: Row(
                              children: [
                                DrawerItemIcon(
                                  closeDrawer: () {},
                                  isSelected: false,
                                  icon:
                                      !isLoggedin ? Icons.login : Icons.logout,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  !isLoggedin
                                      ? LocaleKeys.login.tr()
                                      : LocaleKeys.logout.tr(),
                                  style: TextStyle(
                                      fontSize: sliverTitleFontSize,
                                      color: isDarkMood
                                          ? Colors.white
                                          : AppColors.Laccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                        !isLoggedin
                            ? Container()
                            : Container(
                                height: 1,
                                color: isDarkMood
                                    ? AppColors.accent
                                    : Colors.white,
                                width: double.infinity,
                              ),
                        !isLoggedin
                            ? Container()
                            : Container(
                                color: isDarkMood
                                    ? AppColors.verydarkPurple
                                    : AppColors.greyContainers,
                                alignment: Alignment.center,
                                child: ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  onTap: () {
                                    Scaffold.of(context).closeDrawer();
                                    Navigator.pushNamed(
                                        context, ProfilePage.routeName);
                                  },
                                  title: Row(
                                    children: [
                                      DrawerItemIcon(
                                        closeDrawer: () {},
                                        isSelected: false,
                                        icon: Icons.account_circle_outlined,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        LocaleKeys.profile.tr(),
                                        style: TextStyle(
                                            fontSize: sliverTitleFontSize,
                                            color: isDarkMood
                                                ? Colors.white
                                                : AppColors.Laccent),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}

class _MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _MyPersistentHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return InkWell(
      child: child,
      highlightColor: Colors.white,
    );
  }

  @override
  double get maxExtent => 42.0;

  @override
  double get minExtent => 42.0;

  @override
  bool shouldRebuild(_MyPersistentHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
