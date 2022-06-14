
import 'package:get/get_navigation/src/root/internacionalization.dart';

class LocaleString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': 'Hello World',
    },
    'ar_SY': {
      'hello': 'مرحبا',
    }
  };
}