import 'package:compras/models/item.model.dart';
import 'package:flutter/material.dart';
import 'package:compras/repositories/item.repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  List<Item> itens;

  final repository = ItemRepository();

  @override
  void initState() {
    super.initState();
    this.itens = repository.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFA500),
        automaticallyImplyLeading: false,
        title: Text(
          "Itens para comprar",
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: itens.length,
            itemBuilder: (_, indice) {
              var item = itens[indice];
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: estiloItem(item),
                    subtitle: Text('Quantidade: ' + item.quantidade.toString()),
                  ),
                ),
                actions: <Widget>[
                  (() {
                    if (item.estado == 2) {
                      return IconSlideAction(
                        caption: 'Marcar',
                        color: Colors.green,
                        icon: Icons.add_shopping_cart,
                        onTap: () {
                          confirmarAdicao(context, item, itens);
                        },
                      );
                    } else {
                      return IconSlideAction(
                        caption: 'Desmarcar',
                        color: Colors.red,
                        icon: Icons.remove_shopping_cart,
                        onTap: () => desmarcarItem(item),
                      );
                    }
                  }()),
                  (() {
                    if (item.estado == 0) {
                      return IconSlideAction(
                        caption: 'Retornar',
                        color: Colors.green,
                        icon: Icons.shopping_cart,
                        onTap: () {
                          setState(() {
                            item.estado = 2;
                          });
                          atualizaLista();
                        },
                      );
                    } else {
                      return IconSlideAction(
                        caption: 'Esgotado',
                        color: Colors.red,
                        icon: Icons.remove_circle,
                        onTap: () {
                          setState(() {
                            item.estado = 0;
                          });
                          atualizaLista();
                        },
                      );
                    }
                  }()),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Editar',
                    color: Colors.blue,
                    icon: Icons.edit,
                    onTap: () {
                      editaItem(context, item);
                    },
                  ),
                  IconSlideAction(
                    caption: 'Exluir',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      confirmarExclusao(context, item);
                    },
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () => adicionarItem(context),
      ),
    );
  }

  Row estiloItem(Item item) {
    switch (item.estado) {
      case 0:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.texto,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Icon(
              Icons.remove_circle,
              color: Colors.red,
            ),
          ],
        );
        break;
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.texto,
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.green,
              ),
            ),
            Icon(
              Icons.check,
              color: Colors.green,
            )
          ],
        );
        break;
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.texto,
            ),
            Icon(Icons.shopping_cart_outlined)
          ],
        );
        break;
    }
    return Row();
  }

  Future adicionarItem(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/novoItem');
    if (result == true) {
      atualizaLista();
    }
  }

  Future editaItem(BuildContext context, item) async {
    var result =
        await Navigator.of(context).pushNamed('/editaItem', arguments: item);
    if (result == true) {
      atualizaLista();
    }
  }

  Future atualizaLista() async {
    return setState(() {
      this.itens = repository.read();
    });
  }

  Future confirmarExclusao(BuildContext context, item) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("Confirma a exclusão?"),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Não"),
              ),
              ElevatedButton(
                onPressed: () {
                  repository.delete(item.id);
                  Navigator.of(context).pop();
                  atualizaLista();
                },
                child: Text("Sim"),
              ),
            ],
          );
        });
  }

  Future confirmarAdicao(BuildContext context, item, repository) async {
    final _formKey = GlobalKey<FormState>();
    final _item = Item();
    final _repository = ItemRepository();

    onSave(BuildContext context, Item item) {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        _item.texto = item.texto;

        if (_item.quantidade == item.quantidade) {
          _item.id = item.id;
          item.estado = 1;
          _repository.update(item, item);
          Navigator.of(context).pop();
        } else {
          _item.id = repository.length;
          _item.idOriginal = item.id;
          _item.estado = 1;
          item.quantidade -= _item.quantidade;
          item.quantidade = double.parse((item.quantidade).toStringAsFixed(4));
          _repository.update(item, item);
          _repository.create(_item);
          Navigator.of(context).pop();
        }
      }
    }

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("Quantidade de itens comprados"),
            content: Container(
              height: 70,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Quantidade (Unidade ou peso)",
                        contentPadding: new EdgeInsets.fromLTRB(1, 1, 1, 1),
                      ),
                      onSaved: (value) =>
                          _item.quantidade = double.parse(value),
                      keyboardType: TextInputType.numberWithOptions(),
                      initialValue: item.quantidade.toString(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo obrigatório";
                        } else {
                          if (double.tryParse(value) == null) {
                            return "Digite um número";
                          } else {
                            if (double.tryParse(value) > item.quantidade) {
                              return "O número inserido é maior que o registrado";
                            } else {
                              return null;
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancelar Ação"),
              ),
              ElevatedButton(
                onPressed: () {
                  onSave(context, item);
                  atualizaLista();
                },
                child: Text("Marcar"),
              ),
            ],
          );
        });
  }

  Future desmarcarItem(Item item) async {
    if (item.idOriginal == null) {
      setState(() {
        item.estado = 2;
      });
    } else {
      final _repository = ItemRepository();
      Item itemEspecifico;

      itemEspecifico = itens.singleWhere((t) => t.id == item.idOriginal);
      _repository.desmarcarUnindo(itemEspecifico, item);
      _repository.delete(item.id);
    }
    atualizaLista();
  }
}
