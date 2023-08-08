import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController userInput = TextEditingController();
  InAppWebViewController? inAppWebViewController;
 String? searchName;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(onRefresh: () {
      inAppWebViewController?.reload();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Browser",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            surfaceTintColor: Colors.black,
            itemBuilder: (context) => [
              // popupmenu item 1
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.bookmark),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "All Bookmarks",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.screen_search_desktop_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Search Engine",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ],
            // offset: Offset(0, 100),
            // color: Colors.white,
            elevation: 2,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: InAppWebView(
              onWebViewCreated: (controller){
               setState(() {
                 inAppWebViewController = controller;
               });
              },
              initialUrlRequest: URLRequest(
                url: Uri.parse("https://www.google.com/"),
              ),
              pullToRefreshController: pullToRefreshController,
              onLoadStart: (controller, url) {
                setState(() {
                  inAppWebViewController = controller;
                });
              },
            ),
          ),
          Expanded(child: Container(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: userInput,
                decoration: InputDecoration(
                  hintText: "Search on Google.......",
                  suffixIcon: IconButton(onPressed: (){
                    inAppWebViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse("https://www.google.com/search?q=${userInput.text}")));
                  },icon: Icon(Icons.send),),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              )
            ],
          ),))
        ],
      ),
    );
  }
}
