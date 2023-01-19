import 'package:flutter/material.dart';
import 'package:food_app/provider/my_provider.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  Widget cartItem({
    required String image,
    required String name,
    required int price,
    required VoidCallback onTap,
    required int quantity,
  }) {
    return Row(
      children: [
        Container(
          width: 170,
          height: 170,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Flexible(child: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),),
                    Flexible(child: Text(
                      "\$ $price",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),),
                    Flexible(
                      child: Row(
                        children: [
                          Text(
                            "$quantity",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: onTap,
              )
            ],
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    MyProvider provider=Provider.of<MyProvider>(context);
    int total=provider.totalprice();
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xff3a3e3e),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: (){
            final snackBar =
            SnackBar(content: Text("Order Placed worth rupees $total"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ $total",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                "Check Out",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
            // Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(itemCount: provider.cartList.length,
      itemBuilder: (ctx,index){
        provider.getDeleteIndex(index);
        return cartItem(image: provider.cartList[index].image,
            name: provider.cartList[index].name,
            price: provider.cartList[index].price,
            onTap: (){
              provider.delete();
            },
            quantity: provider.cartList[index].quantity);
      },),
    );
  }
}
