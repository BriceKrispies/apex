import 'package:flutter/material.dart';
import 'app.dart';
import 'auth/auth_notifier.dart';

void main() {
  // Fire-and-forget: the router's refreshListenable reacts when it resolves.
  // The app renders immediately on the public /home route while session
  // restoration happens in the background.
  authNotifier.initialize();
  runApp(const App());
}
