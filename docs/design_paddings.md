# Как отступы делать

- Для текста (напр. `BiggerText`), используем `ListTile`:
    
  ```dart
  ListTile(
    title: BiggerText(text: "Название"),
    dense: true,
  )    
  ```

    - Если нужно сделать отступ поменьше, то юзаем `dense: true`
    
- Для прочих виджетов, напр. `TextInput`, используем `SmallPadding`:

  ```dart
  SmallPadding(
    child: TextInput(...)
  )
  ```
  
- Если нужно добавить отступ между виджетами в `Row`, то юзаем `SmallPadding.between`:

  ```dart
  Row(
      children: [
        Flexible(
          child: TimePickerInput(...),
        ),
        SmallPadding.between(),
        Flexible(
          child: TimePickerInput(...),
        ),
      ],
  )
  ```