import 'package:dip_demo/user.dart';
import 'package:flutter/material.dart';

/// Solution of previous DIP violation that violated the first statement of DIP.
/// <br><br>
/// <b>High-level modules should not depend directly on low-level modules.
/// Both should depend on abstractions.<br></b>
/// <p>
/// Here the high level module ([UserPreferenceManager]) now depends on an
/// abstraction rather that a concrete class. Now, the UserPreferenceManager is
/// decoupled from any type of implementation of it's dependency, thus, solving
/// the first statement of DIP.
void main() {
  final userPreference = MemoryUserPreference();
  final userPreferenceService = UserPreferenceManager(userPreference);

  final currentUser = userPreferenceService.getUser();
  debugPrint(currentUser.toString());

  final newUser = User(uid: "uid-1234");
  userPreferenceService.setUser(newUser);
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
