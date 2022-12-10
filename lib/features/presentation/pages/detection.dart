import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:paradise_chat/features/presentation/pages/menu_page.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

class CameraScreen extends StatefulWidget {
  final String uid;
  const CameraScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<CameraScreen> createState() => _CameraScreenState(uid: uid);
}

class _CameraScreenState extends State<CameraScreen> {
  _CameraScreenState({Key, key, required this.uid});
  final String uid;
  late File pickedImage;
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  bool isImageLoaded = false;
  String showTxt = "";
  late List _result;
  String _confidence = "";
  String _name = "";
  int _imageCount = 0;
  String imageMush = '';
  String _textDetails = '';
  //XFile? image;

  getImageFromGallery() async {
    loadModel();
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModelOnImage(File(tempStore.path));
    });
  }

  Future loadModel() async {
    var result = await Tflite.loadModel(
        labels: "assets/labels.txt", model: "assets/model_unquant.tflite");
    print("Result after loading model : $result");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 130.5,
      imageStd: 130.5,
    );
    setState(() {
      _result = res!;
      String str = _result[0]["label"];
      _name = str.substring(2);
      _confidence = _result != null
          ? (_result[0]["confidence"] * 100.0).toString().substring(0, 2) + "%"
          : "";
      if (_result[0]['confidence'] > 0.70) {
        if (_name == "Jelly") {
          _name = "เห็ดหูหนู";
          _textDetails =
              ("เห็ดหูหนู ชื่อวิทยาศาสตร์: Auricularia auricula-judae อยู่ในวงศ์ Auriculariaceae ดอกเห็ดเป็นวุ้นทรงถ้วย รูปร่างคล้ายหูไม่แน่นอน ผิวด้านนอกสีน้ำตาลอมเหลือง แดง หรือเทา มีขนเล็กๆ ผิวด้านในสีอ่อนกว่า ไม่มีขน มีรอยหยักย่นออกจากโคนไปถึงปลาย สปอร์รูปรี ใส ผิวเรียบ เป็นเห็ดที่รับประทานได้");
        } else if (_name == "Enokitake") {
          _name = "เห็ดเข็มทอง";
          _textDetails =
              ("เห็ดเข็มทอง(Flammulina velutipes (Curt:Fr.) Singer)มีชื่อสามัญว่า Enokitake หรือ The Golden Mushroom สามารถขึ้นได้ในสภาพที่เย็นจัดสามารถทนอยู่ในสภาพที่เป็นน้ำแข็งจนน้ำแข็งละลายจึงมีชื่อเรียกอีกชื่อหนึ่งว่า The Winter Mushroom ปกติจะมีดอกขนาดเล็กและสั้นแต่ที่วางขายในตลาดทั่วไปจะมีดอกเล็กลำต้นยาวเป็นกระจุกผิดไปจากที่พบเห็นในธรรมชาติ");
        } else if (_name == "Lentinus") {
          _name = "เห็ดขอนขาว";
          _textDetails =
              ("เห็ดขอนขาว (ชื่อวิทยาศาสตร์ : Lentinus squarrosulas Mont. ,ชื่อสามัญ : เห็ดขอนขาว ,ชื่ออื่น : เห็ดมันมะม่วง เห็ดมันลักษณะโดยทั่วไปของเห็ดขอนขาวและเห็ดขอนดำโดยทั่วไปแล้วลักษณะก้านจะชูออกมา และหมวกเห็ดจะมีรอยปุ๋มตรงกลางเล็กน้อย โดยที่ขนาดของหมวกเห็ดจะไม่ใหญ่มากและถ้าหากสีของเห็ดเป็นสีขาวทั้งต้นจะถูกเรียกว่าเห็ดขอนขาวแต่ถ้าที่หมวกเห็ดออกสีคล้ำๆหน่อยจะเรียกว่าเห็ดขอนดำส่วนมากจะขึ้นบนไม้เนื้อแข็งและก้อนเชื้อเห็ดที่ชาวไร่เพาะขึ้นมา");
        } else if (_name == "Oyster") {
          _name = "เห็ดนางฟ้า";
          _textDetails =
              ("เห็ดนางฟ้า (Grey oyster mushroom) มีชื่อวิทยาศาสตร์คือ Pleurotus sajor-caju (Fr. Singers) เป็นเห็ด (mushroom) ที่เพาะปลูกได้ในท้องถิ่นทั่วประเทศไทย ราคาถูก มีจำหน่ายทุกฤดูกาล นิยมนำมาบริโภคเป็นอาหาร และสามารถแปรรูปเพื่อการถนอมอาหาร เป็นผลิตภัณฑ์อาหารได้หลากหลาย ได้แก่ เห็ดกรอบสามรส");
        } else if (_name == "Shitake") {
          _name = "เห็ดหอม";
          _textDetails =
              ("เห็ดหอม (Shiitake mushroom) เป็นสิ่งมีชีวิตในกลุ่มฟังไจ (fungi)ประเภทเห็ด(mushroom)มีชื่อวิทยาศาสตร์ว่า Lentinus edodes (Berk.) Sing.ชื่ออื่น: ญี่ปุ่นเรียกว่า ไชอิตาเกะ เกาหลีเรียกว่า โบโกะ จีนเรียกว่า เฮียโกะ ภูฏานเรียกว่า ชิชิ-ชามุ อังกฤษเรียกว่า Black mushroom หรือ เห็ดดำ ถิ่นกำเนิด: ประเทศจีน ญี่ปุ่น อินโดนีเซีย และไต้หวัน");
        } else if (_name == "Eryngii") {
          _name = "เห็ดออรินจิ";
          _textDetails =
              ("ชื่อสามัญ : เห็ดออรินจิ หรือ เห็ดนางรมหลวง ( Eryngii Mushroom) ชื่อวิทยาศาสตร์ :Pleurotus eryngii (Cand.Ex.Fr.) เห็ดนางรมหลวงหรือเห็ดออรินจิ เป็นเห็ดในตระกูลนางรมอีกชนิดหนึ่ง ที่มีลักษณะรูปร่างแตกต่างอย่างเห็นได้ชัด จากเห็ดนางรมชนิดอื่น ๆ ที่พบเห็นอยู่ทั่วไปในตลาด จุดเด่นของเห็ดชนิดนี้ก็คือ ก้านดอกจะมีขนาดใหญ่ และหมวกดอกหนา ออกดอกไม่เป็นกลุ่ม ก้านดอกมีสีขาว ส่วนด้านบนของหมวกดอกจะมีสีเทาอ่อน");
        }
        showResultOnImage();
        showTxt =
            ("ชื่อ : $_name \n ความแม่นยำ : $_confidence  \n รายละเอียด : $_textDetails");
        //cameraController.stopImageStream();

      } else {
        showResultIncorrect();
        cameraController.stopImageStream();
      }
    });
  }

  Future<void> mushroomRecognition(CameraImage cameraImage) async {
    var recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImage.planes.map((plane) {
          return plane.bytes;
        }).toList(), // required
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        imageMean: 127.5, // defaults to 127.5
        imageStd: 127.5, // defaults to 127.5
        rotation: 90, // defaults to 90, Android only
        numResults: 2, // defaults to 5
        threshold: 0.1, // defaults to 0.1
        asynch: true // defaults to true
        );
    if (recognitions![0]['confidence'] > 0.70) {
      String str = recognitions[0]['label'];
      _name = str.substring(2);
      _confidence = recognitions != null
          ? (recognitions[0]["confidence"] * 100.0).toString().substring(0, 2) +
              "%"
          : "";
      if (_name == "Jelly") {
        imageMush = ('./assets/jelly.jpg');
        _name = "เห็ดหูหนู";
        _textDetails =
            ("เห็ดหูหนู ชื่อวิทยาศาสตร์: Auricularia auricula-judae อยู่ในวงศ์ Auriculariaceae ดอกเห็ดเป็นวุ้นทรงถ้วย รูปร่างคล้ายหูไม่แน่นอน ผิวด้านนอกสีน้ำตาลอมเหลือง แดง หรือเทา มีขนเล็กๆ ผิวด้านในสีอ่อนกว่า ไม่มีขน มีรอยหยักย่นออกจากโคนไปถึงปลาย สปอร์รูปรี ใส ผิวเรียบ เป็นเห็ดที่รับประทานได้");
      } else if (_name == "Enokitake") {
        imageMush = ('./assets/enokitake.jpg');
        _name = "เห็ดเข็มทอง";
        _textDetails =
            ("เห็ดเข็มทอง(Flammulina velutipes (Curt:Fr.) Singer)มีชื่อสามัญว่า Enokitake หรือ The Golden Mushroom สามารถขึ้นได้ในสภาพที่เย็นจัดสามารถทนอยู่ในสภาพที่เป็นน้ำแข็งจนน้ำแข็งละลายจึงมีชื่อเรียกอีกชื่อหนึ่งว่า The Winter Mushroom ปกติจะมีดอกขนาดเล็กและสั้นแต่ที่วางขายในตลาดทั่วไปจะมีดอกเล็กลำต้นยาวเป็นกระจุกผิดไปจากที่พบเห็นในธรรมชาติ");
      } else if (_name == "Lentinus") {
        imageMush = ('./assets/lentinus.jpg');
        _name = "เห็ดขอนขาว";
        _textDetails =
            ("เห็ดขอนขาว (ชื่อวิทยาศาสตร์ : Lentinus squarrosulas Mont. ,ชื่อสามัญ : เห็ดขอนขาว ,ชื่ออื่น : เห็ดมันมะม่วง เห็ดมันลักษณะโดยทั่วไปของเห็ดขอนขาวและเห็ดขอนดำโดยทั่วไปแล้วลักษณะก้านจะชูออกมา และหมวกเห็ดจะมีรอยปุ๋มตรงกลางเล็กน้อย โดยที่ขนาดของหมวกเห็ดจะไม่ใหญ่มากและถ้าหากสีของเห็ดเป็นสีขาวทั้งต้นจะถูกเรียกว่าเห็ดขอนขาวแต่ถ้าที่หมวกเห็ดออกสีคล้ำๆหน่อยจะเรียกว่าเห็ดขอนดำส่วนมากจะขึ้นบนไม้เนื้อแข็งและก้อนเชื้อเห็ดที่ชาวไร่เพาะขึ้นมา");
      } else if (_name == "Oyster") {
        imageMush = ('./assets/oyster.png');
        _name = "เห็ดนางฟ้า";
        _textDetails =
            ("เห็ดนางฟ้า (Grey oyster mushroom) มีชื่อวิทยาศาสตร์คือ Pleurotus sajor-caju (Fr. Singers) เป็นเห็ด (mushroom) ที่เพาะปลูกได้ในท้องถิ่นทั่วประเทศไทย ราคาถูก มีจำหน่ายทุกฤดูกาล นิยมนำมาบริโภคเป็นอาหาร และสามารถแปรรูปเพื่อการถนอมอาหาร เป็นผลิตภัณฑ์อาหารได้หลากหลาย ได้แก่ เห็ดกรอบสามรส");
      } else if (_name == "Shitake") {
        imageMush = ('./assets/shitake.jpg');
        _name = "เห็ดหอม";
        _textDetails =
            ("เห็ดหอม (Shiitake mushroom) เป็นสิ่งมีชีวิตในกลุ่มฟังไจ (fungi)ประเภทเห็ด(mushroom)มีชื่อวิทยาศาสตร์ว่า Lentinus edodes (Berk.) Sing.ชื่ออื่น: ญี่ปุ่นเรียกว่า ไชอิตาเกะ เกาหลีเรียกว่า โบโกะ จีนเรียกว่า เฮียโกะ ภูฏานเรียกว่า ชิชิ-ชามุ อังกฤษเรียกว่า Black mushroom หรือ เห็ดดำ ถิ่นกำเนิด: ประเทศจีน ญี่ปุ่น อินโดนีเซีย และไต้หวัน");
      } else if (_name == "Eryngii") {
        imageMush = ('./assets/eryngii.jpg');
        _name = "เห็ดออรินจิ";
        _textDetails =
            ("ชื่อสามัญ : เห็ดออรินจิ หรือ เห็ดนางรมหลวง ( Eryngii Mushroom) ชื่อวิทยาศาสตร์ :Pleurotus eryngii (Cand.Ex.Fr.) เห็ดนางรมหลวงหรือเห็ดออรินจิ เป็นเห็ดในตระกูลนางรมอีกชนิดหนึ่ง ที่มีลักษณะรูปร่างแตกต่างอย่างเห็นได้ชัด จากเห็ดนางรมชนิดอื่น ๆ ที่พบเห็นอยู่ทั่วไปในตลาด จุดเด่นของเห็ดชนิดนี้ก็คือ ก้านดอกจะมีขนาดใหญ่ และหมวกดอกหนา ออกดอกไม่เป็นกลุ่ม ก้านดอกมีสีขาว ส่วนด้านบนของหมวกดอกจะมีสีเทาอ่อน");
      }
      cameraController.stopImageStream();
      showResultOnCamera();
      showTxt =
          ("ชื่อ : $_name \n ความแม่นยำ : $_confidence  \n รายละเอียด : $_textDetails");
    } else {
      showResultIncorrect();
      cameraController.stopImageStream();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCamera();
    loadModel();
  }

  void loadCamera() async {
    cameras = await availableCameras();
    cameraController =
        CameraController(cameras[0], ResolutionPreset.high, enableAudio: false);
    await cameraController.initialize().then((value) {
      cameraController.startImageStream((image) => {
            _imageCount++,
            if (_imageCount % 50 == 0)
              {_imageCount = 0, mushroomRecognition(image)}
          });

      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  void showResultIncorrect() {
    showDialog<AlertDialog>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset('./assets/alert.png'),
                  Text(
                    'Warning !',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    'Please try again! or Take it slowly for get the best result!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();

                        cameraController.startImageStream((image) => {
                              _imageCount++,
                              if (_imageCount % 50 == 0)
                                {_imageCount = 0, mushroomRecognition(image)}
                            });
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              )
            ],
          );
        });
  }

  void showResultOnCamera() {
    showDialog<AlertDialog>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Image.asset(imageMush)),
            content: Container(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(showTxt),
                    ],
                  ),
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    cameraController.startImageStream((image) => {
                          _imageCount++,
                          if (_imageCount % 50 == 0)
                            {_imageCount = 0, mushroomRecognition(image)}
                        });
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  void showResultOnImage() {
    showDialog<AlertDialog>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: isImageLoaded
                  ? Center(
                      child: Container(
                        height: 250.0,
                        width: 250.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(pickedImage),
                                fit: BoxFit.cover)),
                      ),
                    )
                  : Container(),
            ),
            content: Container(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        showTxt,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    cameraController.startImageStream((image) => {
                          _imageCount++,
                          if (_imageCount % 50 == 0)
                            {_imageCount = 0, mushroomRecognition(image)}
                        });
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (!cameraController.value.isInitialized) {
      return Container(
        color: Colors.black,
        child: Text('Loading....'),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Transform.scale(
              scale: cameraController.value.aspectRatio / size.aspectRatio,
              child: Center(
                child: AspectRatio(
                    aspectRatio: 1 / cameraController.value.aspectRatio,
                    child: CameraPreview(cameraController)),
              )),
          GestureDetector(
            onTap: () async {
              dispose();
              Navigator.pop(context);
         
            },
            child: button(Icons.arrow_back_ios_new, Alignment.bottomLeft),
          ),
          GestureDetector(
            onTap: () {
              getImageFromGallery();
              cameraController.stopImageStream();
            },
            child: button(Icons.image_outlined, Alignment.bottomRight),
          ),
        ],
      ),
    );
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 10,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 10,
              )
            ]),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
