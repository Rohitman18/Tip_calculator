 // ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var _billAmount = 0.0;
  var _tippercentage = 0;
  var _personcounter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Tip Calculator",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(12.2),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(32.2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total per Person!",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "\$${CalulateTotalPerPerson(_billAmount, _tippercentage, _personcounter)}",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05),
              padding: const EdgeInsets.all(19.0),
              // width: 100,
              // height: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        prefix: Text(
                          "Bill Amount",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: Icon(Icons.attach_money_outlined)),
                    onChanged: (String val) {
                      try {
                        _billAmount = double.parse(val);
                        // ignore: empty_catches
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Split",
                          style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_personcounter > 1) {
                                    _personcounter--;
                                  } else {
                                    //  no changes
                                  }
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.all(10.0),
                                // padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.cyan.withOpacity(0.2)),
                                child: const Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "$_personcounter",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _personcounter++;
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.all(10.0),
                                // padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.cyan.withOpacity(0.2)),
                                child: const Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tip",
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "${CalculateTotalTip(_billAmount, _tippercentage, _personcounter)}",
                          style: const TextStyle(
                            color: Colors.cyan,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Slider
                  Column(
                    children: [
                      Text(
                        "$_tippercentage%",
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          // divisions: 10,
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey,
                          value: _tippercentage.toDouble(),
                          onChanged: (double val) {
                            setState(() {
                              _tippercentage = val.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
CalulateTotalPerPerson(double billAmount, int tipPercent, int splitBy) {
  double totalPerson =
      (CalculateTotalTip(billAmount, tipPercent, splitBy) + billAmount) /
          splitBy;
  return totalPerson.toStringAsFixed(2);
}

// ignore: non_constant_identifier_names
CalculateTotalTip(double billAmount, int tipPercent, int splitBy) {
  double totalTip = 0.0;
  if (billAmount < 1 || billAmount.toString().isEmpty || billAmount == null) {
//no changes
  } else {
    totalTip = (billAmount * tipPercent) / 100;
  }
  return totalTip;
}
