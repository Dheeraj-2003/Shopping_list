import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoppinglist/data/categories_data.dart';
import 'package:shoppinglist/data/dummy_items.dart';
import 'package:shoppinglist/models/category.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  int _enteredQuantity = 1;
  var _selectedCat = categories[Categories.vegetables]!;
  var _isSending = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https('shoppinglist-45622-default-rtdb.firebaseio.com',
          'shopping-list.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'title': _enteredName,
            'quantity': _enteredQuantity,
            'category': _selectedCat.title,
          },
        ),
      );

      final Map<String, dynamic> res = json.decode(response.body);

      if (!context.mounted) return;

      Navigator.of(context).pop(GroceryItem(
          id: res['name'],
          title: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCat));

      // (
      //   GroceryItem(
      //       id: DateTime.now().toString(),
      //       title: _enteredName,
      //       quantity: _enteredQuantity,
      //       category: _selectedCat),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                        ),
                        initialValue: _enteredQuantity.toString(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Enter a valid positve number';
                          }

                          return null;
                        },
                        onSaved: (val) {
                          _enteredQuantity = int.parse(val!);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                          value: _selectedCat,
                          items: [
                            for (final cat in categories.entries)
                              DropdownMenuItem(
                                  value: cat.value,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        color: cat.value.color,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(cat.value.title),
                                    ],
                                  ))
                          ],
                          onChanged: (val) {
                            setState(() {
                              _selectedCat = val as Category;
                            });
                          }),
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _isSending
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: const Text('Reset')),
                    ElevatedButton(
                        onPressed: _isSending ? null : _saveItem,
                        child: _isSending
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Add Item'))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
