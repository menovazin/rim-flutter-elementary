import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'router.gr.dart';

Widget _iosTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    )),
    child: SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-0.3, 0.0),
      ).animate(CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.easeOut,
      )),
      child: child,
    ),
  );
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
        transitionsBuilder: _iosTransitionBuilder,
        duration: const Duration(milliseconds: 350),
        reverseDuration: const Duration(milliseconds: 350),
        barrierColor: Colors.transparent,
      );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(
          page: ShellRoute.page,
          children: [
            AutoRoute(page: CharactersRoute.page, initial: true),
            AutoRoute(page: EpisodesRoute.page),
            AutoRoute(page: LocationsRoute.page),
          ],
        ),
        AutoRoute(page: CharacterDetailRoute.page),
      ];
}
