import 'package:flutter/material.dart';
import 'file:///D:/FlutterProject/To%20Do%20App/lib/ui/AddTask.dart';
import 'package:flutter_app/model/Tasks.dart';
import 'package:flutter_app/service/TaskService.dart';

import 'Splash.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("To Do App"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "All Task",
                ),
                Tab(
                  text: "Completed Task",
                ),
                Tab(
                  text: "InComplete Task",
                )
              ],
              isScrollable: true,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: TabBarView(
                      children: [AllTasks(), Completed(),InCompleted()])),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AddTask()));
            },
            elevation: 2,
            child: Icon(Icons.add),
          ),
        ));
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasks createState() => _AllTasks();
}

class _AllTasks extends State<AllTasks> {
  bool checkboxValue = false;

  var _taskService = TaskService();
  var _task = Tasks();
  List<Tasks> _tasklist =List<Tasks>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTasks();
  }

  getAllTasks() async {
    _tasklist = List<Tasks>();
    var tasks = await _taskService.ReadTask();
    tasks.forEach((task){
      setState(() {
        var taskModel =Tasks();
        taskModel.title=task["title"];
        taskModel.description=task["description"];
        taskModel.id=task["id"];
        taskModel.status=task["status"];
        print("status is ${task["status"]}");
        _tasklist.add(taskModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          reverse: false,
          itemCount: _tasklist.length,
          scrollDirection: Axis.vertical,
        itemBuilder: (context,index){
            checkboxValue= _task.getBool(_tasklist[index].status.toInt());
            return  buildCard(
            name: _tasklist[index].title,
            description: _tasklist[index].description,
      states: Checkbox(
      value: checkboxValue,
      onChanged: (bool val) {
      setState(() {
        if(_tasklist[index].status == 0){
          _taskService.updateTask(_tasklist[index].id,1);
          getAllTasks();
        }else{
          _taskService.updateTask(_tasklist[index].id,0);
          getAllTasks();
        }
      });
      }),taskService: _taskService,
              id: _tasklist[index].id,xx: _tasklist,index: index
      );
      },),
      ),
    );
  }
}

buildCard({name, description, states,taskService,id,index,List xx}) {
  return Padding(
    padding: EdgeInsets.only(top: 0.6, left: 4, right: 4),
    child: Card(
      elevation: 1.8,
      child: ListTile(
        leading: states,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  xx.removeAt(index);
                  taskService.DeleteTask("tasks", id);
                }),
          ],
        ),
        subtitle: Text(description),
      ),
    ),
  );
}



class InCompleted extends StatefulWidget {
  @override
  _InCompleted createState() => _InCompleted();
}

class _InCompleted extends  State<InCompleted> {

  bool checkboxValue = false;
  var _taskService = TaskService();
  var _task = Tasks();
  List<Tasks> _tasklist =List<Tasks>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTasks();
  }

  getAllTasks() async {
    _tasklist = List<Tasks>();
    var tasks = await _taskService.readSelectedData(0);
    tasks.forEach((task){
      setState(() {
        var taskModel =Tasks();
        taskModel.title=task["title"];
        taskModel.description=task["description"];
        taskModel.id=task["id"];
        taskModel.status=task["status"];
        print("status is ${task["status"]}");
        _tasklist.add(taskModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          reverse: false,
          itemCount: _tasklist.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
            checkboxValue= _task.getBool(_tasklist[index].status.toInt());
            return  buildCard(
                name: _tasklist[index].title,
                description: _tasklist[index].description,
                states: Checkbox(
                    value: checkboxValue,
                    onChanged: (bool val) {
                      setState(() {
                        if(_tasklist[index].status == 0){
                          _taskService.updateTask(_tasklist[index].id,1);
                          getAllTasks();
                        }else{
                          _taskService.updateTask(_tasklist[index].id,0);
                          getAllTasks();
                        }
                      });
                    }),taskService: _taskService,
                id: _tasklist[index].id,xx: _tasklist,index: index
            );
          },),
      ),
    );
  }
}





class Completed extends StatefulWidget {
  @override
  _Completed createState() => _Completed();
}


class _Completed extends State<Completed> {
  bool checkboxValue = false;
  var _taskService = TaskService();
  var _task = Tasks();
  List<Tasks> _tasklist =List<Tasks>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTasks();
  }

  getAllTasks() async {
    _tasklist = List<Tasks>();
    var tasks = await _taskService.readSelectedData(1);
    tasks.forEach((task){
      setState(() {
        var taskModel =Tasks();
        taskModel.title=task["title"];
        taskModel.description=task["description"];
        taskModel.id=task["id"];
        taskModel.status=task["status"];
        print("status is ${task["status"]}");
        _tasklist.add(taskModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          reverse: false,
          itemCount: _tasklist.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
            checkboxValue= _task.getBool(_tasklist[index].status.toInt());
            return  buildCard(
                name: _tasklist[index].title,
                description: _tasklist[index].description,
                states: Checkbox(
                    value: checkboxValue,
                    onChanged: (bool val) {
                      setState(() {
                        if(_tasklist[index].status == 0){
                          _taskService.updateTask(_tasklist[index].id,1);
                          getAllTasks();
                        }else{
                          _taskService.updateTask(_tasklist[index].id,0);
                          getAllTasks();
                        }
                      });
                    }),taskService: _taskService,
                id: _tasklist[index].id,xx: _tasklist,index: index
            );
          },),
      ),
    );
  }
}
