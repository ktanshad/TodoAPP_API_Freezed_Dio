import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todoappapi/model/todo_model.dart';

class TodoServices{
  final Dio _dio=Dio();
  Future<List<TodoModel>> fetchTodo()async{
    const url='https://api.nstack.in/v1/todos?page=1&limit=10';
    final response= await _dio.get(url);
    if(response.statusCode==200){
      final json=response.data as Map<String,dynamic>;
      final result =json['items'] as List;
      return result.map((json) => TodoModel.fromJson(json)).toList();
      
    } else{
      throw Exception('Filed to fetch todo');
    }
  }


   Future<void> SubmitData(TodoModel requestModel) async {

      final body =requestModel.toJson();

    //submit data for the server
    const url = "https://api.nstack.in/v1/todos";
    final response = await _dio.post(url,
        data: jsonEncode(body),
        options:Options (headers: {'Content-Type': 'application/json'}),
         );
    //show success or not messege based on status
    if (response.statusCode == 201) {
      print('creation success');
    } else {
      print('creation failed');
    }
  }

  Future<void> deleteById(String id)async{
  final url='https://api.nstack.in/v1/todos/$id';
  
   final response=await _dio.delete(url);
   if(response.statusCode==200){
    print('delete success');
   }else{
   //error
   print('error');
   }
  }


    Future<void> updateData( requestModel,id)async{
        final body=requestModel.toJson();

       //update data for the server
    final url = "https://api.nstack.in/v1/todos/$id";
    final response = await _dio.put(url,
        data: jsonEncode(body),
        options: Options(
         headers: {'Content-Type': 'application/json'}
        ),
     );
    //show success or not messege based on status
    if (response.statusCode == 200) {
      print('Updation success');
    } else {
      print('Updation failed with status code: ${response.statusCode}');
    print('Response body: ${response.data}');
  print('Error Response Body: ${response.data}');
  throw Exception('Update failed');
    }
  }

}