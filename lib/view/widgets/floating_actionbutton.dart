import 'package:flutter/material.dart';

import 'package:studentmanagement_provider/utils/constants.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
    this.page,
  });
  final dynamic page;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5,
      backgroundColor: Constants().appColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Icon(
        Icons.add,
        color: Constants().whiteColor,
      ),
    );
  }
}
