import 'bottom_nav_bar_index.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  final _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const AppMainPage(),
      const NewsPage(),
      const ChatScreen(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.deepOrange,
        activeColorSecondary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.newspaper),
        title: ("News"),
        activeColorPrimary: Colors.deepOrange,
        activeColorSecondary: Colors.grey,
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat_bubble),
        title: ("Chats"),
        activeColorPrimary: Colors.red,
        activeColorSecondary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.red,
        activeColorSecondary: Colors.grey,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style9,
      );
  }
}
