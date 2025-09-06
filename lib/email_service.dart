@JS()
library emailjs;

import 'package:js/js.dart';

@JS('emailjs.send')
external dynamic send(String serviceID, String templateID, dynamic params);
