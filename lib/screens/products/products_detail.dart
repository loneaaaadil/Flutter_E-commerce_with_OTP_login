import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopbiz/utils/constants.dart';
import 'package:shopbiz/utils/custom_colors.dart';
import 'package:shopbiz/utils/decoration.dart';
import 'package:shopbiz/utils/text_Style.dart';

class ProductDetailPage extends StatefulWidget {
  static const id = "/productdetail";

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedIndex = 0;
  int quan = 1;

  var quant;

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<dynamic, dynamic>;

    var name = data['productname'];
    var description = data['description'];
    var brand = data['brand'];
    List images = data['images'];
    var isOnSale = data['isOnSale'];
    var isPopular = data['isPopular'];
    var price = data['price'];
    var quantity = data['quantity'];
    var serialCode = data['serialCode'];
    var weight = data['weight'];

     String phone;
    getphone() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      phone = prefs.getString('phone');
      print("okk $phone");
      return phone;
    }

    getphone();

    savecart() async {
      await FirebaseFirestore.instance.collection('cart').add({
        'phone': phone,
        'title': name,
        'quantity': quan,
        'price': price * quan,
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 300,
                      child: Image(
                        image: CachedNetworkImageProvider(
                          images[selectedIndex],
                        ),
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                      top: 20,
                      left: 0,
                      child: Container(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            )),
                      )),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...List.generate(
                    images.length,
                    (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            print(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(),
                              // color: Colors.black,
                            ),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image(
                                image: CachedNetworkImageProvider(
                                  images[index],
                                ),
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )),
                  ),
                ]),
              ),
              Container(
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    shadowColor: Colors.grey,
                    // clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child:
                                  FavoriteButton(valueChanged: (_isFavorite) {
                                print('Is Favorite $_isFavorite');
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     'DECORATION',
              //     style: TextStyle(
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold,
              //         fontStyle: FontStyle.italic),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  // height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.deepPurple.withOpacity(0.3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        isOnSale ? "ON SALE" : "OUT OF STOCK",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                      Text(
                        'JUST ONLY : ${price} Rs',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minWidth: double.infinity,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return StatefulBuilder(
                            builder: (context, StateSetter setState) {
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Purchase $name".toUpperCase(),
                                        style: heading2,
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text('Enter Quantity'),
                                              Text("max $quantity"),
                                            ],
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (quan > quantity - 1) {
                                                    displayMessage(
                                                        'you can not exceed this limit');
                                                  } else {
                                                    quan++;
                                                  }
                                                });
                                              },
                                              icon: Icon(Icons.add)),
                                          Text("$quan"),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (quan > 1) quan--;
                                                });
                                              },
                                              icon: Icon(Icons.remove))
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Text("CONFIRM")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("CANCEL")),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  },
                  color: Colors.green,
                  child: Text(
                    "BUY NOW",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
