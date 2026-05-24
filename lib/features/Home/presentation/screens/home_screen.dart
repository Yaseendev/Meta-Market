import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/utils/generated/generated_assets/assets.gen.dart';
import 'package:supermarket/features/Home/presentation/widgets/home_search_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: UISpaces.xs,
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
            bottom: 5,
          ),
          child: Text('Meta Market'),
        ),
        centerTitle: false,
        elevation: 2,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 6,
              end: UISpaces.xs,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none_rounded),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: UISpaces.sm, vertical: UISpaces.xs),
        children: [
          HomeSearchWidget(),
        ],
      ),
    );
  }
}
