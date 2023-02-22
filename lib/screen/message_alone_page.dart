import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/common.dart';

class MessageAlonePage extends StatefulWidget {
  MessageAlonePage({
    required this.sender,
    required this.receiver,
    required this.propsId,
    required this.image_name,
    required this.status,
    required this.name,
  });

  final String sender;
  final String receiver;
  final String propsId;
  final String image_name;
  final String status;
  final String name;

  @override
  State<MessageAlonePage> createState() => _MessageAlonePageState();
}

class _MessageAlonePageState extends State<MessageAlonePage> {
  TextEditingController textFieldController = TextEditingController();
  ScrollController _listScrollController = ScrollController();

  String? chat_msg;
  bool send_status = false;
  bool isWriting = false;
  FocusNode textFieldFocus = FocusNode();
  bool showEmojiPicker = false;
  bool chatCounterStatus = true;
  int msg_id = 0;

  Future<Stream<Future<List>>> handleRefresh() async {
    var res = await http
        .post(Uri.parse('https://ogabliss.com/Api/get_chat_msg'), body: {
      'sender': widget.receiver,
      'reciever': widget.sender,
      'props_id': widget.propsId,
    });

    var jsonx = json.decode(res.body);

    Stream<Future<List<dynamic>>> stream =
        Stream<Future<List<dynamic>>>.value(jsonx);
    return stream;
  }

  String? user_id;
  String? user_status;
  bool? admin_status;

