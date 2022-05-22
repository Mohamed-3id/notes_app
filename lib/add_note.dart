import 'package:flutter/material.dart';
import 'database.dart';

class AddPostScreen extends StatefulWidget {
  static final String routeName = '/add';

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  DatabaseHandler databaseHandler = new DatabaseHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title of Note',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.content_paste),
                ),
                maxLines: 15,
                minLines: 1,
              ),
              SizedBox(
                height: 30,
              ),
              Builder(builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: MaterialButton(
                    child: Text(
                      'Add',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () async {
                      String title = titleController.text;
                      String content = contentController.text;
                      Note note = new Note(null, title, content);
                      await databaseHandler.insert(note);

                      setState(() {
                        titleController.clear();
                        contentController.clear();
                      });

                      SnackBar snackBar = new SnackBar(
                        content:
                            Text('ID: ${note.id}  |  Title: ${note.title}'),
                        duration: Duration(milliseconds: 3300),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
