import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PremScreen extends StatelessWidget {
  const PremScreen({
    super.key,
    required this.premIdentifier,
  });
  final String premIdentifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(premIdentifier),
          ),
        ),
      ),
    );
  }
}
