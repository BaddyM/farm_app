import "package:farm_app/components/InputFields.dart";
import "package:farm_app/components/drawer.dart";
import "package:farm_app/components/farm_button.dart";
import "package:farm_app/models/database_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class FarmFlock extends StatefulWidget {
  const FarmFlock({super.key});

  @override
  State<FarmFlock> createState() => _FarmFlockState();
}

class _FarmFlockState extends State<FarmFlock> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final TextEditingController _editFlock = TextEditingController();
  final TextEditingController _editQty = TextEditingController();
  final TextEditingController _editDeaths = TextEditingController();
  final TextEditingController _addFlock = TextEditingController();
  final TextEditingController _addQty = TextEditingController();
  final TextEditingController _addDeaths = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(
        shadowColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Flock",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            showDialog(context: context,
                builder: (context){
              return AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                titleTextStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   const Text("Add flock data"),
                  IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close,color: Colors.red,))
                  ],
                ),
                content: SingleChildScrollView(
                child: Column(
                  children: [
                    FarmTextInput(controller: _addFlock, inputLabel: "Flock", keyboardType: TextInputType.number),
                    FarmTextInput(controller: _addQty, inputLabel: "Quantity", keyboardType: TextInputType.number),
                    FarmTextInput(controller: _addDeaths, inputLabel: "Deaths", keyboardType: TextInputType.number),
                  ],
                ),
              ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  GestureDetector(
                    onTap: (){
                      _databaseService.addChickenFlock(_addFlock.text, int.parse(_addQty.text),
                          int.parse(_addDeaths.text),);
                      setState(() {
                      });
                      Navigator.pop(context);
                    },
                    child: const FarmButton(buttonLabel: "Save"),
                  )
                ],
              );
                }
            );
          }),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: _databaseService.getFlockData(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return DataTable(
                        headingRowColor: MaterialStateProperty.all(Colors.green),
                        headingTextStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        columns: const [
                          DataColumn(label: Text("Date")),
                          DataColumn(label: Text("Flock")),
                          DataColumn(label: Text("Quantity")),
                          DataColumn(label: Text("Deaths")),
                          DataColumn(label: Text("Available")),
                          DataColumn(label: Text("Action")),
                        ],
                        rows: [
                          for(var data in snapshot.data!)
                          DataRow(cells: [
                            DataCell(Text("${data["date"]}")),
                            DataCell(Text("${data["flock"]}")),
                            DataCell(Text("${data["qty"]}")),
                            DataCell(Text("${data["deaths"]}")),
                            DataCell(Text("${_databaseService.formatAmount((data["available"] - data["deaths"]).toString())}")),
                            DataCell(
                              Row(children: [
                                IconButton(onPressed: (){
                                  //Edit the flock data
                                  _editFlock.text = data["flock"].toString();
                                  _editDeaths.text = data["deaths"].toString();
                                  _editQty.text = data["qty"].toString();
                                  showDialog(context: context,
                                      builder: (context){
                                    return AlertDialog(
                                      backgroundColor: Theme.of(context).primaryColor,
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text("Edit flock"),
                                          IconButton(onPressed: (){Navigator.of(context).pop();},
                                              icon: const Icon(Icons.close,color: Colors.red,))
                                        ],
                                      ),
                                      titleTextStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            FarmTextInput(controller: _editFlock, inputLabel: "Flock", keyboardType: TextInputType.number),
                                            FarmTextInput(controller: _editQty, inputLabel: "Quantity", keyboardType: TextInputType.number),
                                            FarmTextInput(controller: _editDeaths, inputLabel: "Deaths", keyboardType: TextInputType.number),
                                          ],
                                        ),
                                      ),
                                      actionsAlignment: MainAxisAlignment.center,
                                      actions: [
                                        GestureDetector(
                                          onTap: (){
                                            _databaseService.updateFlock(data["id"],int.parse(_editFlock.text),int.parse(_editQty.text),
                                                int.parse(_editDeaths.text)
                                            );
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: const FarmButton(buttonLabel: "Save"),
                                        )
                                      ],
                                    );
                                      }
                                  );
                                }, icon: const Icon(Icons.edit,color: Colors.yellow,)),
                                IconButton(onPressed: (){
                                  //Delete flock data
                                  showDialog(context: context,
                                      builder: (context){
                                      return AlertDialog(
                                        backgroundColor: Theme.of(context).primaryColor,
                                        contentTextStyle: const  TextStyle(color: Colors.white),
                                        content: const Text("Are you sure you want to delete?"),
                                      actionsAlignment: MainAxisAlignment.start,
                                      actions: [
                                        MaterialButton(
                                          color: Colors.red,
                                            child: const Text("Yes",style: TextStyle(color: Colors.white),),
                                            onPressed: (){
                                          //Accept delete
                                              _databaseService.deleteFlock(data["id"]);
                                              setState(() {
                                              });
                                              Navigator.pop(context);
                                        })
                                      ],);
                                      }
                                  );
                                }, icon: const Icon(Icons.close,color: Colors.red,)),
                              ],)
                            ),
                          ])
                        ]
                    );
                  }
                  return SizedBox();
                }
            ),
          ),
        ),
      ),
    );
  }
}
