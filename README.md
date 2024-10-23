# flutter_web3_provider

Flutter wrapper for using web3 providers, ie: accessing `window.ethereum`.

NOTE: This is for web only!

## Getting Started

For full example, see: https://github.com/gochain/flutter_web3_provider/blob/main/example/lib/main.dart

Add import `import 'package:flutter_web3_provider/ethereum.dart';`

Then you can access it just be using the `ethereum` variable.

```dart
if(ethereum != null){
    // then an ethereum provider was injected
    print(ethereum.selectedAddress);
}
```

Ask user to connect their wallet:

```dart
RaisedButton(
    child: Text("Connect Wallet"),
    onPressed: () async {
        var accounts = await promiseToFuture(
            ethereum.request(RequestParams(method: 'eth_requestAccounts')));
        print(accounts);
        String se = ethereum.selectedAddress;
        print("selectedAddress: $se");
        setState(() {
            selectedAddress = se;
        });
    },
)
```

### Using ethers.js

Add ethers.js to `web/index.html`.

```html
  <script type="module">
    import { ethers } from "https://cdnjs.cloudflare.com/ajax/libs/ethers/6.7.0/ethers.min.js";
    window.ethers = ethers
    // Your code here...
  </script>
```

Import package:

```
import 'package:flutter_web3_provider/ethers.dart';
```

Then create an ethers provider:

```dart
// For a read-only provider:
var provider = JsonRpcProvider("https://rpc.gochain.io");
// For a read-write provider (ie: metamask, trust wallet, etc)
var web3 = BrowserProvider(ethereum);
```

Then you can do things like check balance and submit transactions, etc:

```dart
var abalanceF = promiseToFuture(web3.getBalance(ethereum.selectedAddress));

Future tx = promiseToFuture(web3.Signer().sendTransaction(TxParams(
      to: to,
      value: "0x" +
          BigInt.parse(toBase(amount, 18).toString()).toRadixString(16))));
```

Or use a contract:

```dart
const erc20Abi = [
    // Some details about the token
    "function name() view returns (string)",
    "function symbol() view returns (string)",

    // Get the account balance
    "function balanceOf(address) view returns (uint)",

    // Send some of your tokens to someone else
    "function transfer(address to, uint amount)",

    // An event triggered whenever anyone transfers to someone else
    "event Transfer(address indexed from, address indexed to, uint amount)"
];
var contract = Contract(contractAddress, erc20Abi, web3);
// call balanceOf function
var usdcBalanceF = promiseToFuture(
          callMethod(contract, "balanceOf", [ethereum.selectedAddress]));
          
// to make a write transaction, first get the signer (this will use metamask/wallet)
contract = contract.connect(web3.getSigner()); // uses the connected wallet as signer
// then call the function:
var res =
    await promiseToFuture(callMethod(contract, "transfer", [
    '0x39C5190c09ec04cF09C782bA4311C469473Ffe83',
    "0x" + amount.toString()).toRadixString(16)
    ]));
```

If you need to additional overrides like set gas price or passing the `value` param, you can add one extra param in the array with those fields, eg:

```dart
var res = await promiseToFuture(callMethod(
    contract, "transfer", ['0x39C5190c09ec04cF09C782bA4311C469473Ffe83', "0x" + amount.toString()).toRadixString(16), 
    TxParams(value: "1000000000000000000")]));
```

NOTES:

* If you're using the human readable ABI's (ethers.js feature) like above, use `uint`, not `uint256` even if the real abi is a uint256.
* There are some common functions on the Contract, but you can also call any method using `callMethod` like above.
 
## Developers

To publish:

```sh
make publish
```
