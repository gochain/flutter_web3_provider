library flutter_web3_provider;

import 'ethereum.dart';
import 'ethers.dart';

BrowserProvider? getWeb3Provider() {
  final provider = ethereum ?? binanceChain ?? web3;
  if (provider != null) {
    return BrowserProvider(provider);
  }
  return null;
}


BrowserProvider? getBrowserProvider() {
  final provider = ethereum ?? binanceChain ?? web3;
  if (provider != null) {
    return BrowserProvider(provider);
  }
  return null;
}
