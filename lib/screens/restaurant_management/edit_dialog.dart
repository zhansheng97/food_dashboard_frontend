import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_dashboard/constants.dart';
import 'package:food_dashboard/datasources/api_client/http_client.dart';
import 'package:food_dashboard/datasources/service/restaurant_service_contract.dart';
import 'package:food_dashboard/datasources/service/restaurant_service_impl.dart';
import 'package:food_dashboard/di/get_it.dart';
import 'package:food_dashboard/domain/entities/restaurant.dart';
import 'package:food_dashboard/widgets/custom_text_button.dart';
import 'package:food_dashboard/widgets/form_title_and_field.dart';
import 'package:food_dashboard/widgets/restaurant_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'dart:html' as html;
import 'package:path/path.dart' as Path;

class EditDialog extends StatefulWidget {
  final Restaurant? restaurant;

  const EditDialog({Key? key, this.restaurant}) : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  html.File? _cloudFile;
  Uint8List? _fileBytes;
  String? name;
  String? category;
  String? rating;
  String? price;
  String? distance;
  String? image;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showSelectFileMessage = false;
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController ratingController;
  late TextEditingController priceController;
  late TextEditingController distanceController;

  Future<void> _pickImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    String mimeType = mime(Path.basename(mediaData.fileName!))!;
    html.File mediaFile =
        new html.File(mediaData.data!, mediaData.fileName!, {'type': mimeType});

    setState(() {
      _cloudFile = mediaFile;
      _fileBytes = mediaData.data;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    categoryController = TextEditingController();
    ratingController = TextEditingController();
    priceController = TextEditingController();
    distanceController = TextEditingController();
    if (widget.restaurant != null) {
      //* ---------------------------------
      //* Assign restaurant properties value
      //* ---------------------------------
      name = widget.restaurant?.name;
      category = widget.restaurant?.resType;
      rating = widget.restaurant?.rating;
      price = widget.restaurant?.price;
      distance = widget.restaurant?.distance;
      image = widget.restaurant?.imageUrl;

      //* ---------------------------------------
      //* Assign textfield with the default value
      //* ---------------------------------------

      nameController.text = name!;
      categoryController.text = category!;
      ratingController.text = rating!;
      priceController.text = price!;
      distanceController.text = distance!;
    }
  }

  final restaurantService = getIt<IRestaurantService>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Form(
          key: formKey,
          child: Container(
            width: 750,
            // height: 700,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Update Restaurant",
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: kdefaultPadding),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: nameController,
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    name = value;
                                  },
                                  title: "Name",
                                  hintText: "Enter a name",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: categoryController,
                                  onChanged: (value) {
                                    setState(() {
                                      category = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    category = value;
                                  },
                                  title: "Category",
                                  hintText: "Cafe / Bars / Asian ...",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: ratingController,
                                  onChanged: (value) {
                                    setState(() {
                                      rating = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    rating = value;
                                  },
                                  title: "Rating",
                                  hintText: "Rate the restaurant ! (0 - 5)",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: priceController,
                                  onChanged: (value) {
                                    setState(() {
                                      price = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    price = value;
                                  },
                                  title: "Price",
                                  hintText:
                                      "Enter the average food price of the restaurant",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: distanceController,
                                  onChanged: (value) {
                                    setState(() {
                                      distance = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    distance = value;
                                  },
                                  title: "Distance",
                                  hintText: "Enter the distance",
                                  suffixText: "km",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 50),
                          Material(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            color: Colors.pink.withOpacity(0.2),
                            child: Container(
                              height: 275,
                              width: 220,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                      width: 180,
                                      child: AspectRatio(
                                        aspectRatio: 1.8,
                                        child: _cloudFile != null
                                            ? Image.memory(_fileBytes!,
                                                fit: BoxFit.cover)
                                            : (image != null)
                                                ? Image.network(
                                                    image!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    cachedRestaurantList[0]
                                                        .imageUrl,
                                                    fit: BoxFit.cover,
                                                  ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        (name == null || name == "")
                                            ? cachedRestaurantList[0].name
                                            : name!,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        (category == null || category == "")
                                            ? cachedRestaurantList[0].resType
                                            : category!,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 50,
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                (rating == null || rating == "")
                                                    ? cachedRestaurantList[0]
                                                        .rating
                                                    : rating!,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                          CustomDivider(height: 40),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  CurrencyIcon(size: 10),
                                                  CurrencyIcon(
                                                      size: 10,
                                                      color:
                                                          Colors.grey.shade600),
                                                  CurrencyIcon(
                                                      size: 10,
                                                      color:
                                                          Colors.grey.shade600),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                (price == null || price == "")
                                                    ? cachedRestaurantList[0]
                                                        .price
                                                    : price!,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                          CustomDivider(height: 40),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "km",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                (distance == null ||
                                                        distance == "")
                                                    ? cachedRestaurantList[0]
                                                        .distance
                                                    : distance!,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Image",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[400],
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                _pickImage();
                                if (showSelectFileMessage == true) {
                                  setState(() {
                                    showSelectFileMessage = false;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  "Select a file",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          _cloudFile == null
                              ? Text(
                                  "No File Chosen",
                                  style: TextStyle(fontSize: 14),
                                )
                              : Expanded(
                                  child: Text(
                                    _cloudFile!.name,
                                    style: TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                        ],
                      ),
                      (showSelectFileMessage)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "Please select a file",
                                style: TextStyle(
                                    fontSize: 12.5, color: Colors.red[700]),
                              ),
                            )
                          : SizedBox.shrink(),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextButton(
                          text: "Update",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              Restaurant restaurant = Restaurant(
                                imageUrl: image!,
                                name: name!,
                                resType: category!,
                                rating: rating!,
                                price: price!,
                                distance: distance!,
                              );

                              if (_cloudFile != null) {
                                restaurantService.updateRestaurant(
                                  widget.restaurant!.id!,
                                  restaurant,
                                  _fileBytes,
                                  _cloudFile,
                                );
                              } else {
                                restaurantService.updateRestaurant(
                                    widget.restaurant!.id!,
                                    restaurant,
                                    null,
                                    null);
                              }

                              Navigator.pop(context);
                            } else {
                              // setState(() {
                              //   showSelectFileMessage = true;
                              // });
                              print("fill in all");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