  String? my_id, agent_id;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
      });
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.image_name,
                  ),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.status,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                (user_status == 'user')
                    ? PopupMenuButton(
                        icon: const Icon(
                          Icons.more_vert_outlined,
                          color: Colors.white,
                        ),
                        onSelected: (val) async {
                          var sender = widget.sender;
                          var receiver = widget.receiver;
                          var propsId = widget.propsId;

                          if (user_id == sender) {
                            setState(() {
                              my_id = sender;
                              agent_id = receiver;
                            });
                          } else if (user_id == receiver) {
                            setState(() {
                              my_id = receiver;
                              agent_id = sender;
                            });
                          }

                          String pay_link =
                              'https://ogabliss.com/Transaction/app_pay';
                          String agree_link =
                              'https://ogabliss.com/Transaction/app_agree';
                          if (val == 'payment') {
                            await _launchInBrowser(Uri.parse(
                                '$pay_link/$my_id/$agent_id/$propsId'));
                          } else if (val == 'agreement') {
                            await _launchInBrowser(Uri.parse(
                                '$agree_link/$my_id/$agent_id/$propsId'));
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'payment',
                              child: Text('Make Payment'),
                            ),
                            const PopupMenuItem(
                              value: 'agreement',
                              child: Text('Agreement'),
                            ),
                          ];
                        })
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: chatMessageItem(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                chatControls(),
              ],
            ),
          ),
          showEmojiPicker ? Container(child: emojiContainer()) : Container(),
        ],
      ),
    );
  }

  emojiContainer() {
    return Expanded(
      child: WillPopScope(
        onWillPop: () async {
          //Get.back();
          setState(() {
            showEmojiPicker = false;
          });
          return false;
        },
        child: EmojiPicker(
          onEmojiSelected: (category, emoji) {
            // Do something when emoji is tapped (optional)
            setState(() {
              isWriting = true;
              textFieldController.text = textFieldController.text + emoji.emoji;
              chat_msg = textFieldController.text;
              // textFieldController.text = '';
            });
          },
          onBackspacePressed: () {
            // Do something when the user taps the backspace button (optional)
          },
          //textEditingController: textFieldController,
          config: Config(
            columns: 7,
            emojiSizeMax: 32 *
                (Platform.isIOS
                    ? 1.30
                    : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
            verticalSpacing: 0,
            horizontalSpacing: 0,
            gridPadding: EdgeInsets.zero,
            initCategory: Category.RECENT,
            bgColor: Color(0xFFF2F2F2),
            indicatorColor: Colors.purple,
            iconColor: Colors.grey,
            iconColorSelected: Colors.purple,
            //progressIndicatorColor: Colors.purple,
            backspaceColor: Colors.purple,
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
            showRecentsTab: true,
            recentsLimit: 28,
            noRecents: const Text(
              'No Recents',
              style: TextStyle(fontSize: 20, color: Colors.black26),
              textAlign: TextAlign.center,
            ),
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: const CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL,
          ),
        ),
      ),
    );
  }

  calculateCounter() {
    if (mounted) {
      setState(() {
        chatCounterStatus = false;
      });
    }
  }

  Widget chatMessageItem() {
    return StreamBuilder(
        initialData: null,
        stream: _stream(),
        builder: (context, snap) {
          if (snap.data == null) {
            const Center(child: CircularProgressIndicator());
          }

          if (snap.hasData) {
            var temp = snap.data as Future<List<dynamic>>;

            return SingleChildScrollView(
              controller: _listScrollController,
              child: FutureBuilder(
                future: temp,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> lst = snapshot.data;
                    if (lst != null) {
                      var status = lst[0]['status'];

                      if (status != 'end') {
                        // /*scroll to bottom when first open the chat page*/
                        if (chatCounterStatus) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _listScrollController.jumpTo(
                                _listScrollController.position.maxScrollExtent +
                                    2000);

                            setState(() {
                              chatCounterStatus = false;
                            });
                          });
                        }

                        /*Scroll to bottom when user recieve msg from partner*/

                        var partner_array = lst[lst.length - 1];
                        var partner_last_msg = partner_array['message'];
                        var parter_last_sender = partner_array['sender'];
                        var parter_last_msg_id = int.parse(partner_array['id']);

                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          if (msg_id == 0) {
                            setState(() {
                              msg_id = parter_last_msg_id;
                            });
                          } else {
                            if (parter_last_msg_id > msg_id) {
                              setState(() {
                                msg_id = parter_last_msg_id;
                              });
                            }
                          }
                        });

                        if (parter_last_msg_id > msg_id) {
                          if (parter_last_sender != widget.receiver) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              _listScrollController.animateTo(
                                _listScrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            });
                          }
                        }

                        return ListView.builder(
                          reverse: false,
                          itemCount: lst.length + 1,
                          shrinkWrap: true,
                          //controller: _listScrollController,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            if (index == lst.length) {
                              return Container(
                                height: 10,
                              );
                            }

                            var id = lst[index]['id'].toString();
                            var sender = lst[index]['sender'].toString();
                            var reciever = lst[index]['reciever'].toString();
                            var time = lst[index]['time'].toString();
                            var message = lst[index]['message'].toString();
                            var sender_status =
                                lst[index]['sender_read_status'].toString();
                            var reciever_status =
                                lst[index]['reciever_read_status'].toString();

                            //_updateReadStatus(id);

                            if (sender == widget.receiver) {
                              return senderLayout(
                                  message, time, reciever_status);
                            } else {
                              return receiverLayout(message, time);
                            }
                          },
                        );
                      } else {
                        return Column(
                          children: [
                            senderLayout(
                                'Hey, there is no conversation between you and this user at the moment, start by Saying Hi',
                                '',
                                null),
                          ],
                        );
                      }
                    }
                    return Container(); //null
                  }
                  return Container();
                },
              ),
            );
          }
          return Container();
        });
  }

  showKeyboard() => textFieldFocus.requestFocus();

  hideKeyboard() => textFieldFocus.unfocus();

  hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  Stream<Future<List<dynamic>>> _stream() {
    Duration interval = Duration(seconds: 1);

    Stream<Future<List<dynamic>>> stream =
        Stream<Future<List<dynamic>>>.periodic(interval, _getData);
    return stream;
  }

  Future<List<dynamic>> _getData(int value) async {
    var res = await http
        .post(Uri.parse('https://ogabliss.com/Api/get_chat_msg'), body: {
      'sender': widget.receiver,
      'reciever': widget.sender,
      'props_id': widget.propsId,
    });

    // print('jsonBODY ${res.body}');
    var jsonx = json.decode(res.body);

    return jsonx;
  }

  _sendMess(String content) async {
    print('content $content');
    var res = await http
        .post(Uri.parse('https://ogabliss.com/Api/send_chat_msg'), body: {
      'sender': widget.receiver,
      'reciever': widget.sender,
      'message': content,
      'props_id': widget.propsId,
    });

    print('content ${res.body}');
    var j = json.decode(res.body);
    String status = j['status'];

    return status;
  }

  Widget senderLayout(var chat, var time, var read_count) {
    Radius messageRadius = const Radius.circular(10);

    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 15),
        child: Container(
          margin: const EdgeInsets.only(top: 12, left: 75, right: 10),
          decoration: BoxDecoration(
            color: senderColor,
            borderRadius: BorderRadius.only(
              topLeft: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget receiverLayout(var chat, var time) {
    Radius messageRadius = const Radius.circular(10);

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 15),
        child: Container(
          margin: const EdgeInsets.only(top: 12, left: 10, right: 75),
          decoration: BoxDecoration(
            color: receiverColor,
            borderRadius: BorderRadius.only(
              bottomRight: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chatControls() {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textFieldController,
              focusNode: textFieldFocus,
              minLines: 1,
              maxLines: 8,
              // expands: true,
              keyboardType: TextInputType.multiline,
              onTap: () => hideEmojiContainer(),
              style: const TextStyle(
                color: Colors.white,
              ),
              onChanged: (val) {
                (val.length > 0 && val.trim() != "")
                    ? setWritingTo(true)
                    : setWritingTo(false);
                setState(() {
                  chat_msg = textFieldController.text;
                  //textFieldController.text = "";
                });
              },
              decoration: InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(
                  color: greyColor,
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    borderSide: BorderSide.none),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                fillColor: separatorColor,
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    if (!showEmojiPicker) {
                      // keyboard is visible
                      hideKeyboard();
                      showEmojiContainer();
                    } else {
                      //keyboard is hidden
                      showKeyboard();
                      hideEmojiContainer();
                    }
                  },
                  icon: const Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          isWriting
              ? Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      gradient: fabGradient, shape: BoxShape.circle),
                  child: IconButton(
                    icon: (send_status)
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.send,
                            size: 25,
                            color: Colors.white,
                          ),
                    onPressed: () async {
                      setState(() {
                        send_status = true;
                        textFieldController.text = "";
                      });

                      var status = await _sendMess(chat_msg.toString().trim());
                      if (status == 'true') {
                        setState(() {
                          send_status = false;
                          isWriting = false;
                        });

                        Future.delayed(const Duration(seconds: 3), () {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            _listScrollController.animateTo(
                              _listScrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                            );
                          });
                        });
                      } else {
                        setState(() {
                          send_status = false;
                          isWriting = false;
                        });
                        showSnackBar(
                            title: 'Ooops!',
                            msg: 'Server Busy, could send message',
                            backgroundColor: Colors.red);
                      }
                    },
                  ))
              : Container()
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
