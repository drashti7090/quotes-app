import 'package:share_plus/share_plus.dart';

class ShareQuotes {
  static Future<void> shareQuote({required String quote}) async {
    Share.share(
        '$quote\nQuote App\nhttps://play.google.com/store/apps/details?id=in.yourquote.app&hl=en-IN',
        subject: quote);
  }
}
