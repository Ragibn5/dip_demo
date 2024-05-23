import 'package:dip_demo/user.dart';
import 'package:flutter/material.dart';

/// DIP violation that violates the second statement of DIP.
/// <br><br>
/// <b>Abstractions should not depend on details.
/// Details should depend on abstractions<br></b>
/// <p>
/// This is an extension of the previous step, which shows the potential
/// problem we'd face if a high level abstraction uses concrete implementations
/// of lower level. We Created another concrete implementation
/// ([FileUserPreference]), and we had to change the high level abstraction in
/// multiple ways, namely, we had to change the name of the existing methods to
/// accommodate the upcoming 2 methods, and of course, we have to add these
/// methods.
void main() {
  final userPreferenceService = UserPreferenceManagerImpl();

  // memory
  final memoryUserPreference = MemoryUserPreference();

  final currentMemoryUser =
      userPreferenceService.getUserFromMemory(memoryUserPreference);
  debugPrint(currentMemoryUser.toString());

  final newMemoryUser = User(uid: "uid-1234");
  userPreferenceService.setUserToMemory(memoryUserPreference, newMemoryUser);

  // file
  final fileUserPreference = FileUserPreference();

  final currentFileUser =
      userPreferenceService.getUserFromFile(fileUserPreference);
  debugPrint(currentFileUser.toString());

  final newFileUser = User(uid: "uid-1234");
  userPreferenceService.setUserToFile(fileUserPreference, newFileUser);
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

class FileUserPreference {
  User getUser() {
    // ...
    return User(uid: "uid-101010");
  }

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
  User getUserFromMemory(MemoryUserPreference memoryUserPreference);

  bool setUserToMemory(MemoryUserPreference memoryUserPreference, User user);

  User getUserFromFile(FileUserPreference fileUserPreference);

  bool setUserToFile(FileUserPreference memoryUserPreference, User user);

  // Methods for other concrete dependency implementations go here
  // ...
}

class UserPreferenceManagerImpl implements UserPreferenceManager {
  @override
  User getUserFromMemory(MemoryUserPreference memoryUserPreference) {
    return memoryUserPreference.getUser();
  }

  @override
  bool setUserToMemory(MemoryUserPreference memoryUserPreference, User user) {
    return memoryUserPreference.setUser(user);
  }

  @override
  User getUserFromFile(FileUserPreference fileUserPreference) {
    return fileUserPreference.getUser();
  }

  @override
  bool setUserToFile(FileUserPreference memoryUserPreference, User user) {
    return memoryUserPreference.setUser(user);
  }

  // Methods for other concrete dependency implementations go here
  // ...
}
