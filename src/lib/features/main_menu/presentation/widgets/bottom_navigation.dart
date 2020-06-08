import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/bloc.dart';
import 'package:shoodar/features/main_menu/presentation/pages/main_menu_page.dart';
import 'package:shoodar/features/radar/presentation/pages/map_page.dart';
import 'package:shoodar/features/user/presentation/pages/login_user.dart';
import 'package:shoodar/injection_container.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MainMenuBloc>(),
      child: BlocBuilder<MainMenuBloc, MainMenuState>(
        builder: (context, state) {
          if (state is NavigationState) {
            return BottomNavigationBar(
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
              currentIndex: state.current,
              selectedItemColor: Colors.amber[800],
              onTap: (int page) {
                if (page != state.current) {
                  changePage(page, context);
                }
              },
            );
          } else {
            return null;
          }
        },
      ),
    );
  }

  void changePage(int page, BuildContext context) {
    BlocProvider.of<MainMenuBloc>(context).add(ChangePageEvent(page: page));
    switch (page) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainMenuPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapPage()),
        );
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        break;
      default:
    }
  }
}
