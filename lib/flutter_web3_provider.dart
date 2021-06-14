library flutter_web3_provider;

import 'ethereum.dart';
import 'ethers.dart';

Web3Provider? getWeb3Provider() {
  final provider = ethereum ?? binanceChain ?? web3;
  if (provider != null) {
    return Web3Provider(provider);
  }
  return null;
}
