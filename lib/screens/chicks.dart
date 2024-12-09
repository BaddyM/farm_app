import "package:farm_app/components/InputFields.dart";
import "package:farm_app/components/farm_button.dart";
import "package:farm_app/models/database_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class FarmChicks extends StatefulWidget {
  const FarmChicks({super.key});

  @override
  State<FarmChicks> createState() => _FarmChicksState();
}

class _FarmChicksState extends State<FarmChicks> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final TextEditingController _company = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _deaths = TextEditingController();
  final TextEditingController _available = TextEditingController();
  final TextEditingController _addCompany = TextEditingController();
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
          "Chicks",
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
                title: FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Add new chicks stock"),
                      IconButton(onPressed: (){Navigator.of(context).pop();}, icon: const Icon(Icons.close,color: Colors.red,))
                    ],
                  ),
                ),
                titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FarmTextInput(controller: _addCompany, inputLabel: "Company", keyboardType: TextInputType.text),
                      FarmTextInput(controller: _addQty, inputLabel: "Quantity", keyboardType: TextInputType.number),
                      FarmTextInput(controller: _addDeaths, inputLabel: "Deaths", keyboardType: TextInputType.number),
                    ],
                  ),
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  GestureDetector(onTap: (){
                    _databaseService.addChicksData(_addCompany.text,int.parse(_addDeaths.text), int.parse(_addQty.text));
                    setState(() {});
                    Navigator.of(context).pop();
                    _addCompany.text =  "";
                    _addDeaths.text = "";
                    _addQty.text = "";
                  },child: const FarmButton(buttonLabel: "Save"))
                ],
              );
                }
            );
          }),
      body: FutureBuilder(
        future: _databaseService.getChicksData(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Container(
              height: double.maxFinite,
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: const TableBorder.symmetric(outside:BorderSide(
                        color: Colors.grey
                    )),
                      headingRowColor: WidgetStateProperty.all(Colors.green),
                      headingTextStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                      columns: const [
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Company")),
                        DataColumn(label: Text("Quantity")),
                        DataColumn(label: Text("Deaths")),
                        DataColumn(label: Text("Available")),
                        DataColumn(label: Text("In Brooder")),
                        DataColumn(label: Text("Action")),
                      ],
                      rows: [
                        for(var data in snapshot.data!)
                        DataRow(cells: [
                          DataCell(Text(data["date"])),
                          DataCell(Text(data["company"])),
                          DataCell(Container(alignment:Alignment.center,child: Text(data["qty"].toString()))),
                          DataCell(Container(alignment:Alignment.center,child: Text(data["deaths"].toString()))),
                          DataCell(Container(alignment:Alignment.center,child: Text(data["available"].toString()))),
                          DataCell(Container(alignment:Alignment.center,child: data["brooder"] == 1?const Badge(backgroundColor: Colors.green,label: Text("yes"),):const Badge(backgroundColor: Colors.red,label: Text("no"),))),
                          DataCell(Container(alignment:Alignment.center,
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){
                                    //Fetch the values
                                    _company.text = data["company"];
                                    _qty.text = data["qty"].toString();
                                    _deaths.text = data["deaths"].toString();
                                    _available.text = data["available"].toString();

                                    //Show the alert dialog
                                    showDialog(context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            scrollable: true,
                                            backgroundColor: Theme.of(context).primaryColor,
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text("Edit chicks data",style: TextStyle(color: Colors.white,fontSize: 20),),
                                                      IconButton(
                                                          onPressed: (){Navigator.of(context).pop();},
                                                          icon: const Icon(Icons.close,color: Colors.red,))
                                                    ],
                                                  ),
                                                ),
                                                FarmTextInput(controller: _company, inputLabel: "Company", keyboardType: TextInputType.text),
                                                FarmTextInput(controller: _qty, inputLabel: "Quantity", keyboardType: TextInputType.number),
                                                FarmTextInput(controller: _deaths, inputLabel: "Deaths", keyboardType: TextInputType.number),
                                                FarmTextInput(controller: _available, inputLabel: "Available", keyboardType: TextInputType.number),
                                              ],
                                            ),
                                            actionsAlignment: MainAxisAlignment.center,
                                            actions: [
                                              GestureDetector(
                                                onTap:(){
                                                  //Update the chicks data
                                                  var id = data["id"];
                                                  var company = _company.text;
                                                  var qty = _qty.text;
                                                  var deaths = _deaths.text;
                                                  var available = _available.text;
                                                  _databaseService.updateChicksData(company, int.parse(qty),
                                                      int.parse(deaths), int.parse(available), id);
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                },
                                                child: const FarmButton(buttonLabel: "Save"),
                                              )
                                            ],
                                          );
                                        }
                                    );
                                  }, icon: const Icon(Icons.edit,color: Colors.yellow,)),
                                  IconButton(
                                      onPressed: (){
                                        //Delete chicks record
                                        var id = data["id"];
                                        _databaseService.deleteChicksData(id);
                                        setState(() {

                                        });
                                  }, icon: const Icon(Icons.close,color: Colors.red,)),
                                ],
                              )
                          )),
                        ])
                      ]
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
