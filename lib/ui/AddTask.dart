import 'package:flutter/material.dart';
import 'file:///D:/FlutterProject/To%20Do%20App/lib/ui/Home.dart';
import 'package:flutter_app/model/Tasks.dart';
import 'package:flutter_app/service/TaskService.dart';

class AddTask extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<AddTask> {
  String title = "title";
  String description = "123456";
  
  var _taskService = TaskService();
  var _task = Tasks();
  
  TextEditingController ftitle = TextEditingController();
  TextEditingController fdescription = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          title: Text("Add Task"),
         ),
      key: _key,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 8),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: buildTextFiedl(name: "Task Title",controller: ftitle,type: 1) ),
                                  SizedBox(
                                    height: 28,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: buildTextFiedl(name: "Task Notes",controller:fdescription,type: 6),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: () async{
                                  _task.title = ftitle.text;
                                  _task.description = fdescription.text;
                                  _task.status = 0;
                                  var result = await _taskService.saveTask(_task);
                                  print(result);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
                                  },
                                child: Container(
                                  width: 420,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.blue, Colors.blue]),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Add Task",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  buildTextFiedl({name,controller,type}) {
    return TextFormField(
      controller: controller,
      onSaved: (newValue) {
        if(name == "Task Title") {
          this.title = newValue;
        }else{
          this.description = newValue;
        }
      },
      maxLines: type,
      textAlign: TextAlign.center,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          filled: true,
          hintStyle: new TextStyle(color: Colors.grey[800]),
          hintText: name,
          labelText: name,
          fillColor: Color.fromRGBO(245, 245, 245, 100)),
    );
  }


}
