import 'package:currency_converter_app_flutter/models/to_modal.dart';
import 'package:flutter/cupertino.dart';

class ToProvider extends ChangeNotifier {
  ToModal toModal = ToModal(ToCountry: "INR");

  void changeTo(String To) {
    toModal.ToCountry = To;
    notifyListeners();
  }
}
