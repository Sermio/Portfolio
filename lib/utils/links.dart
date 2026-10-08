import 'package:url_launcher/url_launcher.dart';

/// Opens [uri] in a new tab (web) or the external app that handles it.
Future<void> openLink(Uri uri) => launchUrl(
      uri,
      mode: uri.scheme.startsWith('http')
          ? LaunchMode.externalApplication
          : LaunchMode.platformDefault,
    );
