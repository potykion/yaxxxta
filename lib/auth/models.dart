import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.g.dart';

part 'models.freezed.dart';

/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/User-class.html
@freezed
abstract class User with _$User {
  /// Юзерок
  factory User({
    String photoURL,
    String uid,
    String displayName,
    String email,
  }) = _User;

  /// Создает из джсона
  factory User.fromJson(Map json) =>
      _$UserFromJson(Map<String, dynamic>.from(json));

  /// Создает из фаербейза
  factory User.fromFireBase(fb.User fireBaseUser) => User(
        photoURL: fireBaseUser.photoURL,
        uid: fireBaseUser.uid,
        displayName: fireBaseUser.displayName,
        email: fireBaseUser.email,
      );
}
