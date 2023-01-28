import 'package:flutter/material.dart';
import 'package:oga_bliss/model/wallet_model.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:oga_bliss/widget/small_btn.dart';

import '../controller/wallet_controller.dart';
import '../util/currency_formatter.dart';

class fundWallet extends StatefulWidget {
  fundWallet({
    required this.image_name,
    required this.name,
    required this.time,
    required this.amount,
    required this.onTap,
    required this.walletModel,
  });

  final String image_name;
  final String name;
  final String time;
  final String amount;
  final VoidCallback onTap;
  final WalletModel walletModel;

  bool isLoading = false;

  @override
  State<fundWallet> createState() => _fundWalletState();
}

class _fundWalletState extends State<fundWallet> {
  final walletController = WalletController().getXID;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: widget.onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      widget.image_name,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'RubikMonoOne-Regular',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Time: ${widget.time}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          CurrencyFormatter.getCurrencyFormatter(
                            amount: "${widget.amount}",
                          ),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                actionButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton() {
    var wallet = widget.walletModel;
    if (wallet.transType == 'deposit') {
      if (wallet.isPay == 'yes') {
        return smallBtn(
          btnName: 'Initiated Settlement',
          btnColor: Colors.red,
          onTap: () async {
            showSnackBar(
              title: 'Wallet Request',
              msg:
                  'You have already initiated a Payment Settlement with this Agent',
              backgroundColor: Colors.blue,
            );
          },
        );
      } else {
        return smallBtn(
          btnName: (widget.isLoading) ? 'Processing....' : 'Pull Out',
          btnColor: Colors.black,
          onTap: () async {
            setState(() {
              widget.isLoading = true;
            });
            var status = await walletController.pullOutRequest(
                propsId: widget.walletModel.propsId!,
                agentId: widget.walletModel.agentId!,
                userId: widget.walletModel.disUserId!);

            if (status == 'transfer') {
              setState(() {
                if (mounted) {
                  int index =
                      walletController.walletList.indexOf(widget.walletModel);
                  walletController.walletList[index].isPay = 'yes';
                }
              });
            }

            Future.delayed(new Duration(seconds: 4), () {
              setState(() {
                widget.isLoading = false;
              });
            });
          },
        );
      }
    } else if (wallet.transType == 'withdraw') {
      return smallBtn(
        btnName: 'Already Pull Out',
        btnColor: Colors.green,
        onTap: () {
          showSnackBar(
            title: 'Wallet Request',
            msg: 'Already Pull-out',
            backgroundColor: Colors.blue,
          );
        },
      );
    } else {
      return Container();
    }
  }
}
