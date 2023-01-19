import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  // const BottomContainer({Key? key}) : super(key: key);
  final String image;
  final String name;
  final int price;
  final VoidCallback onTap;
  BottomContainer({required this.name,required this.image,required this.price,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 270,
        width: 220,
        decoration: BoxDecoration(
          color: Color(0xff3a3e3e),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(image),
            ),
            ListTile(
              leading: Text(
                name,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              trailing: Text(
                "\$ $price",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
