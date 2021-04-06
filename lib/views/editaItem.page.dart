import 'package:flutter/material.dart';
import 'package:compras/models/item.model.dart';
import 'package:compras/repositories/item.repository.dart';

class EditaItemPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = Item();
  final _repository = ItemRepository();

  onSave(BuildContext context, Item item) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _item.id = item.id;
      _repository.update(_item, item);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Item item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFA500),
        title: Text(
          "Novo Item",
        ),
        centerTitle: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nome do item",
                  contentPadding: new EdgeInsets.fromLTRB(1, 1, 1, 1),
                ),
                initialValue: item.texto,
                onSaved: (value) => _item.texto = value,
                validator: (value) =>
                    value.isEmpty ? "Campo obrigatório" : null,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Quantidade do item (Unidade ou peso)",
                    contentPadding: new EdgeInsets.fromLTRB(1, 1, 1, 1)),
                onSaved: (value) => _item.quantidade = double.parse(value) ?? 0,
                keyboardType: TextInputType.numberWithOptions(),
                initialValue: item.quantidade.toString(),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Campo obrigatório";
                  } else {
                    if (double.tryParse(value) == null) {
                      return "Digite um número";
                    } else {
                      return null;
                    }
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => onSave(context, item),
                  child: Text(
                    "Salvar Item",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffffd500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
