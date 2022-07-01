import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static const String _guardarUsuario = '';
  static const String _guardarEquipos = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get guardarUsuario {
    return _prefs.getString('guardarUsuario') ?? _guardarUsuario;
  }

  static set guardarUsuario(String value) {
    _prefs.setString('guardarUsuario', value);
  }

  static String get guardarEquipos {
    return _prefs.getString('guardarEquipos') ?? _guardarEquipos;
  }

  static set guardarEquipos(String value) {
    _prefs.setString('guardarEquipos', value);
  }
}
