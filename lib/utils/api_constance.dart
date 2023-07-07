/// https://newsapi.org/v2/everything?q=bitcoin&apiKey=b57d9b1784c443c7955c0941978f7b11
/// b2e740ca236643d798d10e6d1d54669d
/// 4c2571511d254818b723b704e1a70756
class ApiConstance {
  static const basicApi = 'b2e740ca236643d798d10e6d1d54669d';
  static const basicUrl = 'https://newsapi.org/v2';
  static const String getAllNews = '$basicUrl/everything?q=business&apiKey=$basicApi';
  static const String searchUrl = '$basicUrl/everything?q=bitcoin&apiKey=$basicApi';
}
