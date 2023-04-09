import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(title: 'Home', context: context, route: '/'),
              _menuItem(title: 'About us', context: context, route: '/about'),
              _menuItem(title: 'Feed', context: context, route: '/feeds'),
              _menuItem(title: 'Help', context: context, route: '/help'),
            ],
          ),
          Row(
            children: [
              _menuItem(
                  title: 'Sign In',
                  isActive: false,
                  context: context,
                  route: '/login'),
              _menuItem(
                  title: 'Set Up Profile',
                  isActive: true,
                  context: context,
                  route: '/register'),
              // _registerButton()
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
      {String title = 'Title Menu',
      BuildContext context,
      isActive = false,
      String route = '/'}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            context.go(route);
          },
          child: Column(
            children: [
              Text(
                '$title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.deepPurple : Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              isActive
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 26, 100, 116),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 9, 53, 61),
            spreadRadius: 10,
            blurRadius: 12,
          ),
        ],
      ),
      child: const Text(
        'Register',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(137, 234, 230, 230),
        ),
      ),
    );
  }
}
