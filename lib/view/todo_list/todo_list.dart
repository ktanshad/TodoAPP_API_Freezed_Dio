import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappapi/controller/todo_provider.dart';
import 'package:todoappapi/view/add_page/add_page.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Consumer<TodoProvider>(
        builder:(context,value,child){
          return    ListView.builder(
          itemCount: value.items.length,
          itemBuilder: (context,index){
            final todoModel=value.items[index];
            return ListTile(
              leading: Text('${index+1}'),
              title: Text(todoModel.title),
              subtitle: Text(todoModel.description),
              trailing: PopupMenuButton(
                onSelected: (value){
                  if(value=='edit'){
                    //open edit page
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPage(todoModel:todoModel)));
                  }else if(value=='delete'){
                    //delete and remove the item
                    Provider.of<TodoProvider>(context,listen: false).deleteById(todoModel.id!);
                  }
                },
                itemBuilder:(context){
                  return [
                  PopupMenuItem(
                    child:Text('Edit'),
                    value: 'edit',),
                    PopupMenuItem(
                      child:Text('delete'),
                      value: 'delete',)
                  ];
                }),
            );
          });
        } ,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>AddPage() ));
        },
        label: Text('ADD TODO'),
        ),
    );
  }
}