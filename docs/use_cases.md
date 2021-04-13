# Юзкейсы

## Загрузка приложения /loading

1. Грузим системные настройки

    1. Локаль
    2. Плагин для локальных уведомлений
    3. Таймзоны
    4. Фаербейз

2. Грузим данные о юзере

    1. Получаем текущего юзера
    2. Если юзера нет, то редирект на /auth
    3. Грузим инфу о юзере по юзер айди
   
         1. Получаем UserData с айди юзера
         2. Если UserData нет, то создаем UserData с айди юзера и вставляем в бд 

3. Грузим привычки

    1. Грузим привычки по юзеру
    2. Планируем уведомления для привычек, у которых их нет

        1. Фильтруем привычки, у которых проставлено время выполнения
        2. Берем все пендинг уведомления
        3. Фильтруем привычки, у которых нет уведомлений
        4. Для каждой привычки скедулим некст уведомление

    3. Грузим выполнения привычек за текущий день

        - TODO фильтрация по привычкам юзера

4. Грузим награды по юзеру

5. Редиректим на /calendar

## Создание привычки

## Редактирование привычки

## Удаление привычки

## Загрузка привычек

## Выполнение привычки

## Создание выполнения привычки руками

## Редактирование выполнения привычки

## Удаление выполнения привычки

## Загрузка выполнений привычки за дату

## Загрузка выполнений привычки для привычки