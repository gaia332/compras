import 'package:compras/models/item.model.dart';

class ItemRepository {
  static List<Item> itens = [];

  void create(Item item) {
    itens.add(item);
  }

  List<Item> read() {
    List<Item> itensOrganizados = [];
    if (itens != null) {
      for (var i = 0; i < itens.length; i++) {
        if (itens[i].estado == 2) {
          itensOrganizados.insert(0, itens[i]);
        } else {
          itensOrganizados.add(itens[i]);
        }
      }
    }
    return itensOrganizados;
  }

  void delete(int id) {
    final item = itens.singleWhere((t) => t.id == id);
    itens.remove(item);
  }

  void update(Item newItem, Item oldItem) {
    final item = itens.singleWhere((t) => t.id == oldItem.id);
    item.texto = newItem.texto;
    item.quantidade = newItem.quantidade;
  }

  void desmarcarUnindo(Item newItem, Item oldItem) {
    final item = itens.singleWhere((t) => t.id == oldItem.idOriginal);
    item.texto = newItem.texto;
    item.quantidade += oldItem.quantidade;
  }
}
