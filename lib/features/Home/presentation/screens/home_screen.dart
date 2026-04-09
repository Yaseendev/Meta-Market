import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/utils/generated/generated_assets/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 6,
            bottom: UISpaces.xs,
          ),
          child: Assets.images.logoTransparent.image(
            height: 10,
            fit: BoxFit.fill,
          ),
        ),
        titleSpacing: 6,
        title: Padding(
          padding: const EdgeInsets.only(
            bottom: 4,
          ),
          child: Text('Meta Market'),
        ),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded),
            padding: EdgeInsetsDirectional.only(
              bottom: 6,
              end: 6,
            ),
          ),
        ],
      ),
    );
  }
}
