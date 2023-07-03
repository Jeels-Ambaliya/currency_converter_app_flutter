import 'package:currency_converter_app_flutter/models/from_modal.dart';
import 'package:flutter/cupertino.dart';

class FromProvider extends ChangeNotifier {
  FromModal fromModal = FromModal(FromCountry: "USD");

  void changeFrom(String From) {
    fromModal.FromCountry = From;
    notifyListeners();
  }
}
