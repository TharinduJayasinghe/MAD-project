import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/models/cart_model.dart';
import 'package:food_app_flutter_zone/src/pages/ordering.dart';
import 'package:food_app_flutter_zone/src/pages/sigin_page.dart';
import 'package:food_app_flutter_zone/src/scoped-model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/order_card.dart';

class OrderPage extends StatefulWidget {

final MainModel model;

OrderPage({this.model});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
double total;
  @override
  void initState() {
    widget.model.fetchCart();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ScopedModelDescendant<MainModel>
          (
          builder: (BuildContext context, Widget child, MainModel model) {
              return Column(
                children: model.cart.map(_buildFoodItems).toList(),
              );
          },
          ),
        ],
      ),
      bottomNavigationBar: _buildTotalContainer(),
    );
  }

  Widget _buildTotalContainer() {
    return Container(
      height: 220.0,
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Column(
        children: <Widget>[
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
              
          //     Text(
          //       "Subtotal",
          //       style: TextStyle(
          //           color: Color(0xFF9BA7C6),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       "23.0",
          //       style: TextStyle(
          //           color: Color(0xFF6C6D6D),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10.0,
          // ),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text(
          //       "Discount",
          //       style: TextStyle(
          //           color: Color(0xFF9BA7C6),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       "10.0",
          //       style: TextStyle(
          //           color: Color(0xFF6C6D6D),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10.0,
          // ),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text(
          //       "Tax",
          //       style: TextStyle(
          //           color: Color(0xFF9BA7C6),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //     Text(
          //       "0.5",
          //       style: TextStyle(
          //           color: Color(0xFF6C6D6D),
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            height: 2.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Cart Total",
                style: TextStyle(
                    color: Color(0xFF9BA7C6),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "$total",
                style: TextStyle(
                    color: Color(0xFF6C6D6D),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext sctx, Widget child, MainModel model) {
                    return  GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Ordering(total: total,)));
              },
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Center(
                  child: Text(
                    "Proceed To Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
      
    );
  }

  Widget _buildFoodItems(Cart cart) {
    total = cart.qnt * cart.price;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: OrderCard(
          name: cart.title,
          perice: cart.price,
          qnt: cart.qnt,
        ),
        
      ),
    );
  }
}
