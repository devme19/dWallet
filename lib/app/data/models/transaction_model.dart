class TransactionModel {
  String? date, txHash, symbol;

  double? amount;
  bool? isSend;
  TransactionModel(
      { this.date,
       this.txHash,
       this.isSend,
       this.amount,
       this.symbol});
  TransactionModel.fromMap(Map<String,dynamic> map){
    date = map["date"];
    txHash = map["txHash"];
    symbol = map["symbol"];
    amount = map["amount"];
    isSend = map["isSend"];
  }
  static Map<String, dynamic> toMap(TransactionModel transaction)=>{
    'date' : transaction.date,
    'txHash' :transaction.txHash,
    'symbol' : transaction.symbol,
    'amount' : transaction.amount,
    'isSend' : transaction.isSend,

  };
}
