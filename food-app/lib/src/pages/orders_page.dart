import 'package:flutter/material.dart';
import 'package:food_app_flutter_zone/src/scoped-model/main_model.dart';
import 'package:food_app_flutter_zone/src/widgets/orders_card.dart';
import 'package:scoped_model/scoped_model.dart';

class OrdersPage extends StatefulWidget {

final MainModel model;
OrdersPage({this.model});
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

   GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();

   @override
  void initState() {
    widget.model.fetchOrder();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _explorePageScaffoldKey,
      backgroundColor: Colors.white,
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext sctx, Widget child, MainModel model) {
          //model.fetchFoods(); // this will fetch and notifylisteners()
          // List<Food> foods = model.foods;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: model.orderLength,
              itemBuilder: (BuildContext lctx, int index) {
                return GestureDetector(
                  child: OrdersCard(address: model.order[index].address,id: model.order[index].id,amount: model.order[index].total,),
                  
                );
              },
            ),
          );
        },
      ),
    );
      
  }
}