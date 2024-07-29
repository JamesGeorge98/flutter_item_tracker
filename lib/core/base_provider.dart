import 'package:flutter/foundation.dart';

class BaseProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoader({bool? isLoading}) {
    if (isLoading != null) {
      _isLoading = isLoading;
      return;
    }
    _isLoading = !_isLoading;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('loading', value: _isLoading));
  }
}
