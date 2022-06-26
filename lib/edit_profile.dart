// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:projeto/model/model.dart';
import '/db/interface_database.dart';

import 'package:mobx/mobx.dart';
import '/stores/photoview_store.dart';
// part 'photoview_store.g.dart.old';

//Uint8List? userImage;

final _photoview = Photoview();

class EditProfile extends StatefulWidget {
  const EditProfile({Key, key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  //final ImagePicker _picker = ImagePicker();
  //XFile? image;
  //XFile? imageBeweenScreens;

  //final _photoView = PhotoviewStore();

  @override
  Widget build(BuildContext context) {
    //final ImagePicker _picker = ImagePicker();

    //final _photoview = Photoview();

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      "Editar Perfil",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Observer(builder: (BuildContext context) {
                      return Stack(children: [
                        Container(
                          width: 130,
                          height: 130,
                          child: FutureBuilder<User?>(
                              future: getImage(),
                              builder: (context, snapshot) {
                                _photoview.userImage = snapshot.data?.imagem;
                                return Container(
                                  child: CircleAvatar(
                                      radius: 71,
                                      backgroundColor: Colors.lightGreen,
                                      backgroundImage: _photoview.userImage ==
                                              null
                                          ? AssetImage("assets/avatar.png")
                                          : MemoryImage(_photoview.userImage!)
                                              as ImageProvider
                                      //FileImage(File(image!.path)) as ImageProvider,
                                      ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 4,
                                      color: Colors.green,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                );
                              },
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                        ),
                      ]);
                    }),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Nome Completo",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "",
                      // hintStyle: TextStyle(
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.bold,
                      //   color: Colors.black,
                      // ),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget bottomSheet() {
    //final _photoview = Photoview();

    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(children: <Widget>[
          Text("Escolha a foto de perfil",
              style: TextStyle(
                fontSize: 20,
              )),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  _photoview.filePicker(ImageSource.camera);
                },
                label: Text("Câmera"),
                //child:
              ),
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  _photoview.filePicker(ImageSource.gallery);
                },
                label: Text("Galeria"),
                //child:
              ),
            ],
          ),
        ]));
  }

  // Future photoPicker(ImageSource source) async {
  //   PickedFile? pickedFile = await _picker.pickImage(
  //     source: source,
  //   );

  //   if (pickedFile == null) {
  //     return null;

  //   setState(() {
  //     _imageFile = pickedFile as PickedFile;
  //   });
  // }

  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);
  //     setState(() {
  //       this.image = imageTemporary;
  //     });
  //   } on PlatformException catch (e) {
  //     //print('Failed to pick image: $e');
  //   }
  // }

  // void filePicker(ImageSource source) async {
  //   // TODO: Envolver em um try
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? selectImage = await _picker.pickImage(source: source);
  //   print(selectImage!.path);

  //   // Armazena foto no banco
  //   File imageFile = File(selectImage.path);
  //   Uint8List imageRaw = await imageFile.readAsBytes();
  //   updateImage(imageRaw);
  //   print("Update da imagem realizado");
  // }
}

// class PhotoviewStore = _PhotoviewStore with _$PhotoviewStore;

// abstract class __PhotoviewStore with Store {
//   @observable
//   Uint8List? userImage;

//   @action
//   Future filePicker(ImageSource source) async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? selectImage = await _picker.pickImage(source: source);
//     print(selectImage!.path);

//     // Armazena foto no banco
//     File imageFile = File(selectImage.path);
//     userImage = await imageFile.readAsBytes();
//     updateImage(userImage!);

//     print("Update da imagem realizado");
//   }
// }
