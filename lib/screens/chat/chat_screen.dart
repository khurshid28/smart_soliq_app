import 'package:webview_flutter/webview_flutter.dart';

import '../../export_files.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    initF();
  }

  initF() async {
    _controller =
        WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    await _controller?.loadRequest(
      Uri.parse('https://afandi.mamatmusayev.uz/'),
    ); // ✅ Your single link here
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null) {
      return WebViewWidget(controller: _controller!);
    }
    return SizedBox();
  }
}
