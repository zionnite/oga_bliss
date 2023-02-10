import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.icon,
    required this.name,
  }) : super(key: key);

  final Icon icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 25.0,
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          name,
          style: TextStyle(
            fontFamily: 'SourceSansPro',
            fontSize: 20,
            color: Colors.blue.shade500,
          ),
        ),
      ),
    );
  }
}
