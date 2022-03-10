import 'package:erp/app/models/user.dart';
import 'package:flutter/material.dart';

class UserStore extends ValueNotifier<User?> {
  UserStore() : super(null);

  setUser(User? user) {
    value = user;
  }
}
