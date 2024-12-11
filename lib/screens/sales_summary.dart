import 'package:farm_app/components/InputFields.dart';
import 'package:farm_app/models/database_service.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class FarmSalesSummary extends StatefulWidget {
  const FarmSalesSummary({super.key});

  @override
  State<FarmSalesSummary> createState() => _FarmSalesSummaryState();
}

class _FarmSalesSummaryState extends State<FarmSalesSummary> {
  DatabaseService _databaseService = DatabaseService.instance;
  String creditPersonName = "";
  bool creditContainer = false;
  TextEditingController _creditAmount = TextEditingController();
  TextEditingController _salesID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0,
        leading: IconButton(
            onPressed: () {
              context.go("/");
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Sales Summary",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                width: double.maxFinite,
                margin: const EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255,255,0,0.7),
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: const Color.fromRGBO(255,255,0,1))
                ),
                child: const Text("All sales will be displayed here.\n"
                    "+ is for paying pending fees"),
              ),
              Visibility(
                visible: creditContainer,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.centerLeft,
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pay Credit for ${creditPersonName}",style:
                        TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                        Divider(color: Colors.white,),
                        FarmTextInput(controller: _creditAmount, inputLabel: "Enter Amount to pay", keyboardType: TextInputType.number,),
                        FarmTextInput(controller: _salesID, inputLabel: "id", keyboardType: TextInputType.number,readOnly: true,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(onPressed: (){
                              if(_creditAmount.text != ""){
                                _databaseService.payCredit(int.parse(_salesID.text),
                                    int.parse(_creditAmount.text)).then((response){
                                    setState(() {
                                      creditContainer = false;
                                      creditPersonName = "";
                                      _creditAmount.text = "";
                                      _salesID.text = "";
                                    });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(response,style: TextStyle(color: Colors.white),)
                                          ,backgroundColor: Colors.black87,)
                                      );
                                });
                              }
                            },color: Colors.green,
                            child: Text("Save",style: TextStyle(color: Colors.white),),),
                            MaterialButton(onPressed: (){
                              setState(() {
                                creditContainer = false;
                                creditPersonName = "";
                              });
                            },color: Colors.red,
                              child: Text("Close",style: TextStyle(color: Colors.white),),)
                          ],
                        )
                      ],
                    ),
              )),
              FutureBuilder(
                  future: _databaseService.allSales(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int dataLength = snapshot.data!.length;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          dataRowColor:
                          MaterialStateProperty.all(Colors.grey[300]),
                          headingTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          columns: [
                            DataColumn(label: Text("Customer Name")),
                            DataColumn(label: Text("Flock")),
                            DataColumn(label: Text("Quantity")),
                            DataColumn(label: Text("Decimal")),
                            DataColumn(label: Text("Weight (Kgs)")),
                            DataColumn(label: Text("Price (UGX)")),
                            DataColumn(label: Text("Amount (UGX)")),
                            DataColumn(label: Text("Paid (UGX)")),
                            DataColumn(label: Text("Balance (UGX)")),
                            DataColumn(label: Text("On Credit (UGX)")),
                            DataColumn(label: Text("Sold On")),
                            DataColumn(label: Container(alignment: Alignment.center,width: 100,child: Text("Action"))),
                          ],
                          rows: [
                            if (snapshot.data!.length > 0)
                              for (int i = 0; i < dataLength; i++)
                                DataRow(cells: [
                                  DataCell(Text(
                                      "${snapshot.data![i]["customer_name"]}")),
                                  DataCell(
                                      Text("${snapshot.data![i]["flock"]}")),
                                  DataCell(Text("${snapshot.data![i]["qty"]}")),
                                  DataCell(Text("${snapshot.data![i]["decimal_value"]}")),
                                  DataCell(
                                      Text("${snapshot.data![i]["weight"]}")),
                                  DataCell(Text(
                                      "${_databaseService.formatAmount((snapshot.data![i]["price"]).toString())}")),
                                  DataCell(Text(
                                      "${_databaseService.formatAmount(((snapshot.data![i]["decimal_value"] * snapshot.data![i]["weight"] * snapshot.data![i]["price"]).toString()).replaceAll(".0", ""))}")),
                                  DataCell(Text(
                                      "${_databaseService.formatAmount((snapshot.data![i]["paid"]).toString())}")),
                                  DataCell(Text(
                                      "${_databaseService.formatAmount(
                                          ((snapshot.data![i]["decimal_value"] *
                                              snapshot.data![i]["weight"] *
                                              snapshot.data![i]["price"]) -
                                              (snapshot.data![i]["paid"])).toString().replaceAll(".0", "")
                                      )}")),
                                  DataCell(Container(
                                      alignment: Alignment.center,
                                      child: snapshot.data![i]["on_credit"] == 1
                                          ? Badge(
                                          backgroundColor: Colors.red,
                                          label: Text("yes"))
                                          : Badge(
                                        backgroundColor: Colors.green,
                                        label: Text("no"),
                                      ))),
                                  DataCell(Text("${snapshot.data![i]["date"]}")),
                                  DataCell(Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        //Print Data
                                      },icon: Icon(Icons.print),),
                                      Builder(builder: (context){
                                        var balance = ((snapshot.data![i]["decimal_value"] *
                                            snapshot.data![i]["weight"] *
                                            snapshot.data![i]["price"]) -
                                            (snapshot.data![i]["paid"])).toString().replaceAll(".0", "");
                                        if(balance != "0"){
                                          return IconButton(onPressed: (){
                                            _salesID.text = snapshot.data![i]["id"].toString();
                                            setState(() {
                                              creditContainer = true;
                                              creditPersonName = snapshot.data![i]["customer_name"];
                                            });
                                          },icon: HugeIcon(icon: HugeIcons.strokeRoundedAddCircle, color: Colors.green),);
                                        }
                                        return SizedBox();
                                      }),
                                    ],
                                  )),
                                ])
                          ],
                        ),
                      );
                    }
                    return Container(
                      child: const Text(
                        "There are no recent transactions",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
