String descricao(String componente) {
  Map<String, String> descricoes = {
    "engate_rapido":
        "Acessório que permite a ligação de uma mangueira pneumática com os demais componentes do sistema através de um encaixe rápido.",
    "valvula_solenoide": "É uma válvula operada por um impulso elétrico",
    "rosca":
        "Tipo de conexão para mangueira pneumática que utiliza o travamento com rosca para realizar a fixação.",
    "regulador_de_pressao":
        "Componente responsável por regular a pressão do ar comprimido. Comumente possui um manômetro acoplado.",
    "valvula_esfera":
        "Válvula usada para controlar o fluxo do ar comprimido.",
    "atuador":
        "O atuador pneumático, também chamado de cilindro pneumático, é o componente que executa um movimento por meio do uso de ar comprimido."
  };

  return descricoes[componente]!;
}
