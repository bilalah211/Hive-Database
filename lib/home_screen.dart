import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedatabase/boxes/boxes.dart';
import 'package:hivedatabase/description_screen.dart';
import 'package:hivedatabase/models/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleC = TextEditingController();
  final desC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('H I V E   D A T A B A S E'),
          backgroundColor: Colors.green.withOpacity(0.3)),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: box.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DescriptionScreen(
                            title: data[index].title,
                            desc: data[index].description);
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        child: Card(
                          color: Colors.pink.shade50,
                          elevation: 0,
                          child: ListTile(
                            title: Text(
                              'Title: ${data[index].title}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Des: ${data[index].description}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      editMyDialog(
                                          data[index],
                                          data[index].title,
                                          data[index].description);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      delete(data[index]);
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade50,
        onPressed: () async {
          showMyDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    final data =
                        NotesModel(title: titleC.text, description: desC.text);
                    final box = Boxes.getData();
                    box.add(data);
                    data.save();
                    titleC.clear();
                    desC.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleC,
                  decoration: const InputDecoration(labelText: 'Add Title'),
                ),
                TextFormField(
                  controller: desC,
                  decoration:
                      const InputDecoration(labelText: 'Add Description'),
                ),
              ],
            ),
          );
        });
  }

  Future<void> editMyDialog(
      NotesModel notesModel, String title, String description) async {
    titleC.text = title;
    desC.text = description;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    notesModel.title = titleC.text.toString();
                    notesModel.description = desC.text.toString();
                    notesModel.save();
                    titleC.clear();
                    desC.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Update')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleC,
                  decoration: const InputDecoration(labelText: 'Edit Title'),
                ),
                TextFormField(
                  controller: desC,
                  decoration:
                      const InputDecoration(labelText: 'Edit Description'),
                ),
              ],
            ),
          );
        });
  }

  void delete(NotesModel notesModel) {
    notesModel.delete();
  }
}
