import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/main_menu/presentation/bloc/bloc.dart';

import '../../../../injection_container.dart';

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
    return buildBody(context);
  }

  BottomNavigationBar loggedInBottomNavigation(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          title: Text('Domov'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Zemljevid'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications),
          title: Text('Nastavitve'),
        ),
      ],
      currentIndex: widget.currentPage,
      selectedItemColor: Theme.of(context).textTheme.headline1.color,
      unselectedItemColor:
          Theme.of(context).textTheme.headline1.color.withOpacity(0.5),
      onTap: (int page) {
        if (page != widget.currentPage) {
          changePage(page, context, true);
        }
      },
    );
  }

  BottomNavigationBar loggedOutBottomNavigation(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Prijava'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Zemljevid'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications),
          title: Text('Nastavitve'),
        ),
      ],
      currentIndex: widget.currentPage,
      selectedItemColor: Theme.of(context).textTheme.headline1.color,
      unselectedItemColor:
          Theme.of(context).textTheme.headline1.color.withOpacity(0.5),
      onTap: (int page) {
        if (page != widget.currentPage) {
          changePage(page, context, false);
        }
      },
    );
  }

  BlocProvider<MainMenuBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MainMenuBloc>(),
      child:
          BlocBuilder<MainMenuBloc, MainMenuState>(builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          dispatchLoginCheck(context);
        });
        if (state is LoggedIn) {
          return loggedInBottomNavigation(context);
        } else if (state is LoggedOut) {
          return loggedOutBottomNavigation(context);
        } else {
          return loggedOutBottomNavigation(context);
        }
      }),
    );
  }

  void dispatchLoginCheck(BuildContext context) {
    BlocProvider.of<MainMenuBloc>(context).add(RefreshEvent());
  }

  void changePage(int page, BuildContext context, bool loggedIn) {
    //BlocProvider.of<MainMenuBloc>(context).add(ChangePageEvent(page: page));
    switch (page) {
      case 0:
        if (loggedIn) {
          Navigator.of(context).pushReplacementNamed(
            '/advanced',
          );
        } else {
          Navigator.of(context).pushReplacementNamed(
            '/login',
          );
        }
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed(
          '/map',
        );
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed(
          '/settings',
        );
        break;
      default:
    }
  }
}
