import 'package:flutter/material.dart';
import 'database.dart';
import 'edit_note.dart';

class ShowPostsScreen extends StatefulWidget {
  static final String routeName = '/show';

  @override
  State<ShowPostsScreen> createState() => _ShowRecordScreenState();
}

class _ShowRecordScreenState extends State<ShowPostsScreen> {
  DatabaseHandler databaseHelper = new DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Notes'),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: databaseHelper.getPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key('${snapshot.data[index].id}'),
                      onDismissed: (direction) async {
                        await databaseHelper.delete(snapshot.data[index].id);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          left: 14,
                          right: 14,
                          bottom: 8,
                        ),
                        child: Card(
                          elevation: 8,
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 23,
                                    left: 5,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.deepPurple,
                                    radius: 30,
                                    child: Text(
                                      '${snapshot.data[index].id}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: 260,
                                      child: Text(
                                        snapshot.data[index].title,
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 260,
                                      padding: EdgeInsets.only(top: 7),
                                      child: Text(
                                        snapshot.data[index].content,
                                        style: TextStyle(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditDataScreen(
                                    selected_Id: snapshot.data[index].id,
                                    selected_Title: snapshot.data[index].title,
                                    selected_Content:
                                        snapshot.data[index].content,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
