import 'package:dip_demo/user.dart';
import 'package:flutter/material.dart';

/// An example of DIP violation that violates the first statement of DIP.
/// <br><br>
/// <b>High-level modules should not depend directly on low-level modules.
/// Both should depend on abstractions.<br></b>
/// <p>
/// Here the high level module ([UserPreferenceManager]) still depends directly
/// on a concrete class ([MemoryUserPreference]), but now we are constructor-
/// injecting the dependency, giving us a bit more flexibility.
///<br><br>
/// Problems:
/// - Still depending on the concrete class.
/// - Improved flexibility, but still not following DIP as dependencies
/// are still concrete.
/// </p>
void main() {
  final memoryUserPreference = MemoryUserPreference();
  final userPreferenceService = UserPreferenceManager(memoryUserPreference);

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
  final MemoryUserPreference _memoryPreference;

  UserPreferenceManager(this._memoryPreference);

  User getUser() {
    return _memoryPreference.getUser();
  }

  bool setUser(User user) {
    return _memoryPreference.setUser(user);
  }
}
