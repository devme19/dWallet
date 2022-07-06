import 'package:dwallet/app/data/models/transaction_model.dart';
import 'package:dwallet/app/presantation/theme/themes.dart';
import 'package:flutter/material.dart';

class TransactionWidgetItem extends StatelessWidget {
  TransactionWidgetItem({Key? key, this.tx}) : super(key: key);
  TransactionModel? tx;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(tx!.date!),
            )
          ],
        ),
        Column(
          children: [
            TransactionWidget(
              tx: tx!,
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Divider(
            thickness: 1.2,
          ),
        ),
      ],
    );
  }
}

class TransactionWidget extends StatelessWidget {
  TransactionWidget({Key? key, required this.tx}) : super(key: key);

  TransactionModel tx;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: IColor().DARK_BUTTOM_COLOR.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 1, color: IColor().DARK_TEXT_COLOR),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Icon(
                        tx.isSend! ? Icons.arrow_upward : Icons.arrow_downward),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.isSend! ? "Send" : "Receive",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "To: ${tx.txId}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  tx.amount.toString(),
                  style: TextStyle(
                      color: tx.isSend!
                          ? IColor().DARK_WARNING_COLOR
                          : IColor().Dark_CHECK_COLOR),
                ),
                Text(tx.symbol!,
                    style: TextStyle(
                        color: tx.isSend!
                            ? IColor().DARK_WARNING_COLOR
                            : IColor().Dark_CHECK_COLOR))
              ],
            )
          ],
        ),
      ),
    );
  }
}
