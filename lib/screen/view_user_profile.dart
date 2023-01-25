import 'package:flutter/material.dart';

class ViewUserProfile extends StatefulWidget {
  ViewUserProfile({required this.id});

  final String id;

  @override
  State<ViewUserProfile> createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('View User Profile'),
        ),
        body: Container());
  }
}
