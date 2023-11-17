String descricao(String componente) {
  Map<String, String> descricoes = {
    "engate_rapido":
        "Acessório que permite a ligação de uma mangueira pneumática com os demais componentes do sistema através de um encaixe rápido.",
    "valvula_solenoide": "É uma válvula operada por um impulso elétrico",
    "rosca":
        "Tipo de conexão para mangueira pneumática que utiliza o travamento com rosca para realizar a fixação."
  };

  return descricoes[componente]!;
}
