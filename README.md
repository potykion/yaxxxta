# yaxxxta

Yet Another Habit TrAcker

## Задачи в работе

https://github.com/potykion/yaxxxta/issues/assigned/potykion

## Перед запуском на локалке

```
pub get
firebase emulators:start
```

## Деплой

```
flutter build web
firebase deploy --only hosting
```

## Проблемес с auto_route

При генерации `.gr.dart` - файла с роутами - надо фиксануть пару вещей:

1. Прописать `part of`, напр. `part of "routes.dart";`

2. Удалить все `_i`-префиксы, напр. используя регулярку `_i\d\.`
