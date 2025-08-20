import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appTheme.whiteCustom,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu, color: appTheme.blackCustom),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person, color: appTheme.blackCustom),
              onPressed: () {},
            )
          ],
        ),
        body: Center(
          child: Text(
            'hello world',
            style: TextStyleHelper.instance.title20RegularRoboto,
          ),
        ),
      ),
    );
  }
}
