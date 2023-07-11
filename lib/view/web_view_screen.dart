// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../widgets/default_custom_text.dart';
// import '../widgets/list_tile_widget.dart';
//
// class WebViewScreen extends StatefulWidget {
//   const WebViewScreen({Key? key, required this.url}) : super(key: key);
//   final String url;
//
//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   late final WebViewController controller;
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   var loadingPercentage = 0;
//
//   @override
//   void initState() {
//     controller = WebViewController()
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {},
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (await controller.canGoBack()) {
//           controller.goBack();
//           return false;
//         }
//         else{
//           return true;
//         }
//       },
//       child: Scaffold(
//           key: scaffoldKey,
//           appBar: AppBar(
//             title: Text(widget.url),
//             actions: [
//               GestureDetector(
//                 onTap: () {
//                   showOptions();
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Icon(Icons.more_vert),
//                 ),
//               )
//             ],
//           ),
//           body: Column(
//             children: [
//               if (loadingPercentage < 100)
//                 LinearProgressIndicator(
//                   color: Colors.blue,
//                   value: loadingPercentage / 100.0,
//                 ),
//               Expanded(
//                 child: WebViewWidget(
//                   controller: controller
//                     ..setNavigationDelegate(NavigationDelegate(
//                       onPageStarted: (url) {
//                         setState(() {
//                           loadingPercentage = 0;
//                         });
//                       },
//                       onProgress: (progress) {
//                         setState(() {
//                           loadingPercentage = progress;
//                         });
//                       },
//                       onPageFinished: (url) {
//                         setState(() {
//                           loadingPercentage = 100;
//                         });
//                       },
//                       onNavigationRequest: (NavigationRequest request) {
//                         return NavigationDecision.navigate;
//                       },
//                     )),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
//
//   void showOptions() {
//     double size = MediaQuery.of(context).size.height;
//     scaffoldKey.currentState?.showBottomSheet(
//           (context) => Container(
//         decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: const BorderRadius.only(
//               topRight: Radius.circular(25),
//               topLeft: Radius.circular(25),
//             )),
//         padding: const EdgeInsets.all(10),
//         height: size * 0.32,
//         width: double.infinity,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 const Spacer(),
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: DefaultCustomText(
//                     text: 'More Options',
//                   ),
//                 ),
//                 const Spacer(),
//                 Align(
//                   alignment: AlignmentDirectional.centerEnd,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Icon(Icons.close),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(
//               thickness: 3,
//             ),
//             ListTileWidget(
//                 text: 'Share',
//                 function: () {
//                   try {
//                     Share.share(widget.url, subject: 'Look what I made!');
//                   } catch (e) {
//                     log(e.toString());
//                   }
//                 },
//                 icon: Icons.redo),
//             ListTileWidget(
//                 text: 'Open in Browser',
//                 function: () async {
//                   final Uri url = Uri.parse(widget.url);
//
//                   if (!await launchUrl(url)) {
//                     throw Exception('Could not launch $url');
//                   }
//                 },
//                 icon: Icons.link),
//             ListTileWidget(
//                 text: 'Refresh',
//                 function: () {
//                   try {
//                     controller.reload();
//                     Navigator.pop(context);
//                   } catch (e) {
//                     log(e.toString());
//                   }
//                 },
//                 icon: Icons.refresh),
//           ],
//         ),
//       ),
//     );
//   }
// }
