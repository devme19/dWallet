import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/keccak.dart';
import '../utils/typed_data.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/ecc/api.dart';

final KeccakDigest keccakDigest = KeccakDigest(256);

final ECDomainParameters params = ECCurve_secp256k1();

Uint8List keccak256(Uint8List input) {
  keccakDigest.reset();
  return keccakDigest.process(input);
}

Uint8List keccakUtf8(String input) {
  return keccak256(uint8ListFromList(utf8.encode(input)));
}

Uint8List keccakAscii(String input) {
  return keccak256(ascii.encode(input));
}
Uint8List publicKeyToAddress(Uint8List publicKey) {
  assert(publicKey.length == 64);
  final hashed = keccak256(publicKey);
  assert(hashed.length == 32);
  return hashed.sublist(12, 32);
}
/// Generates a public key for the given private key using the ecdsa curve which
/// Ethereum uses.
Uint8List privateKeyToPublic(BigInt privateKey) {
  final p = (params.G * privateKey)!;

  //skip the type flag, https://github.com/ethereumjs/ethereumjs-util/blob/master/index.js#L319
  return Uint8List.view(p.getEncoded(false).buffer, 1);
}
