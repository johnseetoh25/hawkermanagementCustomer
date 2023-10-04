import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  TextEditingController controllerNOTable = new TextEditingController();
  TextEditingController controllerFoodID = new TextEditingController();
  TextEditingController controllerQuality = new TextEditingController();
  TextEditingController controllerSelection = new TextEditingController();

  getFoodData()async{
    var foodUrl = 'http://localhost/flutterhawkerdata/getfoods.php';
    var response = await http.get(Uri.parse(foodUrl));
    return json.decode(response.body);
  }

  addOrderData(){
    var orderUrl = "http://localhost/flutterhawkerdata/insertorders.php";
    http.post(Uri.parse(orderUrl), body: {
      'foodID': controllerFoodID.text,
      'quality': controllerQuality.text,
      'numberTable': controllerNOTable.text,
      'selection': controllerSelection.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome'),),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                // insert table number
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('NO. Table: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      SizedBox(width: 10.0,),
                      Flexible(
                        child: TextField(
                          controller: controllerNOTable,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //menus
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: FutureBuilder(
                    future: getFoodData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }

                      if(snapshot.hasError){
                        return Center(child: Text("Error fetching Data"),);
                      }

                      List snapData = snapshot.data;
                      return Container(
                        height: 350.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapData.length,
                          itemBuilder: (context, index){
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(10.0),
                                          color: Colors.blueAccent,
                                          height: 160.0, width: 280.0,
                                          child: Icon(Icons.photo, size: 100.0,)
                                      ),

                                      //menu information
                                      Container(
                                        margin:  EdgeInsets.all(10.0),
                                        width: 280.0,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text("${snapData[index]['foodName']}", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text("RM ${snapData[index]['price']}0", style: TextStyle(fontSize: 20.0),),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: Text("FoodID: ${snapData[index]['foodID']}", style: TextStyle(fontSize: 20.0),),
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                //insert foodID
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('Insert FoodID: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      SizedBox(width: 10.0,),
                      Flexible(
                        child: TextField(
                          controller: controllerFoodID,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //insert quality
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('Quantity:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      SizedBox(width: 60.0,),
                      Flexible(
                        child: TextField(
                          controller: controllerQuality,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15.0,),

                //selection Dine in or packing
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: 380.0,
                  color: Colors.orangeAccent,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: [
                            Text("1 - Dine In", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                            SizedBox(height: 5.0,),
                            Text("2 - Packing", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text('Selection:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                            SizedBox(width: 10.0,),
                            Flexible(
                              child: TextField(
                                controller: controllerSelection,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 20.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          padding: EdgeInsets.all(10.0),
          child: Text('Send Order', style: TextStyle(fontSize: 20.0),),
          color: Colors.blue,
          onPressed: (){
            addOrderData();
          },
        ),
      ),

    );

  }
}
