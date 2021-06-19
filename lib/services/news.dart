import 'networking.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:intl/intl.dart';
String now = DateFormat("yyyy-MM-dd").format(DateTime.now());

var newsUrl =
    "https://newsapi.org/v2/everything?q=tesla&from=$now&sortBy=publishedAt&apiKey=89e9fb4a6c7d4d908cdf19ca3a7a6411";

class NewsData {
  Future getNewsData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://newsapi.org/v2/everything?q=tesla&from=2021-06-16&sortBy=publishedAt&apiKey=89e9fb4a6c7d4d908cdf19ca3a7a6411');
    var newsData = await networkHelper.getData();
    return newsData;
  }
}
// articles[0].title
