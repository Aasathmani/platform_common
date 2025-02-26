import 'package:url_launcher/url_launcher_string.dart';

Future<bool> launchURL(String url) async {
  if (await canLaunchUrlString(url)) {
    return launchUrlString(url);
  } else {
    throw 'Could not launch $url';
  }
}
