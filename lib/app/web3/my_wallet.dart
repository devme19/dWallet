
import 'package:dwallet/app/web3/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/foundation.dart';

class MyWallet{

  static final MyWallet _myWallet = MyWallet._internal();

  factory MyWallet() {
    return _myWallet;
  }


  MyWallet._internal();
  String? secretPhrase;
  List<String>? secretPhraseList=[];
  List<String>? shuffledSecretPhraseList=[];

  // Future<Wallet> createNewWallet()async{
  //   secretPhrase = bip39.generateMnemonic();
  //   secretPhraseList!.addAll(secretPhrase!.split(' '));
  //   shuffledSecretPhraseList!.addAll(secretPhraseList!);
  //   shuffledSecretPhraseList!.shuffle();
  //   Wallet wallet= await compute(Wallet.fromMnemonic,secretPhrase);
  //   return wallet;
  // }

}