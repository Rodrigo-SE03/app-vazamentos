import 'package:objectbox/objectbox.dart';

@Entity()
class Dados {
  int id = 0;
  int tag = 0;
  String local = "";
  String componente = "";
  String obs = "";
  String classificacao = "";
  String data = "";
  String qtd = "";
  String fotoPath = "";

  Dados(
      {required this.classificacao,
      required this.componente,
      required this.data,
      required this.tag,
      required this.local,
      required this.obs,
      required this.qtd,
      required this.fotoPath});
}
