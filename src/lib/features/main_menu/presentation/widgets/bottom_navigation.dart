import 'package:flutter/material.dart';
import 'package:shoodar/features/main_menu/presentation/pages/main_menu_page.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';
import 'package:shoodar/features/user/presentation/pages/login_user.dart';

class BottomNavigation extends StatefulWidget {
  final int currentPage;
  const BottomNavigation({
    Key key,
    this.currentPage,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Domov'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Zemljevid'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Uporabnik'),
        ),
      ],
      currentIndex: widget.currentPage,
      selectedItemColor: Theme.of(context).textTheme.headline1.color,
      unselectedItemColor:
          Theme.of(context).textTheme.headline1.color.withOpacity(0.5),
      onTap: (int page) {
        if (page != widget.currentPage) {
          changePage(page, context);
        }
      },
    );
  }

  void changePage(int page, BuildContext context) {
    //BlocProvider.of<MainMenuBloc>(context).add(ChangePageEvent(page: page));
    switch (page) {
      case 0:
        Navigator.of(context).pushReplacementNamed(
          '/menu',
        );
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed(
          '/map',
        );
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed(
          '/login',
        );
        break;
      default:
    }
  }
}
