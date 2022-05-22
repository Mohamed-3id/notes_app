import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:section_app/home_page.dart';
import 'database.dart';

class EditDataScreen extends StatefulWidget {
  static final String routeName = '/edit';

  final int selected_Id;
  final String selected_Title;
  final String selected_Content;
  const EditDataScreen({
    Key key,
    this.selected_Id,
    this.selected_Title,
    this.selected_Content,
  }) : super(key: key);

  @override
  State<EditDataScreen> createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  DatabaseHandler databaseHandler = new DatabaseHandler();

  TextEditingController edit_titleController = TextEditingController();
  TextEditingController edit_contentController = TextEditingController();

  @override
  void initState() {
    edit_titleController.text = widget.selected_Title;
    edit_contentController.text = widget.selected_Content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        leading: IconButton(
          icon: Icon(Icons.reset_tv),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, MyHomePage.routeName, (route) => false);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: edit_titleController,
                decoration: InputDecoration(
                  labelText: 'Edit the Note title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: edit_contentController,
                decoration: InputDecoration(
                  labelText: 'Edit the Note Content',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit_road_outlined),
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
                      'Edit',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      String title = edit_titleController.text;
                      String content = edit_contentController.text;
                      Note note = new Note(widget.selected_Id, title, content);
                      await databaseHandler.update(note);
                      SnackBar snackBar = new SnackBar(
                        content: Text('This Note is Updated'),
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
