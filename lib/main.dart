import 'package:dip_demo/user.dart';
import 'package:flutter/material.dart';

/// An example of DIP violation that violates the first statement of DIP.
/// <br><br>
/// <b>High-level modules should not depend directly on low-level modules.
/// Both should depend on abstractions.<br></b>
/// <p>
/// Here the high level module ([UserPreferenceManager]) depends directly on
/// a concrete class ([MemoryUserPreference]).
///<br><br>
/// Problems:
/// - Low level module is tightly coupled to high level module.
/// - Hard to switch to another low level impl or test the [UserPreferenceManager].
/// </p>
void main() {
  final userPreferenceService = UserPreferenceManager();

  final currentUser = userPreferenceService.getUser();
  debugPrint(currentUser.toString());

  final newUser = User(uid: "uid-1234");
  userPreferenceService.setUser(newUser);
}

////////////////////
// Low-level modules
////////////////////
class MemoryUserPreference {
  User getUser() {
    // ...
    return User(uid: "uid-101010");
  }

  bool setUser(User user) {
    // ...
    return true;
  }
}

///////////////////
// High-level module
///////////////////
class UserPreferenceManager {
  final _memoryPreference = MemoryUserPreference();

  User getUser() {
    return _memoryPreference.getUser();
  }

  bool setUser(User user) {
    return _memoryPreference.setUser(user);
  }
}
