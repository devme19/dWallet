class TransactionModel {
  String? date, txId, symbol;

  double? amount;
  bool? isSend;
  TransactionModel(
      {required this.date,
      required this.txId,
      required this.isSend,
      required this.amount,
      required this.symbol});
}
