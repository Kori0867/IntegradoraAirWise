import 'package:airwisesystems/pantallas/Conectores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Login.dart';
import 'Monitoreo.dart';
import 'Account.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  bool _isLoading = false;

  final List<String> _titles = [
    'Airwise-Systems',
    'Airwise-Systems',
    'Airwise-Systems'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _isLoading = true;
        });

        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _isLoading = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _signOut(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void _navigateToAccountScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: _ProfileIcon(onSignOut: () => _signOut(context), onAccountTap: () => _navigateToAccountScreen(context))),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isLoading)
            LinearProgressIndicator(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HomeScreen(),
                ConectoresScreen(),
                MonitoreoScreen(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.tap_and_play_sharp), label: 'Conectores'),
          BottomNavigationBarItem(icon: Icon(Icons.monitor), label: 'Monitoreo'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _tabController.index = index;
            _isLoading = true;
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _isLoading = false;
            });
          });
        },
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  final VoidCallback onSignOut;
  final VoidCallback onAccountTap;

  const _ProfileIcon({Key? key, required this.onSignOut, required this.onAccountTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      icon: const Icon(Icons.person),
      offset: const Offset(0, 40),
      onSelected: (Menu item) {
        if (item == Menu.itemOne) {
          onAccountTap();
        } else if (item == Menu.itemThree) {
          onSignOut();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        const PopupMenuItem<Menu>(
          value: Menu.itemOne,
          child: Text('Account'),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.itemThree,
    child: Row(
          children: [
            Icon(Icons.exit_to_app),
            SizedBox(width: 8),
            Text('Sign Out'),
          ],

    )

        ),
      ],
    );
  }
}

enum Menu { itemOne, itemThree }

