import 'package:dip_demo/user.dart';
import 'package:flutter/material.dart';

/// DIP violation that violates the second statement of DIP.
/// <br><br>
/// <b>Abstractions should not depend on details.
/// Details should depend on abstractions<br></b>
/// <p>
/// Here, the [UserPreferenceManager] abstraction contain details of a
/// lower level concrete implementation in such a way that if we introduce
/// any change or add another variation of the low level dependency, we may
/// need to modify the [UserPreferenceManager] as well, which violates the
/// second statement of DIP.
void main() {
  final memoryUserPreferenceService = UserPreferenceManagerImpl();

  final memoryUserPreference = MemoryUserPreference();

  final currentMemoryUser =
      memoryUserPreferenceService.getUser(memoryUserPreference);
  debugPrint(currentMemoryUser.toString());

  final newMemoryUser = User(uid: "uid-1234");
  memoryUserPreferenceService.setUser(memoryUserPreference, newMemoryUser);
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
abstract class UserPreferenceManager {
  User getUser(MemoryUserPreference memoryUserPreference);

  bool setUser(MemoryUserPreference memoryUserPreference, User user);
}

class UserPreferenceManagerImpl implements UserPreferenceManager {
  @override
  User getUser(MemoryUserPreference memoryUserPreference) {
    return memoryUserPreference.getUser();
  }

  @override
  bool setUser(MemoryUserPreference memoryUserPreference, User user) {
    return memoryUserPreference.setUser(user);
  }
}
