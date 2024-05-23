import 'package:dip_demo/user.dart';
import 'package:flutter/material.dart';

/// Solution of previous DIP violation that violated the first statement of DIP.
/// <br><br>
/// <b>High-level modules should not depend directly on low-level modules.
/// Both should depend on abstractions.<br></b>
/// <p>
/// We've now added another implementation of [UserPreference] and used it.
/// So, now(from 3rd step), the [UserPreferenceManager] can work with any
/// [UserPreference] implementation.
/// We can now test our [UserPreferenceManager] in isolation,
/// with any implementation of [UserPreference], with mock
/// implementations as well.
void main() {
  // memory pref
  final memoryUserPreference = MemoryUserPreference();
  final memoryUserPreferenceService =
      UserPreferenceManager(memoryUserPreference);

  final currentMemoryUser = memoryUserPreferenceService.getUser();
  debugPrint(currentMemoryUser.toString());

  final newMemoryUser = User(uid: "uid-1234");
  memoryUserPreferenceService.setUser(newMemoryUser);

  // file pref
  final fileUserPreference = MemoryUserPreference();
  final fileUserPreferenceService = UserPreferenceManager(fileUserPreference);

  final currentFileUser = fileUserPreferenceService.getUser();
  debugPrint(currentFileUser.toString());

  final newFileUser = User(uid: "uid-1234");
  fileUserPreferenceService.setUser(newFileUser);
}

////////////////////
// Low-level modules
////////////////////
abstract class UserPreference {
  User getUser();

  bool setUser(User user);
}

class MemoryUserPreference implements UserPreference {
  @override
  User getUser() {
    // ...
    return User(uid: "uid-101010");
  }

  @override
  bool setUser(User user) {
    // ...
    return true;
  }
}

class FileUserPreference implements UserPreference {
  @override
  User getUser() {
    // ...
    return User(uid: "uid-101010");
  }

  @override
  bool setUser(User user) {
    // ...
    return true;
  }
}

///////////////////
// High-level module
///////////////////
class UserPreferenceManager {
  final UserPreference _userPreference;

  UserPreferenceManager(this._userPreference);

  User getUser() {
    return _userPreference.getUser();
  }

  bool setUser(User user) {
    return _userPreference.setUser(user);
  }
}
