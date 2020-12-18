import 'package:flutter_app/model/Tasks.dart';
import 'package:flutter_app/repositories/repository.dart';

class TaskService{

  Repository _repository;

  TaskService(){
    _repository = Repository();
  }

  saveTask(Tasks tasks) async{
    return await _repository.isnertDatabase("tasks", tasks.taskMap());
  }

  ReadTask() async{
    return await _repository.readData("tasks");
  }

  readSelectedData(status) async{
    return await _repository.readSelectedData(status);
  }

  DeleteTask(String table,int id) async {
      return await _repository.deleteItem(table,id);
    }

  updateTask(int id,status) async {
    return await _repository.updateItem(id,status);
  }
}