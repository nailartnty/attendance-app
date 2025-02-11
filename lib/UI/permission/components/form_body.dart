import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormBody extends StatelessWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final formController = TextEditingController();
    final toController = TextEditingController();
    String dropValueCategories = "Please Choose: ";
    var categoriesList = <String>[
      "Please Choose:",
      "Sick",
      "Permission",
      "Others",
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            textInputAction: TextInputAction.next, // pindah ke field berikutnya
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              labelText: "Your Name",
              labelStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              hintText: "Please enter your name here",
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blueGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blueAccent),
              )
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Text(
              "Description",
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blueAccent, 
                width: 1,
                style: BorderStyle.solid
              ),
            ),
            child: DropdownButton(
              dropdownColor: Colors.white,
              value: dropValueCategories, 
              onChanged: (value) {
                dropValueCategories = value.toString();
              },
              items: categoriesList.map((value) {
                return DropdownMenuItem( // default valuenya itu dia list makanya missmatch 
                  value: value.toString(),
                  child: Text(
                    value.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black
                    ),
                  ),
                );
                // method toList berfungi untuk memngkonversi sebuah data acak menjadi berurutan pada list
              }).toList(),
              icon: const Icon(Icons.arrow_drop_down_outlined),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
              underline: Container(
                height: 2,
                color: Colors.blueGrey,
              ),
              isExpanded: true, 
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker( // pake async karena krena kita mau pake showpicker dia pake future
                              context: context, 
                              initialDate: DateTime.now(), // inisial date 
                              firstDate: DateTime(2025),
                              lastDate: DateTime(2025)
                            );
                            if (pickedDate != null) {
                              formController.text = DateFormat('dd/mm/yy').format(pickedDate); // nentuin dari kapan sampe kapan
                              // format(pickedDate) untuk mengonversikan data detail tanggal yang di ambil dari piker date menjadi dd/mm/yy
                            }
                          },
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          ),
                          controller: formController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: "Starting from",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey
                            )
                          ),
                        )
                      )
                    ],
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        "Until: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                      Expanded(
                        child: TextField(
                        readOnly: true,
                        onTap: () async {
                          DateTime? pikedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2025),
                          );
                          if (pikedDate != null) {
                            toController.text = DateFormat('dd/mm/yy').format(pikedDate);
                          }
                        },
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                        ),
                        controller: toController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Until : ",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                          )
                        ),
                      )
                     )
                    ],
                  )
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}