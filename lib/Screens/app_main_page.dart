import 'package:flutter/material.dart';
import 'package:littlefont/Items/app_drawer.dart';
import 'package:littlefont/Screens/create_note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppMainPage extends StatefulWidget {
  const AppMainPage({Key? key}) : super(key: key);

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  String? mainText;

  List<String> _notlar = [];

  Future<void> _addNote() async {
    final yeniNot = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNote()),
    );

    setState(() {
      _notlar.add(yeniNot);
    });
  }

  Future<void> _deleteNotes(int index) async {
    setState(() {
      _notlar.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notlar = prefs.getStringList('notlar') ?? [];
    });
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notlar', _notlar);
  }

  @override
  void dispose() {
    _saveNotes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  const AppDrawer(),
      appBar: AppBar(
        title: const Text('Merhaba'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: _notlar.length,
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(_notlar[index]),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child:const Text('Kapat'),
                        ),
                      ],
                    );
                  },
                );
              },
              onLongPress: () => _deleteNotes(index),
              child: Center(
                child: Text(_notlar[index]),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}

