import 'package:flutter/cupertino.dart';

import '../../models/theme_modal.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModal themeModal = ThemeModal(isDark: false);

  void changeTheme() {
    themeModal.isDark = !themeModal.isDark;
    notifyListeners();
  }
}
