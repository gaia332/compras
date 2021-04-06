class Item {
  int id;
  String texto;
  double quantidade;
  // 0 - esgotado, 1-marcado, 2- desmarcado
  int estado;
  //
  int idOriginal;

  Item({this.id, this.texto, this.quantidade, this.estado = 2});
}
