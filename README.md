# Rim and Morty (Flutter+Elementary)

## Краткое описание

Flutter-приложение для просмотра персонажей, эпизодов и локаций вселенной Rick and Morty. Построено на фреймворке **Elementary** (MVVM) и Clean Architecture с рекомендованной структурой для этого state-менеджмента. Arch-ref / demo в линейке RIM рядом с Bloc-вариантом.

---

## Стек технологий

| Слой | Технология | Назначение |
|---|---|---|
| Фреймворк | Flutter 3.41.9 (через FVM) | Кроссплатформенный UI |
| Архитектура | Elementary (MVVM) | `ElementaryWidget` ← `WidgetModel` ← `ElementaryModel` |
| Состояние | elementary_helper (`EntityState`) | Единственный state-идиом экранов |
| DI | GetIt + Injectable | Внедрение зависимостей |
| Сеть | Dio + Retrofit | HTTP-клиент + типизированные API |
| Модели | Freezed + json_serializable | DTO и доменные сущности |
| Хранение | FlutterSecureStorage | Токен fake-login |
| Навигация | AutoRoute | Типизированный роутинг, `AutoTabsRouter` |
| Тесты | elementary_test, mocktail, golden_toolkit | WM-изоляция, golden |

---

## Особенности

- **Elementary-тройка на экран** — UI / WidgetModel / Model; catalog WM держит `EntityStateNotifier` + typed errors.
- **Feature-first** — `lib/features/{characters,episodes,locations}/` (data + domain), presentation в `lib/presentation/`.
- **Fake-login** — токен в Secure Storage, splash-гейт → login или shell.
- **Characters: адаптивный grid** — 1–6 колонок; Episodes и Locations — `SliverList` + infinite scroll.
- **Pinch-to-zoom** — detail-экраны (`pinch_to_zoom_scrollable`).
- **Боковое меню** — `flutter_drawer_menu`: Персонажи, Эпизоды, Локации, Выйти.
- **Локализация** — English-only (intl, ARB).
- **API:** `https://alpha.syazy.com:1180/api` (контракт, совместимый с Rick and Morty API; backend линейки — [rim-backend](https://github.com/menovazin/rim-backend)).

---

## Запуск

Требуется **FVM**. Установка — https://fvm.app/documentation/getting-started/installation.

```bash
fvm use
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter run
```

Версия Flutter зафиксирована в `.fvmrc` (3.41.9).

---

## Ссылки

- Хаб: https://github.com/menovazin/rim-main
- Бэкенд: https://github.com/menovazin/rim-backend
