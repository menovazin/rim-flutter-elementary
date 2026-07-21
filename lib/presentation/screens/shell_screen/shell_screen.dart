import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawer_menu/flutter_drawer_menu.dart';

import '../../../l10n/localization_helper.dart';
import '../../../routes/router.gr.dart';
import '../../../themes/app_theme.dart';
import 'shell_screen_widget_model.dart';

class ShellScreen extends ElementaryWidget<IShellWidgetModel> {
  const ShellScreen({
    WidgetModelFactory wmFactory = shellWidgetModelFactory,
    super.key,
  }) : super(wmFactory);

  @override
  Widget build(IShellWidgetModel wm) {
    return _ShellBody(wm: wm);
  }
}

class _ShellBody extends StatefulWidget {
  final IShellWidgetModel wm;

  const _ShellBody({required this.wm});

  @override
  State<_ShellBody> createState() => _ShellBodyState();
}

class _ShellBodyState extends State<_ShellBody> {
  final _menuController = DrawerMenuController();

  static const _icons = [
    Icons.people_alt_outlined,
    Icons.movie_outlined,
    Icons.public_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.strings;
    final designs = context.designs;
    final titles = [
      l10n.tabCharacters,
      l10n.tabEpisodes,
      l10n.tabLocations,
    ];

    return AutoTabsRouter(
      routes: const [
        CharactersRoute(),
        EpisodesRoute(),
        LocationsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return DrawerMenu(
          controller: _menuController,
          backgroundColor: designs.background,
          scrimColor: Colors.black.withValues(alpha: 0.4),
          menu: _Menu(
            activeIndex: tabsRouter.activeIndex,
            titles: titles,
            icons: _icons,
            onSelect: (index) {
              tabsRouter.setActiveIndex(index);
              unawaited(_menuController.close());
            },
            onLogout: () {
              unawaited(_menuController.close());
              unawaited(widget.wm.signOut());
            },
            onToggleTheme: () {
              unawaited(widget.wm.switchTheme());
            },
          ),
          body: Scaffold(
            backgroundColor: designs.background,
            appBar: AppBar(
              backgroundColor: designs.background,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.menu, color: designs.textPrimary),
                onPressed: _menuController.open,
              ),
              title: Text(
                titles[tabsRouter.activeIndex],
                style: context.textTheme.titleLarge?.copyWith(
                  color: designs.textPrimary,
                ),
              ),
            ),
            body: child,
          ),
        );
      },
    );
  }
}

class _Menu extends StatelessWidget {
  final int activeIndex;
  final List<String> titles;
  final List<IconData> icons;
  final ValueChanged<int> onSelect;
  final VoidCallback onLogout;
  final VoidCallback onToggleTheme;

  const _Menu({
    required this.activeIndex,
    required this.titles,
    required this.icons,
    required this.onSelect,
    required this.onLogout,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final l10n = context.strings;

    return ColoredBox(
      color: designs.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                children: [
                  Icon(Icons.science_outlined, color: designs.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.appTitle,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: designs.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color: designs.textPrimary,
                      size: 24,
                    ),
                    onPressed: onToggleTheme,
                  ),
                ],
              ),
            ),
            Divider(color: designs.textSecondary.withValues(alpha: 0.15)),
            for (var i = 0; i < titles.length; i++)
              _MenuItem(
                icon: icons[i],
                title: titles[i],
                active: i == activeIndex,
                onTap: () => onSelect(i),
              ),
            const Spacer(),
            Divider(color: designs.textSecondary.withValues(alpha: 0.15)),
            _MenuItem(
              icon: Icons.logout,
              title: l10n.menuSignOut,
              active: false,
              onTap: onLogout,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool active;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final color = active ? designs.primary : designs.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: active
                ? designs.primary.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 14),
              Text(
                title,
                style: context.textTheme.titleSmall?.copyWith(
                  color: active ? designs.textPrimary : designs.textSecondary,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}