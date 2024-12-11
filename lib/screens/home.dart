import "package:farm_app/components/InputFields.dart";
import "package:farm_app/components/appbar.dart";
import "package:farm_app/components/drawer.dart";
import "package:farm_app/components/farm_cards.dart";
import "package:farm_app/models/database_service.dart";
import "package:flutter/material.dart";

class FarmHome extends StatefulWidget {
  const FarmHome({super.key, this.title, this.version});
  final title;
  final version;

  @override
  State<FarmHome> createState() => _FarmHomeState();
}

class _FarmHomeState extends State<FarmHome> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final TextEditingController _flock = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _decimalValue = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _customerName = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _paid = TextEditingController();
  int _creditVal = 0;
  bool? onCredit = false;
  bool saleActive = false;
  String? selectFlock = "";

  Future<void> refreshData() async{
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            _flock.text = "$selectFlock";
            setState(() {
              saleActive = true;
            });
          }),
      appBar: FarmAppBar(
        title: widget.title,
      ),
      drawer: FarmDrawer(
        title: widget.title,
        version: widget.version,
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
        onRefresh: refreshData,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: _databaseService.getHomeSummaryData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var listCounter = snapshot.data?.length;
                        List<String> labels = [
                          "today_sales",
                          "available",
                          "brooder_counter",
                          "flock"
                        ];

                        List<String> cardLabels = [
                          "Today's Sales",
                          "Total Chicken",
                          "In Brooder",
                          "Active Flock"
                        ];

                        return ListView.builder(
                            itemCount: listCounter,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var values = snapshot.data?[index]["${labels[index]}"];
                              if(index == 3){
                                selectFlock = values;
                              }
                              return Container(
                                  margin: const EdgeInsets.only(bottom: 8.0),
                                  child: FarmCard(
                                    cardLabel: "${cardLabels[index]}",
                                    cardValue:
                                        "${index == 0?"UGX":""} ${values == null ? 0 : _databaseService.formatAmount(values.toString())}",
                                  ));
                            });
                      }
                      return const SizedBox();
                    }),
                Visibility(
                  visible: saleActive,
                  child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: const Text(
                        "Make Sales",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      )),
                ),
                Visibility(
                    visible: saleActive,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FarmTextInput(readOnly: true,controller: _flock, inputLabel: "Flock", keyboardType: TextInputType.number),
                          FarmTextInput(
                              controller: _weight,
                              inputLabel: "Weight",
                              keyboardType: TextInputType.number),
                          FarmTextInput(
                              controller: _decimalValue,
                              inputLabel: "Decimal Value",
                              keyboardType: TextInputType.number),
                          FarmTextInput(
                              controller: _qty,
                              inputLabel: "Quantity",
                              keyboardType: TextInputType.number),
                          FarmTextInput(
                              controller: _price,
                              inputLabel: "Price",
                              keyboardType: TextInputType.number),
                          FarmTextInput(
                              controller: _paid,
                              inputLabel: "Paid",
                              keyboardType: TextInputType.number),
                          FarmTextInput(
                              controller: _customerName,
                              inputLabel: "Customer Name",
                              keyboardType: TextInputType.text),
                          Container(
                            child: Row(
                              children: [
                                Checkbox(
                                    activeColor: Colors.green,
                                    side: const BorderSide(
                                        color: Colors.white, width: 2),
                                    value: onCredit,
                                    onChanged: (value) {
                                      if (value == true) {
                                        setState(() {
                                          _creditVal = 1;
                                        });
                                      } else {
                                        setState(() {
                                          _creditVal = 0;
                                        });
                                      }
                                      setState(() {
                                        onCredit = value;
                                      });
                                    }),
                                const Text(
                                  "On Credit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    String flock = _flock.text;
                                    String weight = _weight.text;
                                    String decimalValue = _decimalValue.text;
                                    String qty = _qty.text;
                                    String price = _price.text;
                                    String customerName = _customerName.text;
                                    String paid = _paid.text;
                                    String date = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

                                    if (flock.length > 0 &&
                                        weight.length > 0 &&
                                        decimalValue.length > 0 &&
                                        qty.length > 0 &&
                                        price.length > 0 &&
                                        paid.length > 0) {
                                      //Add new sales data
                                      _databaseService.addSalesData(
                                          flock,
                                          int.parse(qty),
                                          double.parse(weight),
                                          double.parse(decimalValue),
                                          int.parse(price),
                                          _creditVal,
                                          int.parse(paid),
                                          customerName,
                                          date).then((response){
                                            setState(() {
                                              saleActive = false;
                                              onCredit = false;
                                            });
                                            //Clear the inputs
                                            _customerName.text = "";
                                            _creditVal = 0;
                                            _decimalValue.text = "";
                                            _weight.text = "";
                                            _flock.text = "";
                                            _price.text = "";
                                            _paid.text = "";
                                            _qty.text = "";
                                            _flock.text = "";

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(response,style: const TextStyle(color: Colors.white),),
                                                backgroundColor: Colors.black87,)
                                            );
                                      });
                                    } else {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return BottomSheet(
                                                onClosing: () {},
                                                backgroundColor: Colors.white,
                                                builder: (context) {
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    width: double.maxFinite,
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.2,
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05),
                                                    decoration:
                                                        const BoxDecoration(),
                                                    child: const Text(
                                                      "All fields must be filled",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  );
                                                });
                                          });
                                    }
                                  },
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                MaterialButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    //Clear the inputs
                                    _customerName.text = "";
                                    _creditVal = 0;
                                    _decimalValue.text = "";
                                    _weight.text = "";
                                    _flock.text = "";
                                    _price.text = "";
                                    _paid.text = "";
                                    _qty.text = "";
                                    _flock.text = "";

                                    setState(() {
                                      saleActive = false;
                                      onCredit = false;
                                    });
                                  },
                                  child: const Text(
                                    "Close",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Recent Transactions",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                    future: _databaseService.recentTransactions(),
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
                            columns: const [
                              DataColumn(label: Text("Customer Name")),
                              DataColumn(label: Text("Flock")),
                              DataColumn(label: Text("Quantity")),
                              DataColumn(label: Text("Weight (Kgs)")),
                              DataColumn(label: Text("Price (UGX)")),
                              DataColumn(label: Text("Amount (UGX)")),
                              DataColumn(label: Text("Paid (UGX)")),
                              DataColumn(label: Text("Balance (UGX)")),
                              DataColumn(label: Text("On Credit (UGX)")),
                              DataColumn(label: Text("Date")),
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
                                    DataCell(
                                        Text("${snapshot.data![i]["weight"]}")),
                                    DataCell(Text(
                                        "${_databaseService.formatAmount((snapshot.data![i]["price"]).toString())}")),
                                    DataCell(Text(
                                        "${_databaseService.formatAmount(((snapshot.data![i]["decimal_value"] * snapshot.data![i]["weight"] * snapshot.data![i]["price"]).toString()).replaceAll(".0", ""))}")),
                                    DataCell(Text(
                                        "${_databaseService.formatAmount((snapshot.data![i]["paid"]).toString())}")),
                                    DataCell(Text(
                                        "${_databaseService.formatAmount(((snapshot.data![i]["decimal_value"] * snapshot.data![i]["weight"] * snapshot.data![i]["price"]) - (snapshot.data![i]["paid"])).toString().replaceAll(".0", ""))}")),
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
                                    DataCell(
                                        Text("${snapshot.data![i]["date"]}")),
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
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
