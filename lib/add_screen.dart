import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_add_api/model/AddModel.dart';
import 'package:http/http.dart' as http;



class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String calculation = "0";
  List<String> additionHistory = [];

  List<AddModel> addList = [];
  Future<List<AddModel>> getAddApi() async{
    final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));
    var data = jsonDecode(response.body.toString());
    print("Data : $data");
    if(response.statusCode == 200){
      for(Map<String, dynamic> i in data){
        addList.add(AddModel.fromJson(i));
      }
      return addList;
    }
    else{
      return addList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Two Number'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getAddApi(),
                  builder: (context ,  AsyncSnapshot<List<AddModel>>snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                             return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                          return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text("No Data Found"));}
                    else{
                            return ListView.builder(
                              itemCount: addList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(addList[index].q.toString()),
                                  subtitle: Text(addList[index].a.toString()),
                                );
                              },
                            );
                    }
                  }),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: num1Controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Number',
                hintText: 'Enter First Number',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: num2Controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Second Number',
                hintText: 'Enter Second Number',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                setState(() {
                  int num1 = int.parse(num1Controller.text);
                  int num2 = int.parse(num2Controller.text);
                  int sum = num1 + num2 ;
                  calculation = sum.toString();
                  additionHistory.add('$num1 + $num2 = $sum');
                });
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(child: Text("Addition",style: TextStyle(color: Colors.white),)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Result : $calculation',style: TextStyle(fontSize: 20),),
            SizedBox(height: 20),
            Text("History:",textAlign: TextAlign.start,style: TextStyle(fontSize: 15,)),
            Expanded(
              child: ListView.builder(
                itemCount: additionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(additionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
