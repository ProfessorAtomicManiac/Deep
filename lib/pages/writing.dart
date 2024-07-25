import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productivity_gacha_app/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:deep_pick/deep_pick.dart';
import 'package:productivity_gacha_app/routes/routes.dart';
import 'package:provider/provider.dart';

class WritingPage extends StatelessWidget {
  const WritingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // search bar
        SearchBar(),
        SizedBox(height: 20),
        Header(),
        Drive(),
      ],
    );
  }
}

class Header extends StatefulWidget {
  const Header({
    super.key,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool sortLatest = true;
  String? _selectedSort = "Sort Alphabetically";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerTextStyle = theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Container(
      // decoration: const BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(),
      //   ),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Folders", style: headerTextStyle),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: sortLatest
                    ? const Icon(Icons.arrow_downward)
                    : const Icon(Icons.arrow_upward),
                iconSize: Constants.LABEL_LARGE_FONT_SIZE,
                onPressed: () {
                  setState(() => sortLatest = !sortLatest);
                },
              ),
              const SizedBox(width: 5),
              DropdownMenu(
                textStyle: headerTextStyle,
                inputDecorationTheme: InputDecorationTheme(
                  border: InputBorder.none,
                ),
                width: 150,
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: "Sort Alphabetically",
                    label: "Sort Alphabetically",
                  ),
                  DropdownMenuEntry(
                    value: "Sort by Date",
                    label: "Sort by Date",
                  ),
                ],
              ),

              //Text("Last Modified", style: headerTextStyle),
            ],
          ),
          // SubmenuButton(
          //   //menuStyle: MenuStyle(alignment: Alignment(-1, 1)),
          //   child: IconButton(
          //     icon: const Icon(Icons.more_vert),
          //     onPressed: () {},
          //   ),
          //   menuChildren: [
          //     MenuItemButton(child: Text("Sort Alphabetically")),
          //     MenuItemButton(child: Text("Sort by Date")),
          //     MenuItemButton(child: Text("Put Folders on Top")),
          //     MenuItemButton(child: Text("Put Folders on Bottom")),
          //   ],
          // )
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget with Constants {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool textfieldHasText = false;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _handleInput());
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _handleInput() {
    setState(() => textfieldHasText = _controller.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.onSurface,
      fontSize: Constants.DEFAULT_ICON_SIZE - 5,
    );
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: Constants.curveBorderToIcon(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            padding: Constants.alignIconToText(),
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              decoration: const InputDecoration.collapsed(
                hintText: "Search",
                border: InputBorder.none,
              ),
              controller: _controller,
              style: textStyle,
              cursorColor: theme.colorScheme.onSurface,
            ),
          ),
          textfieldHasText
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() => _controller.text = "");
                    focusNode.requestFocus();
                  })
              : const SizedBox(),
          IconButton(
            padding: Constants.alignIconToText(),
            icon: const Icon(Icons.sort),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

/*
{
  "folders": [
    {
      "name": "favorites",
      "last_modified": "01-20-24",
      "folders": [],
      "files": []
    }
  ],
  "files": [
    {
      "name": "djks",
      "last_modified": "02-20-23",
      "text": "kdjsl dj sjf i3w dsjf"
    }
  ]
}
*/

class Storage with ChangeNotifier {
  Map<String, dynamic>? _drive;
  final List<String> _currentPath = [];

  Storage() {
    _loadFile();
  }

  void _loadFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final file = File('$path\\Deep\\writing.json');

      if (!file.existsSync()) {
        await file.create(recursive: true);
        var sink = file.openWrite();
        sink.write("""{
          "folders": [],
          "files": []
        }""");
        await sink.flush();
        await sink.close();
      }
      var string = await file.readAsString();
      print(string);
      _drive = jsonDecode(await file.readAsString());
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  bool isLoaded() {
    return _drive != null;
  }

  void addFolder(String folderName) {
    var currDir = getCurrentFolders();
    Map<String, dynamic> map = {
      "name": folderName,
      "folders": [],
      "files": [],
      "last_modified": "${DateTime.now().month}/${DateTime.now().day}",
    };
    currDir.add(map);
    notifyListeners();
    saveFile();
  }

  void addFile(String fileName) {
    var currDir = getCurrentFiles();
    Map<String, dynamic> map = {
      "name": fileName,
      "last_modified": "${DateTime.now().month}//${DateTime.now().day}",
      "prompt": "",
      "text": "",
    };
    currDir.add(map);
    notifyListeners();
    saveFile();
  }

  void enterFolder(String folder) {
    _currentPath.add('folder');
    _currentPath.add(folder);
    notifyListeners();
  }

  void exitCurrentFolder() {
    if (_currentPath.length >= 2) {
      _currentPath.removeLast();
      _currentPath.removeLast();
    } else {
      throw Exception("Path is at root");
    }
    notifyListeners();
  }

  List<dynamic> getCurrentFolders() {
    if (_currentPath.isEmpty) {
      return _drive?['folders'];
    } else {
      return pick(_drive, _currentPath).asMapOrThrow()['folders'];
    }
  }

  List<dynamic> getCurrentFiles() {
    if (_currentPath.isEmpty) {
      return _drive?['files'];
    } else {
      return pick(_drive, _currentPath).asMapOrThrow()['files'];
    }
  }

  void saveFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path\\Deep\\writing.json');
    var sink = file
        .openWrite(); // for appending at the end of file, pass parameter (mode: FileMode.append) to openWrite()
    sink.write(json.encode(_drive));
    await sink.flush();
    await sink.close();
  }
}

class Drive extends StatefulWidget {
  const Drive({super.key});

  @override
  State<Drive> createState() => _DriveState();
}

class _DriveState extends State<Drive> {
  var storage = Storage();

  @override
  void dispose() {
    storage.saveFile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => storage,
      child: Consumer<Storage>(
        builder: (context, cart, child) {
          return storage.isLoaded()
              ? Expanded(
                  child: ListView(children: [
                    ...[
                      for (var folder in storage.getCurrentFolders())
                        Row(children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                const Icon(Icons.folder),
                                const SizedBox(width: 5),
                                Text(folder["name"]),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(folder["last_modified"]),
                                  IconButton(
                                    icon: const Icon(Icons.more_vert),
                                    onPressed: () {},
                                  ),
                                ]),
                          ),
                        ])
                    ],
                    ...[
                      for (var file in storage.getCurrentFiles())
                        Row(children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                const Icon(Icons.file_present),
                                const SizedBox(width: 5),
                                Text(file["name"]),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(file["last_modified"]),
                                IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ])
                    ],
                    TextButton(
                        child: Text("Add Folder"),
                        onPressed: () =>
                            setState(() => storage.addFolder("Folder"))),
                    TextButton(
                        child: Text("Add File"),
                        onPressed: () =>
                            setState(() => storage.addFile("File"))),
                  ]),
                )
              : const Center(
                  child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Loading"),
                ));
        },
      ),
    );

    // return ListView.builder(
    //   itemCount: ,
    //   itemBuilder: (context, index) {
    //     _localFile
    //     return Row(
    //       children: [

    //       ],
    //       )
    //   }
    // );
  }
}

class WritingFloatingActionButton extends StatelessWidget {
  const WritingFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(RouteManager.writingCreatePage.route));
  }
}
