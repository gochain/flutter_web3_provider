import 'package:decimal/decimal.dart';

BigInt toBase(Decimal amount, int decimals) {
  Decimal baseUnit = Decimal.fromInt(10).pow(decimals).toDecimal();
  print("baseUnit: $baseUnit");
  Decimal inbase = amount * baseUnit;
  print("inbase: $inbase");
  return BigInt.parse(inbase.toString());
}
Decimal toDecimal(BigInt amount, int decimals) {
  var x = Decimal.fromBigInt(amount).toRational() / Decimal.fromInt(10).pow(decimals);
  return x.toDecimal();
}
