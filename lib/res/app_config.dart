class AppConfig {
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  // static String baseUrl = "https://parkin.pro/";
  static String baseUrl = "http://elaveo.simbillsoft.in/";
  static String middleurl = "api/v1/store-keeper/";
  static String appLocale = 'en';
  static String? authToken;
  static int? version = 3;
  static int? id;
  static int? settings;
  static bool? isactive;
  static String? name;
  static bool get isAuthorized => (AppConfig.authToken ?? '').isNotEmpty;
  static String googleMapApiKey = "AIzaSyD3Cv8BHPMSw8DMWLbZYWwDejNm6E9oK1U";
  static int? commonindex = 0;
  static String? verson;
}

enum LoaderState { loaded, loading, error, networkError, noData }
