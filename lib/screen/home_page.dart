import 'package:flutter/material.dart';
import 'package:food_app/modles/categories_modle.dart';
import 'package:food_app/modles/food_modle.dart';
import 'package:food_app/provider/my_provider.dart';
import 'package:food_app/screen/detail_page.dart';
import 'package:food_app/screen/welcome_page.dart';
import 'package:food_app/screen/widget/bottom_Container.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../modles/food_categories_modle.dart';
import 'categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseAuth auth;
  late final User user;
  late final userid;
  String name="error";
  String email="error";
  List<CategoriesModle> burgerList = [];
  List<CategoriesModle> recipeList = [];
  List<CategoriesModle> pizzaList = [];
  List<CategoriesModle> drinkList = [];
  List<FoodModle> singleFoodList = [];
  List<FoodCategoriesModle> burgerCategoriesList = [];
  List<FoodCategoriesModle> recipeCategoriesList = [];
  List<FoodCategoriesModle> pizzaCategoriesList = [];
  List<FoodCategoriesModle> drinkCategoriesList = [];

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget categoriesContainer(
      {required String image,
      required String name,
      required VoidCallback? onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(left: 20),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }

  Widget drawerItem({required String name, required IconData icon}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget burger() {
    return Row(
      children: burgerList
          .map((e) => categoriesContainer(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(
                      list: burgerCategoriesList,
                    ),
                  ),
                );
              },
              image: e.image,
              name: e.name))
          .toList(),
    );
  }

  Widget recipe() {
    return Row(
      children: recipeList
          .map((e) => categoriesContainer(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(
                      list: recipeCategoriesList,
                    ),
                  ),
                );
              },
              image: e.image,
              name: e.name))
          .toList(),
    );
  }

  Widget pizza() {
    return Row(
      children: pizzaList
          .map((e) => categoriesContainer(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(
                      list: pizzaCategoriesList,
                    ),
                  ),
                );
              },
              image: e.image,
              name: e.name))
          .toList(),
    );
  }

  Widget drink() {
    return Row(
      children: drinkList
          .map((e) => categoriesContainer(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Categories(
                      list: drinkCategoriesList,
                    ),
                  ),
                );
              },
              image: e.image,
              name: e.name))
          .toList(),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    user = ( auth.currentUser)!;
    email=user.email!;
    userid=user.uid!;
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.getBurgerCategory();
    burgerList = provider.throwBurgerList;

    provider.getRecipeCategory();
    recipeList = provider.throwRecipeList;

    provider.getPizzaCategory();
    pizzaList = provider.throwPizzaList;

    provider.getDrinkCategory();
    drinkList = provider.throwDrinkList;

    provider.getFoodList();
    singleFoodList = provider.throwFoodModleList;

    provider.getBurgerCategoriesList();
    burgerCategoriesList = provider.throwBurgerCategoriesList;
    provider.getrecipeCategoriesList();
    recipeCategoriesList = provider.throwRecipeCategoriesList;
    provider.getPizzaCategoriesList();
    pizzaCategoriesList = provider.throwPizzaCategoriesList;
    provider.getDrinkCategoriesList();
    drinkCategoriesList = provider.throwDrinkCategoriesList;

    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xff2b2b2b),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/logo.jpg'),
                  ),
                  accountName: Text(userid),
                  accountEmail: Text(email),
                ),
                drawerItem(name: "Profile", icon: Icons.person),
                drawerItem(name: "Cart", icon: Icons.shopping_cart),
                drawerItem(name: "Order", icon: Icons.shop),
                Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Comunicate",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                drawerItem(name: "Change", icon: Icons.lock),
                GestureDetector(
                  onTap: (){
                    _signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => WelcomePage()));
                  },
                    child: drawerItem(name: "logout", icon: Icons.exit_to_app)),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        // leading: Icon(Icons.sort),
        actions: [
          Padding(
            padding: EdgeInsets.all(9.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/logo.jpg'),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  fillColor: Color(0xff3a3e3e),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                burger(),
                pizza(),
                drink(),
                recipe(),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 510,
              child: GridView.count(
                shrinkWrap: false,
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: singleFoodList
                    .map((e) => BottomContainer(
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          image: e.image,
                          name: e.name,
                          price: e.price,
                        ),
                      ),
                    );
                  },
                        image: e.image, price: e.price, name: e.name))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
