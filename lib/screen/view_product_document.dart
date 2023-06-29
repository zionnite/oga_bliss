import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/property_controller.dart';
import 'package:oga_bliss/model/property_model.dart';
import 'package:oga_bliss/screen/upload_title_document.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/property_btn_icon.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewMyProductDocument extends StatefulWidget {
  const ViewMyProductDocument({required this.model, required this.user_id});

  final PropertyModel model;
  final String user_id;

  @override
  State<ViewMyProductDocument> createState() => _ViewMyProductDocumentState();
}

class _ViewMyProductDocumentState extends State<ViewMyProductDocument> {
  final propsController = PropertyController().getXID;
  late ScrollController _controller;

  String? user_id;
  String? user_status;
  bool? admin_status;

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

      await propsController.getPropertyDocument(user_id, widget.model.propsId);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  @override
  void initState() {
    initUserDetail();
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      propsController.getMorePropertyDocument(
          current_page, user_id, widget.model.propsId);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  PlatformFile? _doc_file;
  String? _doc_ext;
  Future _getDocFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
      );
      if (result == null) return;

      setState(() {
        _doc_file = result.files.first;
        _doc_ext = _doc_file!.extension;
      });

      //
    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Property Document'),
          PropertyBtnIcon(
            onTap: () {
              Get.to(
                () => UploadTitleDocument(
                  props_id: widget.model.propsId!,
                  user_id: user_id!,
                ),
              );
            },
            title: 'Upload Titled Document',
            bgColor: Colors.blue,
            icon: Icons.file_open,
            icon_color: Colors.white,
            icon_size: 20,
          ),
          Expanded(
            child: Obx(
              () => (propsController.isDocProcessing == 'null')
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.blue,
                        size: 20,
                      ),
                    )
                  : detail(),
            ),
          )
        ],
      ),
    );
  }

  Widget detail() {
    return (propsController.docList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    propsController.isDocProcessing.value = 'null';
                    propsController.getPropertyDocument(
                        user_id, widget.model.propsId);
                    propsController.docList.refresh();
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ])
        : SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.all(0),
                    key: const PageStorageKey<String>('myProperty'),
                    physics: const ClampingScrollPhysics(),
                    // itemExtent: 350,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: propsController.docList.length,

                    itemBuilder: (BuildContext context, int index) {
                      var props = propsController.docList[index];

                      if (propsController.docList[index].id == null) {
                        return Container();
                      }

                      return Card(
                        child: ListTile(
                          leading: InkWell(
                            onTap: () {
                              String link = '${props.fileName}';
                              _launchInBrowser(Uri.parse(link));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: (props.fileExt == 'pdf')
                                    ? const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/pdf.png',
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(
                                          props.fileName!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          title: InkWell(
                            onTap: () {
                              String link = '${props.fileName}';
                              _launchInBrowser(Uri.parse(link));
                            },
                            child: Text(
                              props.title!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          subtitle: InkWell(
                            onTap: () {
                              String link = '${props.fileName}';
                              _launchInBrowser(Uri.parse(link));
                            },
                            child: const Text(
                              'Open file',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          trailing: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            color: Colors.white,
                            enabled: true,
                            onSelected: (value) async {
                              if (value == 'delete') {
                                bool status = await propsController
                                    .deleteDocFile(user_id, props.id);

                                if (status) {
                                  int rootIndex = propsController.docList
                                      .indexOf(propsController.docList[index]);
                                  propsController.docList.removeAt(rootIndex);
                                }
                              }
                            },
                            itemBuilder: (BuildContext bc) {
                              return const [
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text("Delete"),
                                ),
                              ];
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }

  Widget _openPopUp({required PropertyModel model}) {
    return PopupMenuButton<String>(
      enabled: true,
      onSelected: (value) {
        // your logic
        if (value == 'delete') {}
      },
      itemBuilder: (BuildContext bc) {
        return const [
          PopupMenuItem(
            child: Text("Delete"),
            value: 'delete',
          ),
        ];
      },
    );
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
