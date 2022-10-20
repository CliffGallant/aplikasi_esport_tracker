import 'package:esports_crud/models/players.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum FormMode { create, edit }

class CreateEditScreen extends StatefulWidget {
  const CreateEditScreen({super.key, required this.mode, this.players});

  final FormMode mode;
  final Players? players;

  @override
  State<CreateEditScreen> createState() => _CreateEditScreenState();
}

class _CreateEditScreenState extends State<CreateEditScreen> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController posisiController = TextEditingController();
  TextEditingController timController = TextEditingController();
  TextEditingController ligaController = TextEditingController();
  TextEditingController negara_asalController = TextEditingController();
  TextEditingController umurController = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.mode == FormMode.edit) {
      nicknameController.text = widget.players!.nickname;
      namaController.text = widget.players!.nama;
      posisiController.text = widget.players!.posisi;
      timController.text = widget.players!.tim;
      ligaController.text = widget.players!.liga;
      negara_asalController.text = widget.players!.negara_asal;
      umurController.text = widget.players!.umur;
    }
  }

  getPlayer() {
    return Players(
        nickname: nicknameController.text,
        nama: namaController.text,
        posisi: posisiController.text,
        tim: timController.text,
        liga: ligaController.text,
        negara_asal: negara_asalController.text,
        umur: umurController.text);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Esport Tracker'),
        trailing: GestureDetector(
            onTap: () {
              Navigator.pop(context, getPlayer());
            },
            child: Text(widget.mode == FormMode.create ? 'Tambah' : 'Simpan')),
        backgroundColor: Colors.red,
      ),
      child: SafeArea(
        child: CupertinoFormSection(
          header: Center(
              child: Text(widget.mode == FormMode.create
                  ? 'Tambah Data Pemain'
                  : 'Edit Data Pemain')),
          children: [
            CupertinoFormRow(
              prefix: Text("Nickname"),
              child: CupertinoTextFormFieldRow(
                controller: nicknameController,
                placeholder: 'Masukkan nickname',
              ),
            ),
            CupertinoFormRow(
              prefix: Text("Nama"),
              child: CupertinoTextFormFieldRow(
                controller: namaController,
                placeholder: 'Masukkan nama',
              ),
            ),
            CupertinoFormRow(
              prefix: Text("Posisi"),
              child: CupertinoTextFormFieldRow(
                controller: posisiController,
                placeholder: 'Masukkan posisi',
              ),
            ),
            CupertinoFormRow(
              prefix: Text("Tim"),
              child: CupertinoTextFormFieldRow(
                controller: timController,
                placeholder: 'Masukkan tim',
              ),
            ),
            CupertinoFormRow(
              prefix: Text("Liga"),
              child: CupertinoTextFormFieldRow(
                controller: ligaController,
                placeholder: 'Masukkan liga',
              ),
            ),
            CupertinoFormRow(
              prefix: Text("Negara Asal"),
              child: CupertinoTextFormFieldRow(
                controller: negara_asalController,
                placeholder: 'Masukkan negara asal',
              ),
            ),
            CupertinoFormRow(
              prefix: Text("Umur"),
              child: CupertinoTextFormFieldRow(
                controller: umurController,
                placeholder: 'Masukkan umur',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
