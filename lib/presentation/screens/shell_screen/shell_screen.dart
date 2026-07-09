import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawer_menu/flutter_drawer_menu.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../routes/router.gr.dart';
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
    final l10n = AppLocalizations.of(context)!;
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
          ),
          body: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: _menuController.open,
              ),
              title: Text(titles[tabsRouter.activeIndex]),
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

  const _Menu({
    required this.activeIndex,
    required this.titles,
    required this.icons,
    required this.onSelect,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Row(
              children: [
                Icon(
                  Icons.science_outlined,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.appTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: theme.dividerColor.withValues(alpha: 0.15)),
          for (var i = 0; i < titles.length; i++)
            _MenuItem(
              icon: icons[i],
              title: titles[i],
              active: i == activeIndex,
              onTap: () => onSelect(i),
            ),
          const Spacer(),
          Divider(color: theme.dividerColor.withValues(alpha: 0.15)),
          _MenuItem(
            icon: Icons.logout,
            title: l10n.menuSignOut,
            active: false,
            onTap: onLogout,
          ),
          const SizedBox(height: 12),
        ],
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
    final theme = Theme.of(context);
    final color = active
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: active
                ? theme.colorScheme.primary.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 14),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: active
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurfaceVariant,
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
