import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shopbiz/models/categorie.dart';
import 'package:shopbiz/models/product_model.dart';
import 'package:shopbiz/utils/custom_colors.dart';
import 'package:shopbiz/utils/decoration.dart';
import 'package:shopbiz/utils/text_Style.dart';
import 'package:shopbiz/widgets/app_drawer.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProductPage extends StatefulWidget {
  static const id = 'Addproduct';

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  var categoryC = TextEditingController();
  var productNameC = TextEditingController();
  var serialCode = TextEditingController();
  var priceC = TextEditingController();
  var weightC = TextEditingController();
  var brandC = TextEditingController();
  var detailC = TextEditingController();
  var quantityC = TextEditingController();
  var onSaleC = TextEditingController();
  var popularC = TextEditingController();
  var discountC = TextEditingController();

  List<String> imageUrls = <String>[];

  bool isSale = true;
  bool isPopular = false;

  final _key = GlobalKey<FormState>();

  List<Asset> images = <Asset>[];

  save() async {
    bool isValidate = _key.currentState.validate();
    if (isValidate) {
      await uploadImages();
      ProductModel().addProduct(ProductModel(
        category: categoryC.text,
        productName: productNameC.text,
        detail: detailC.text,
        serialCode: serialCode.text,
        price: int.parse(priceC.text),
        weight: weightC.text,
        brandName: brandC.text,
        quantity: int.parse(quantityC.text),
        imagesUrl: imageUrls,
        isOnSale: isSale,
        isPopular: isPopular,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Add Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              Container(
                decoration: decoration(),
                child: DropdownButtonFormField(
                    validator: (String v) {
                      if (v.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('select category'),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    // value: categories[0].name,
                    items: categories
                        .map((e) => DropdownMenuItem(
                            value: e.name,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(e.name),
                            )))
                        .toList(),
                    onChanged: (value) {
                      categoryC.text = value;
                      print(categoryC.text);
                    }),
              ),
              EditField(
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: productNameC,
                hint: 'Enter Product Name',
                onsubmit: (value) {
                  setState(() {});
                },
              ),
              EditField(
                lines: 5,
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: detailC,
                hint: 'Enter detail',
                onsubmit: (value) {
                  setState(() {
                    detailC.text = value;
                  });
                },
              ),
              EditField(
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: serialCode,
                hint: 'Enter serial code',
                onsubmit: (value) {
                  setState(() {
                    serialCode.text = value;
                  });
                },
              ),
              EditField(
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: priceC,
                hint: 'Enter Price',
                onsubmit: (value) {
                  setState(() {
                    priceC.text = value;
                  });
                },
              ),
              EditField(
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: weightC,
                hint: 'Enter weight',
                onsubmit: (value) {
                  setState(() {
                    weightC.text = value;
                  });
                },
              ),
              EditField(
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: brandC,
                hint: 'Enter brand',
                onsubmit: (value) {
                  setState(() {
                    brandC.text = value;
                  });
                },
              ),
              EditField(
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: quantityC,
                hint: 'Enter quanity',
                onsubmit: (value) {
                  setState(() {
                    quantityC.text = value;
                  });
                },
              ),
              EditField(
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: onSaleC,
                hint: 'Enter sale product',
                onsubmit: (value) {
                  setState(() {
                    onSaleC.text = value;
                  });
                },
              ),
              EditField(
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: popularC,
                hint: 'Enter Popular item',
                onsubmit: (value) {
                  setState(() {
                    popularC.text = value;
                  });
                },
              ),
              EditField(
                validator: (String v) {
                  if (v.isEmpty) {
                    return 'should not be empty';
                  }
                  return null;
                },
                controller: discountC,
                hint: 'Enter discount',
                onsubmit: (value) {
                  setState(() {
                    discountC.text = value;
                  });
                },
              ),
              Container(
                height: 270,
                child: Column(children: [
                  ElevatedButton(
                    onPressed: () {
                      loadAssets();
                    },
                    child: Text('pick images'),
                  ),
                  Expanded(child: buildGridView())
                ]),
              ),
              SwitchListTile(
                  title: Text('is this product popular'),
                  value: isPopular,
                  onChanged: (v) {
                    setState(() {
                      isPopular = v;
                    });
                  }),
              SwitchListTile(
                  title: Text('is this product on sale'),
                  value: isSale,
                  onChanged: (v) {
                    setState(() {
                      isSale = v;
                    });
                  }),
              MaterialButton(
                shape: StadiumBorder(),
                onPressed: () {
                  save();

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Upload Product',
                    style: heading1,
                  ),
                ),
                color: primarycolor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  loadAssets() async {
    List<Asset> resultImages = <Asset>[];
    String error = 'something went wrong';
    try {
      resultImages = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
      );
      setState(() {
        images = resultImages;
      });
    } catch (e) {
      error = e.toString();
      print(error);
    }
  }

 Future postImages(Asset imageFile) async {
    String filename = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage db = FirebaseStorage.instance;
    await db
        .ref()
        .child("images")
        .child(filename)
        .putData((await imageFile.getByteData()).buffer.asUint8List());

    return db.ref().child("images").child(filename).getDownloadURL();
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image)
          .then((downloadUrl) => imageUrls.add(downloadUrl.toString()))
          .catchError((e) {
        print(e.toString());
      });
    }
  }

  Widget buildGridView() {
    return Container(
      width: double.infinity,
      decoration: decoration(),
      child: images.length == 0
          ? IconButton(
              onPressed: () {
                loadAssets();
              },
              icon: Icon(Icons.add),
            )
          : GridView.count(
              crossAxisCount: 4,
              children: List.generate(images.length, (index) {
                Asset asset = images[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      borderOnForeground: true,
                      clipBehavior: Clip.antiAlias,
                      elevation: 12,
                      shadowColor: primarycolor,
                      child: AssetThumb(asset: asset, width: 150, height: 150)),
                );
              })),
    );
  }
}

class EditField extends StatelessWidget {
  String hint;
  Function onsubmit;
  TextEditingController controller;
  Function validator;
  int lines;

  EditField(
      {this.hint, this.onsubmit, this.controller, this.validator, this.lines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          decoration: decoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              maxLines: lines,
              validator: validator,
              controller: controller,
              onFieldSubmitted: onsubmit,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          )),
    );
  }
}
