import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageAnimatedRoute extends CustomTransitionPage {
  final Widget screen;
  final LocalKey? key;
  PageAnimatedRoute({
    this.key,
    required this.screen,
  }) : super(
          key: key,
          child: screen,
          transitionsBuilder: (context, animation, secAnimation, widget) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: widget,
            );
          },
        );
}
