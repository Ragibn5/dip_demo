import 'package:dip_demo/user.dart';
import 'package:flutter/material.dart';

/// DIP violation that violates the second statement of DIP.
/// <br><br>
/// <b>Abstractions should not depend on details.
/// Details should depend on abstractions<br></b>
/// <p>
/// We've now added another implementation of [UserPreference] and used it.
/// So, now(from 3rd step), the [UserPreferenceManager] can work with any
/// [UserPreference] implementation. Also, notice that we did not have to change
/// anything on any abstractions, or other implementations.
/// We just added a new implementation of existing abstraction and used it.
/// So, we can now test our [UserPreferenceManager] in isolation,
/// with any implementation of [UserPreference], with mock
/// implementations as well.
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

  // db
  final dbUserPreference = DbUserPreference();
  final dbUserPreferenceService = UserPreferenceManagerImpl(dbUserPreference);

  final currentDbUser = dbUserPreferenceService.getUser();
  debugPrint(currentDbUser.toString());

  final newDbUser = User(uid: "uid-1234");
  dbUserPreferenceService.setUser(newDbUser);
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

class DbUserPreference implements UserPreference {
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
