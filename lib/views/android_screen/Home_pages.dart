import 'package:connectivity_plus/connectivity_plus.dart';
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
  List<String> bookmark = [];
  String link = "https://www.google.com/";
  late PullToRefreshController pullToRefreshController;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(onRefresh: () {
      inAppWebViewController?.reload();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Browser",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            surfaceTintColor: Colors.black,
            onSelected: (value) {
              if ("Book" == value) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 400,
                        width: double.infinity,
                        child: Column(
                          children: bookmark
                              .map((e) => Center(
                                    child: Container(
                                      height: 100,
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(e),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                bookmark.remove(e);
                                              });
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    });
              } else if (2 == value) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("Search Engine"),
                    content: Container(
                      height: 250,
                      child: Column(
                        children: [
                          RadioListTile(
                            title: const Text("Google"),
                            value: "https://www.google.com/",
                            groupValue: link,
                            onChanged: (val) {
                              setState(() {
                                link = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.tryParse(link),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                              title: const Text("Yahoo"),
                              value: "https://www.yahoo.com/",
                              groupValue: link,
                              onChanged: (val) {
                                setState(() {
                                  link = val!;
                                });
                                inAppWebViewController!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.tryParse(link),
                                  ),
                                );
                                Navigator.of(context).pop();
                              }),
                          RadioListTile(
                              title: const Text("Bing"),
                              value: "https://www.bing.com/",
                              groupValue: link,
                              onChanged: (val) {
                                setState(() {
                                  link = val!;
                                });
                                inAppWebViewController!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.tryParse(link),
                                  ),
                                );
                                Navigator.of(context).pop();
                              }),
                          RadioListTile(
                              title: const Text("Duck Duck Go"),
                              value: "https://www.duckduckgo.com/",
                              groupValue: link,
                              onChanged: (val) {
                                setState(() {
                                  link = val!;
                                });
                                inAppWebViewController!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.tryParse(link),
                                  ),
                                );
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Book",
                child: Row(
                  children: [
                    Icon(Icons.bookmark),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Al Bookmarks",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              const PopupMenuItem(
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
            flex: 5,
            child: StreamBuilder(
                stream: Connectivity().onConnectivityChanged,
                builder: (BuildContext context,
                    AsyncSnapshot<ConnectivityResult> snapshot) {
                  return (snapshot.data == ConnectivityResult.mobile ||
                          snapshot.data == ConnectivityResult.wifi)
                      ? InAppWebView(
                          onWebViewCreated: (controller) {
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
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/notfound.jpeg"),
                            ),
                          ),
                        );
                }),
          ),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextFormField(
                    controller: userInput,
                    decoration: InputDecoration(
                      hintText: "Search on Google.......",
                      suffixIcon: IconButton(
                        onPressed: () {
                          inAppWebViewController?.loadUrl(
                            urlRequest: URLRequest(
                              url: Uri.parse(
                                  "https://www.google.com/search?q=${userInput.text}"),
                            ),
                          );
                        },
                        icon: const Icon(Icons.send),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        inAppWebViewController!.loadUrl(
                          urlRequest: URLRequest(
                            url: Uri.parse("https://www.google.com/"),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.home,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (inAppWebViewController?.canGoForward() != null) {
                          inAppWebViewController!.goForward();
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        bookmark.add("${link}search?q=${userInput.text}");
                      },
                      icon: const Icon(
                        Icons.bookmark_add,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (inAppWebViewController?.canGoBack() != null) {
                          inAppWebViewController!.goBack();
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        inAppWebViewController!.reload();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
