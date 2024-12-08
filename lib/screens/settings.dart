import "package:farm_app/components/InputFields.dart";
import "package:farm_app/components/drawer.dart";
import "package:farm_app/components/farm_button.dart";
import "package:farm_app/models/database_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class FarmSettings extends StatefulWidget {
  const FarmSettings({super.key});

  @override
  State<FarmSettings> createState() => _FarmSettingsState();
}

class _FarmSettingsState extends State<FarmSettings> {
  final TextEditingController _flockLabel = TextEditingController();
  final DatabaseService _databaseService = DatabaseService.instance;
  bool flockLabelVisible = false;
  bool transferBrooderVisible = false;
  bool transferContainerVisible = false;
  String selectedFlock = "";
  String currentQuantity = "";
  String flockid = "";

  Future<String> refreshScreen() async {
    setState(() {});
    return "";
  }

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
              context.go("/");
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshScreen,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          transferBrooderVisible = true;
                          flockLabelVisible = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Transfer from brooder",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          transferBrooderVisible = false;
                          flockLabelVisible = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Flock labels",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: transferBrooderVisible,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                                child: Column(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 0, 0.5),
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                255, 255, 0, 1),
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Chicken available in brooder \nHere, you can transfer all the chicken from brooder "
                                      "to the actual respective flock.",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                FutureBuilder(
                                    future:
                                        _databaseService.getActiveBrooderData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                              headingRowColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green),
                                              headingTextStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              columns: const [
                                                DataColumn(label: Text("Date")),
                                                DataColumn(
                                                    label: Text("Company")),
                                                DataColumn(
                                                    label: Text("Quantity")),
                                                DataColumn(
                                                    label: Text("Action")),
                                              ],
                                              rows: [
                                                for (var data in snapshot.data!)
                                                  DataRow(cells: [
                                                    DataCell(Text(
                                                        "${data["date"]}")),
                                                    DataCell(Text(
                                                        "${data["company"]}")),
                                                    DataCell(
                                                        Text("${data["qty"]}")),
                                                    DataCell(IconButton(
                                                      onPressed: () {
                                                        //Transfer from brooder to actual stock
                                                        setState(() {
                                                          transferContainerVisible =
                                                              true;
                                                          currentQuantity =
                                                              data["qty"]
                                                                  .toString();
                                                          flockid = data["id"]
                                                              .toString();
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .compare_arrows_sharp,
                                                        color: Colors.yellow,
                                                      ),
                                                    )),
                                                  ])
                                              ]),
                                        );
                                      }
                                      return const SizedBox();
                                    }),
                                Visibility(
                                  visible: transferContainerVisible,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Transfer to flock",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    transferContainerVisible =
                                                        false;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        ),
                                        const Divider(
                                          color: Colors.white,
                                        ),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              "Select Flock",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        FutureBuilder(
                                            future: _databaseService
                                                .getFlockLabels(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Container(
                                                  width: double.maxFinite,
                                                  child: Column(
                                                    children: [
                                                      for (var data
                                                          in snapshot.data!)
                                                        ListTile(
                                                          title: Text(
                                                            "Flock ${data["flock"]}",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          leading: Radio(
                                                              fillColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .white),
                                                              value:
                                                                  data["flock"],
                                                              groupValue:
                                                                  selectedFlock,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  selectedFlock =
                                                                      value
                                                                          .toString();
                                                                });
                                                              }),
                                                        ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            "Quantity",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          const Text(
                                                            "-",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            currentQuantity,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          )
                                                        ],
                                                      ),
                                                      const Divider(
                                                        color: Colors.white,
                                                      ),
                                                      Row(
                                                        children: [
                                                          MaterialButton(
                                                            color: Colors.green,
                                                            onPressed: () {
                                                              if (selectedFlock !=
                                                                  "") {
                                                                _databaseService.transferFromBrooder(
                                                                    int.parse(
                                                                        flockid),
                                                                    int.parse(
                                                                        currentQuantity),
                                                                    int.parse(
                                                                        selectedFlock));
                                                                setState(() {
                                                                  transferContainerVisible = false;
                                                                  transferBrooderVisible = false;
                                                                });
                                                              } else {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                    const SnackBar(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .black54,
                                                                        content:
                                                                            Text(
                                                                          "Please select a flock",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )));
                                                              }
                                                            },
                                                            child: const Text(
                                                              "Transfer",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                              return const SizedBox();
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )))
                      ],
                    ),
                  )),
              Visibility(
                visible: flockLabelVisible,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 0, 0.5),
                          border: Border.all(
                              color: const Color.fromRGBO(255, 255, 0, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(5.0)),
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                          "Add flock labels for each flock collection"),
                    ),
                    FarmTextInput(
                        controller: _flockLabel,
                        inputLabel: "Flock Label",
                        keyboardType: TextInputType.number),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (_flockLabel.text != "") {
                            _databaseService.addFlockLabels(_flockLabel.text);
                            setState(() {});
                            _flockLabel.text = "";
                          }
                        },
                        child: const FarmButton(buttonLabel: "Save")),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          "Current Flock Labels",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )),
                    FutureBuilder(
                        future: _databaseService.getFlockLabels(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: double.maxFinite,
                              child: DataTable(
                                  headingRowColor:
                                      MaterialStateProperty.all(Colors.green),
                                  columns: const [
                                    DataColumn(
                                        label: Text(
                                      "Flock",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Flock",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Action",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                  rows: [
                                    for (var data in snapshot.data!)
                                      DataRow(cells: [
                                        DataCell(Text("${data["flock"]}")),
                                        DataCell(Text(
                                            "${data["active"] == 1 ? "yes" : "no"}")),
                                        DataCell(Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  _databaseService
                                                      .updateFlockLabel(
                                                          data["id"]);
                                                  setState(() {});
                                                  context.pop();
                                                },
                                                icon: const Icon(
                                                  Icons.check,
                                                  color: Colors.yellow,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  _databaseService
                                                      .deleteFlockLabel(
                                                          data["id"]);
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        ))
                                      ])
                                  ]),
                            );
                          }
                          return const SizedBox();
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
