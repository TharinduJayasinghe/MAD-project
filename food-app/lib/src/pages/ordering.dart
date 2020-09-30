import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/models/cart_model.dart';
import 'package:food_app_flutter_zone/src/scoped-model/cart_model.dart';
import 'package:food_app_flutter_zone/src/scoped-model/main_model.dart';
import 'package:food_app_flutter_zone/src/widgets/button.dart';
import 'package:food_app_flutter_zone/src/widgets/show_dailog.dart';
import 'package:scoped_model/scoped_model.dart';

class Ordering extends StatefulWidget {
  final double total;

  Ordering({this.total});

  @override
  _OrderingState createState() => _OrderingState();
}

class _OrderingState extends State<Ordering> {
  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  String email;
  String address;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop(false);
          return Future.value(false);
        },
        key: _scaffoldStateKey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(
              "Place Order",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Form(
                key: _foodItemFormKey,
                child: Column(
                  children: <Widget>[
                    _buildTextFormField("Email"),
                    _buildTextFormField("Address"),
                    SizedBox(
                      height: 70.0,
                    ),
                    ScopedModelDescendant(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return GestureDetector(
                          onTap: () {
                            setState(()  {
                              Cart cart = Cart(
                                // title: title,
                                address: address,
                                mail: email,
                                total: widget.total,
                                orderDate: DateTime.now()
                                // price: widget.model.cart.,
                              );
                              CartModel cm = CartModel();
                                cm.addOrder(cart);
                             
                                Navigator.of(context).pop();
                               
                            });
                          },
                          child: Button(btnText: "Place Order"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      validator: (String value) {
        // String error
        if (value.isEmpty && hint == "Email") {
          return "The food title is required";
        }
        if (value.isEmpty && hint == "Address") {
          return "The description is required";
        }

        // if (value.isEmpty && hint == "Category") {
        //   return "The category is required";
        // }

        // if (value.isEmpty && hint == "Price") {
        //   return "The price is required";
        // }
        return "";
      },
      // onSaved: (String value) {
      //   if (hint == "Email") {
      //     email = value;
      //   }
      //   if (hint == "Address") {
      //     address = value;
      //   }
      //   //   if (hint == "Description") {
      //   //     description = value;
      //   //   }
      //   //   if (hint == "Price") {
      //   //     price = value;
      //   //   }
      //   //   if (hint == "Discount") {
      //   //     discount = value;
      //   //   }
      // },
      onChanged:(String value){
         if (hint == "Email") {
          email = value;
        }
        if (hint == "Address") {
          address = value;
        }
      } ,
    );
  }

  Widget _buildCategoryTextFormField() {
    return TextFormField();
  }
}
