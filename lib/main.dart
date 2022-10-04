import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(    // This method will run the application.
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: link_page(), // the link_page function is called.
    ),
  );
}
late Completer controller; //As the return type is itself the future, so Completer is used here

// A StatefulWidget class named link_page has been created
class link_page extends StatefulWidget {
  const link_page({super.key});

  @override
  State<link_page> createState() => _link_pageState();
}

class _link_pageState extends State<link_page> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Linking Zomato Url'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.push((context), // This Navigator.push function will route to another widget called Web_View()
                MaterialPageRoute(builder: (context)=> const Web_View()),
              );
            },
            child: const Text('Open Zomato'),
          )
        ),
      ),
    );
  }
}

// A StatefulWidget class named Web_View has been created
class Web_View extends StatefulWidget {
  const Web_View({super.key});

  @override
  State<Web_View> createState() => _Web_ViewState();
}
class _Web_ViewState extends State<Web_View> {
  late WebViewController controller; // This controller will help to browsing backward and forward from page.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter WebView'),
          actions: [
            Row(
              children: [
                IconButton(onPressed: ()async{
                  if(await controller.canGoBack()) {
                    controller.goBack(); // This will browse back to the previous page
                  }
                },
                    icon: const Icon(Icons.arrow_back)
                ),
                IconButton(onPressed: ()async{
                  if(await controller.canGoForward()) {
                    controller.goForward(); // This will move to the next page
                  }
                },
                    icon: const Icon(Icons.arrow_forward)
                )
              ],
            )
          ],
        ),
        body: WebView( // This widget opens any url inside the application.
                initialUrl: 'https://www.zomato.com/', // Loads the initial url.
                javascriptMode: JavascriptMode.unrestricted, // It enables the webpage to run javascript.
                // navigation delegate helps to handle navigations in webpage.
                navigationDelegate: (navigation) {
                  // Here it is used to block the link that is outside zomato url.
                  if (navigation.url.startsWith('https://www.zomato.com/')) { // here the condition is, if the pressed url starts with https://www.zomato.com/, then only navigation will take place
                    return NavigationDecision.navigate;
                  }
                  return NavigationDecision.prevent; // Else the navigation will not take place.
                },
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
              ),
        ),
    );
  }
}