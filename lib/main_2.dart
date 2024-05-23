import 'package:dip_demo/user.dart';
import 'package:flutter/material.dart';

/// DIP violation that violates the second statement of DIP.
/// <br><br>
/// <b>Abstractions should not depend on details.
/// Details should depend on abstractions<br></b>
/// <p>
/// Here, we have introduced abstraction to the low level components
/// and made the high level abstraction depend on this low level abstraction
/// rather than specific implementation details of the individual concrete
/// implementations (of low level components).
/// <br><br>
/// This made our higher level component fully independent on any specific
/// implementation of a low level component, making it testable in isolation,
/// and increasing the flexibility.
void main() {
  // memory
  final memoryUserPreference = MemoryUserPreference();
  final memoryUserPreferenceService =
      UserPreferenceManagerImpl(memoryUserPreference);

  final currentMemoryUser = memoryUserPreferenceService.getUser();
  debugPrint(currentMemoryUser.toString());

  final newMemoryUser = User(uid: "uid-1234");
  memoryUserPreferenceService.setUser(newMemoryUser);

  // file
  final fileUserPreference = FileUserPreference();
  final fileUserPreferenceService =
      UserPreferenceManagerImpl(fileUserPreference);

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

// Other concrete dependency implementations go here
// ...

///////////////////
// High-level module
///////////////////
abstract class UserPreferenceManager {
  final UserPreference userPreference;

  UserPreferenceManager(this.userPreference);

  User getUser();

  bool setUser(User user);
}

class UserPreferenceManagerImpl extends UserPreferenceManager {
  UserPreferenceManagerImpl(super.userPreference);

  @override
  User getUser() {
    return userPreference.getUser();
  }

  @override
  bool setUser(User user) {
    return userPreference.setUser(user);
  }
}
