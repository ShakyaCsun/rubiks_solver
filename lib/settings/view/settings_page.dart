import 'package:flutter/material.dart';
import 'package:rubiks_solver/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SettingsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}
