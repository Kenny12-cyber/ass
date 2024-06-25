import 'package:flutter/material.dart';
import 'calculat_screen.dart'; // Import CalculatScreen class

import 'sign_in.dart';
import 'sign_up.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SignInScreen(),
    const SignUpScreen(),
    
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculat'),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 238, 141, 15), // Drawer background color
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.login, color: Colors.white), // Icon color
                title: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onTabTapped(0);
                },
              ),
              ListTile(
                leading: const Icon(Icons.app_registration, color: Colors.white), // Icon color
                title: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onTabTapped(1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.calculate, color: Colors.white), // Icon color
                title: const Text(
                  'Calculator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _onTabTapped(2);
                },
              ),
            ],
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 71, 9, 214),
        unselectedItemColor: const Color.fromARGB(255, 65, 39, 39),
        showUnselectedLabels: true,
      ),
      backgroundColor: Colors.blue, // Set the background color of the screen
    );
  }
}
