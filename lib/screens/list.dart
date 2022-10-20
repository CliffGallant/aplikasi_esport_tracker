import 'dart:convert';
import 'dart:html';

import 'package:esports_crud/models/players.dart';
import 'package:esports_crud/screens/create_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final storage = const FlutterSecureStorage();

  List<Players> _listPlayers = [];

  @override
  initState() {
    super.initState();
    _getDataFromStorage();
  }

  _getDataFromStorage() async {
    String? data = await storage.read(key: 'list-players');
    if (data != null) {
      final dataDecoded = jsonDecode(data);
      if (dataDecoded is List) {
        setState(() {
          _listPlayers.clear();
          for (var item in dataDecoded) {
            _listPlayers.add(Players.fromJson(item));
          }
        });
      }
    }
  }

  _saveDataToStorage() async {
    final List<Object> _tmp = [];
    for (var item in _listPlayers) {
      _tmp.add(item.toJson());
    }

    await storage.write(
      key: 'list-players',
      value: jsonEncode(_tmp),
    );
  }

  _showPopupMenuItem(BuildContext context, int index) {
    final playersClicked = _listPlayers[index];

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('${playersClicked.tim} ${playersClicked.nickname}'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CreateEditScreen(
                    mode: FormMode.edit,
                    players: playersClicked,
                  ),
                ),
              );
              if (result is Players) {
                setState(() {
                  _listPlayers[index] = result;
                });
              }
            },
            child: const Text('Edit data pemain'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _listPlayers.removeAt(index);
              });
            },
            child: const Text('Hapus data pemain'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Esport Tracker'),
        trailing: GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    const CreateEditScreen(mode: FormMode.create),
              ),
            );
            if (result is Players) {
              setState(() {
                _listPlayers.add(result);
              });
            }
          },
          child: Icon(
            CupertinoIcons.add_circled_solid,
            size: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      child: SafeArea(
        child: ListView.separated(
          itemCount: _listPlayers.length,
          itemBuilder: (context, index) {
            final item = _listPlayers[index];
            return Container(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () => _showPopupMenuItem(context, index),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.tim} ${item.nickname} (${item.nama})'),
                    Text('${item.posisi} / ${item.tim} / ${item.liga}',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    Text('${item.umur} / ${item.negara_asal}',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
