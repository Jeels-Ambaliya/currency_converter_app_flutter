import 'package:currency_converter_app_flutter/models/amount_modal.dart';
import 'package:flutter/cupertino.dart';

class AmountProvider extends ChangeNotifier {
  AmountModal amountModal = AmountModal(Amount: 0);

  void changeAmount(int Amount) {
    amountModal.Amount = Amount;
    notifyListeners();
  }
}
