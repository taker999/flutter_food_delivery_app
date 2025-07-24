import 'package:cloud_firestore/cloud_firestore.dart';
import '../../pages/restaurant_details/model/food_item.dart';
import '../../pages/home/model/restaurant.dart';

class RestaurantService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Restaurant>> getAllRestaurants() async {
    final restaurantSnapshots =
        await _firestore.collection('restaurants').get();

    List<Restaurant> restaurants = [];

    for (final doc in restaurantSnapshots.docs) {
      final data = doc.data();

      restaurants.add(Restaurant.fromMap(data));
    }

    return restaurants;
  }

  Future<List<FoodItem>> getFoodItems(String restaurantId) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('restaurants')
            .doc(restaurantId)
            .collection('foodItems')
            .get();

    return snapshot.docs.map((doc) {
      return FoodItem.fromMap(doc.data());
    }).toList();
  }
}

// to upload dummy data
// Future<void> uploadDummyData() async {
//   final dummyRestaurants = [
//     Restaurant(
//       id: '1',
//       name: 'Pizza Palace',
//       description: 'Best wood-fired pizzas in town',
//       imageUrl:
//       'https://content.jdmagicbox.com/comp/kolkata/s7/033pxx33.xx33.211113092058.u2s7/catalogue/the-pizza-palace-tiljala-kolkata-pizza-delivery-services-9qd36j1bd3.jpg',
//       rating: 4.5,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'Pepperoni Pizza',
//           price: 299,
//           imageUrl:
//           'https://www.cobsbread.com/us/wp-content//uploads/2022/09/Pepperoni-pizza-850x630-1.png',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Margherita Pizza',
//           price: 249,
//           imageUrl:
//           'https://www.tasteofhome.com/wp-content/uploads/2024/03/Margherita-Pizza-_EXPS_TOHVP24_275515_MF_02_28_1.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Veggie Supreme',
//           price: 270,
//           imageUrl:
//           'https://api.pizzahut.io/v1/content/en-in/in-1/images/pizza/veggie-supreme.4bbddf98eccea9929192db1494ba3678.1.jpg',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'BBQ Chicken Pizza',
//           price: 310,
//           imageUrl:
//           'https://www.allrecipes.com/thmb/qZ7LKGV1_RYDCgYGSgfMn40nmks=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/AR-24878-bbq-chicken-pizza-beauty-4x3-39cd80585ad04941914dca4bd82eae3d.jpg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Cheese Burst',
//           price: 280,
//           imageUrl:
//           'https://media-assets.swiggy.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/RX_THUMBNAIL/IMAGES/VENDOR/2025/1/26/9ecbf4a6-a9ed-4853-ad48-94a7ffd9434e_830536.jpg',
//         ),
//       ],
//     ),
//     Restaurant(
//       id: '2',
//       name: 'Burger Barn',
//       description: 'Juicy burgers and crispy fries',
//       imageUrl:
//       'https://static.spotapps.co/website_images/ab_websites/109718_website/about_us_left.jpg',
//       rating: 4.2,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'Cheeseburger',
//           price: 199,
//           imageUrl:
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Cheeseburger.jpg/1200px-Cheeseburger.jpg',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Chicken Burger',
//           price: 179,
//           imageUrl:
//           'https://www.thecookingcollective.com.au/wp-content/uploads/2025/03/chicken-burgers-5-of-14.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Veggie Burger',
//           price: 159,
//           imageUrl:
//           'https://www.noracooks.com/wp-content/uploads/2023/04/veggie-burgers-1-2.jpg',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'Double Patty Burger',
//           price: 229,
//           imageUrl:
//           'https://images.ctfassets.net/0dkgxhks0leg/2sDFsZYlCbQR7k6RrEQhCd/78f5176201067ff7fd6480adfcb80188/Double_Dilly_Smashburger_with_fries.jpg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Fries',
//           price: 99,
//           imageUrl:
//           'https://www.awesomecuisine.com/wp-content/uploads/2009/05/french-fries.jpg',
//         ),
//       ],
//     ),
//     Restaurant(
//       id: '3',
//       name: 'Curry Kingdom',
//       description: 'Traditional Indian curries',
//       imageUrl:
//       'https://b.zmtcdn.com/data/pictures/4/20985294/00dd6f35465960dcc5c5e6b5185f4780_featured_v2.jpg',
//       rating: 4.6,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'Butter Chicken',
//           price: 220,
//           imageUrl:
//           'https://www.mysavoryadventures.com/wp-content/uploads/2023/04/restaurant-style-butter-chicken.jpg',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Paneer Masala',
//           price: 200,
//           imageUrl:
//           'https://www.mygingergarlickitchen.com/wp-content/uploads/2024/09/paneer-masala-3.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Chicken Tikka Masala',
//           price: 240,
//           imageUrl:
//           'https://www.seriouseats.com/thmb/DbQHUK2yNCALBnZE-H1M2AKLkok=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chicken-tikka-masala-for-the-grill-recipe-hero-2_1-cb493f49e30140efbffec162d5f2d1d7.JPG',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'Dal Makhani',
//           price: 180,
//           imageUrl:
//           'https://www.funfoodfrolic.com/wp-content/uploads/2023/04/Dal-Makhani-Blog-500x500.jpg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Garlic Naan',
//           price: 40,
//           imageUrl:
//           'https://hostthetoast.com/wp-content/uploads/2018/08/naan-202-320x320-1.jpg',
//         ),
//       ],
//     ),
//     Restaurant(
//       id: '4',
//       name: 'Sushi World',
//       description: 'Fresh and authentic sushi',
//       imageUrl:
//       'https://media-cdn.tripadvisor.com/media/photo-s/12/ee/2c/00/welcome-to-sushi-world.jpg',
//       rating: 4.8,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'California Roll',
//           price: 320,
//           imageUrl:
//           'https://www.cheaprecipeblog.com/wp-content/uploads/2021/06/How-to-make-cheap-California-rolls-720x540.jpg',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Salmon Nigiri',
//           price: 350,
//           imageUrl:
//           'https://www.craftycookbook.com/wp-content/uploads/2024/04/nigiri-sushi-1200-500x500.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Tuna Maki',
//           price: 300,
//           imageUrl:
//           'https://www.tiger-corporation.com/wp-content/uploads/2023/02/hero-img-recipe-tekka-maki-b2c600cf500bd3fd7f0702c5fc0e0e15.jpg',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'Tempura Roll',
//           price: 330,
//           imageUrl:
//           'https://cookingwithayeh.com/wp-content/uploads/2024/07/Shrimp-Tempura-Roll-SQ-4.jpg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Avocado Roll',
//           price: 280,
//           imageUrl:
//           'https://chefjacooks.com/wp-content/uploads/2023/07/avocado-roll-square.jpg',
//         ),
//       ],
//     ),
//     Restaurant(
//       id: '5',
//       name: 'Taco Town',
//       description: 'Delicious Mexican tacos',
//       imageUrl:
//       'https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=600,height=400,format=auto,quality=80/https://doordash-static.s3.amazonaws.com/media/store/header/a17bba36-aeaf-4e51-93a2-3134e5d0af2a.jpg',
//       rating: 4.3,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'Beef Taco',
//           price: 180,
//           imageUrl:
//           'https://www.onceuponachef.com/images/2023/08/Beef-Tacos.jpg',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Veggie Taco',
//           price: 150,
//           imageUrl:
//           'https://www.inspiredtaste.net/wp-content/uploads/2016/10/Veggie-Tacos-Recipe-6.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Chicken Quesadilla',
//           price: 190,
//           imageUrl:
//           'https://www.julieseatsandtreats.com/wp-content/uploads/2024/10/Chicken-Quesadilla-Square.jpg',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'Nachos with Cheese',
//           price: 140,
//           imageUrl:
//           'https://www.tastyrewards.com/sites/default/files/2024-01/Ultimate%20Four%20Cheese%20Nachos.jpg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Guacamole Dip',
//           price: 80,
//           imageUrl:
//           'https://www.allrecipes.com/thmb/FOHqtfrZVg0WAMdkFE3bnp7SNO4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/AR-RM-14064-easy-guacamole-ddmfs-3x4-9e4a1eb1bb34421a99db675b53a29e53.jpg',
//         ),
//       ],
//     ),
//     Restaurant(
//       id: '6',
//       name: 'Pasta Point',
//       description: 'Pasta that hits the spot',
//       imageUrl:
//       'https://tb-static.uber.com/prod/image-proc/processed_images/2dabc85b161a7f094cd362f623ea0343/df577d3a0807d3bb859f2fb53aefcd86.jpeg',
//       rating: 4.4,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'Spaghetti Bolognese',
//           price: 240,
//           imageUrl:
//           'https://www.recipetineats.com/tachyon/2018/07/Spaghetti-Bolognese.jpg',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Penne Alfredo',
//           price: 230,
//           imageUrl:
//           'https://www.licious.in/blog/wp-content/uploads/2020/12/Penne-Alfredo.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Mac & Cheese',
//           price: 200,
//           imageUrl:
//           'https://www.onceuponachef.com/images/2024/06/Mac-and-Cheese-17-1200x1800.jpg',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'Fusilli Arrabiata',
//           price: 220,
//           imageUrl:
//           'https://seasonandthyme.com/wp-content/uploads/2022/01/spicy-fusilli-arrabiata-2-683x1024.jpeg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Garlic Bread',
//           price: 90,
//           imageUrl:
//           'https://www.simplyrecipes.com/thmb/5JwdiUjcSPTxyuhmdqv8pM8kWs0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Garlic-Bread-METHOD-2-3-1c5f5cfa8bf6408c84c0596eea83f8e8.jpg',
//         ),
//       ],
//     ),
//     Restaurant(
//       id: '7',
//       name: 'Biryani Bowl',
//       description: 'Rich and aromatic biryanis',
//       imageUrl:
//       'https://tb-static.uber.com/prod/image-proc/processed_images/b56d8d01dcba33cfb8c143cc24ca20f8/4eed3468b168fc6e31dff0bb81a347bc.jpeg',
//       rating: 4.7,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'Chicken Biryani',
//           price: 250,
//           imageUrl:
//           'https://www.licious.in/blog/wp-content/uploads/2022/06/chicken-hyderabadi-biryani-01-750x750.jpg',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Veg Biryani',
//           price: 220,
//           imageUrl:
//           'https://www.madhuseverydayindian.com/wp-content/uploads/2022/11/easy-vegetable-biryani.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Mutton Biryani',
//           price: 280,
//           imageUrl:
//           'https://www.licious.in/blog/wp-content/uploads/2019/11/Mutton-Biryani-1-750x750.jpg',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'Raita',
//           price: 30,
//           imageUrl:
//           'https://www.indianhealthyrecipes.com/wp-content/uploads/2022/02/raita-recipes.jpg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Egg Biryani',
//           price: 240,
//           imageUrl:
//           'https://palatesdesire.com/wp-content/uploads/2022/05/Egg-biryani-recipe@palates-desire.jpg',
//         ),
//       ],
//     ),
//     Restaurant(
//       id: '8',
//       name: 'Wraps & Rolls',
//       description: 'Tasty street-style wraps',
//       imageUrl:
//       'https://content.jdmagicbox.com/comp/kolkata/b4/033pxx33.xx33.210811093606.x2b4/catalogue/faasos-wraps-and-rolls-shyambazar-kolkata-fast-food-delivery-services-0glskehekn.jpg',
//       rating: 4.1,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'Paneer Roll',
//           price: 120,
//           imageUrl:
//           'https://spicecravings.com/wp-content/uploads/2020/12/Paneer-kathi-Roll-Featured-1.jpg',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Egg Roll',
//           price: 100,
//           imageUrl:
//           'https://static01.nyt.com/images/2024/01/10/multimedia/nd-egg-rolls-jgqc/nd-egg-rolls-jgqc-mediumSquareAt3X.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Chicken Roll',
//           price: 130,
//           imageUrl: 'https://i.ytimg.com/vi/NfQ7p_LzpUA/maxresdefault.jpg',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'Aloo Tikki Wrap',
//           price: 90,
//           imageUrl:
//           'https://vegplatter.in/files/public/images/partner/catalog/154/Protein%20Wrap0.jpg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Veg Frankie',
//           price: 110,
//           imageUrl:
//           'https://d1mxd7n691o8sz.cloudfront.net/static/recipe/recipe/2023-01/Vegetable_Frankie-fa94e3b43c914757bded445420e2519e_thumbnail_1675163626-65.jpg',
//         ),
//       ],
//     ),
//     Restaurant(
//       id: '9',
//       name: 'The Sweet Spot',
//       description: 'Cakes, mousses, and more',
//       imageUrl:
//       'https://heresthedish.com/wp-content/uploads/2023/08/20230812_104050-edited.jpg',
//       rating: 4.6,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'Chocolate Cake',
//           price: 150,
//           imageUrl:
//           'https://bluebowlrecipes.com/wp-content/uploads/2023/08/chocolate-truffle-cake-8844.jpg',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Strawberry Mousse',
//           price: 170,
//           imageUrl:
//           'https://fullofplants.com/wp-content/uploads/2018/04/light-and-fluffy-aquafaba-strawberry-mousse-vegan-gluten-free-thumb-10-500x500.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Black Forest Cake',
//           price: 180,
//           imageUrl:
//           'https://ichef.bbci.co.uk/food/ic/food_16x9_448/recipes/black_forest_gateau_43895_16x9.jpg',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'Cupcake Box (6)',
//           price: 200,
//           imageUrl:
//           'https://cpimg.tistatic.com/5424328/b/4/6-cupcake-box-pink-open.jpg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Choco Lava Cake',
//           price: 160,
//           imageUrl:
//           'https://5.imimg.com/data5/SELLER/Default/2024/5/416116214/ZW/QX/PC/132900754/chocolava-cake-500x500.jpeg',
//         ),
//       ],
//     ),
//     Restaurant(
//       id: '10',
//       name: 'Chinese Corner',
//       description: 'Spicy Chinese delights',
//       imageUrl:
//       'https://www.panchkulahelp.com/wp-content/uploads/2024/04/Best-Chinese-restaurant-in-Chandigarh.jpeg',
//       rating: 4.5,
//       foodItems: [
//         FoodItem(
//           id: '1',
//           name: 'Hakka Noodles',
//           price: 160,
//           imageUrl:
//           'https://www.cubesnjuliennes.com/wp-content/uploads/2020/06/Spicy-Chicken-Hakka-Noodles-Recipe.jpg',
//         ),
//         FoodItem(
//           id: '2',
//           name: 'Manchurian',
//           price: 180,
//           imageUrl:
//           'https://www.indianveggiedelight.com/wp-content/uploads/2017/06/gobi-manchurian-featured-500x500.jpg',
//         ),
//         FoodItem(
//           id: '3',
//           name: 'Spring Rolls',
//           price: 130,
//           imageUrl:
//           'https://www.giallozafferano.com/images/276-27601/Chinese-Spring-Rolls_1200x800.jpg',
//         ),
//         FoodItem(
//           id: '4',
//           name: 'Schezwan Rice',
//           price: 170,
//           imageUrl:
//           'https://atanurrannagharrecipe.com/wp-content/uploads/2023/04/Chicken-Schezwan-Fried-Rice.jpg',
//         ),
//         FoodItem(
//           id: '5',
//           name: 'Chili Paneer',
//           price: 200,
//           imageUrl:
//           'https://www.cookwithmanali.com/wp-content/uploads/2016/01/Chilli-Paneer-Restaurant-Style-500x500.jpg',
//         ),
//       ],
//     ),
//   ];
//
//   for (final restaurant in dummyRestaurants) {
//     final restDoc = _firestore.collection('restaurants').doc();
//     await restDoc.set({
//       'id': restaurant.id,
//       'name': restaurant.name,
//       'description': restaurant.description,
//       'rating': restaurant.rating,
//       'imageUrl': restaurant.imageUrl,
//     });
//
//     for (final food in restaurant.foodItems) {
//       await restDoc.collection('foodItems').doc().set({
//         'id': food.id,
//         'name': food.name,
//         'price': food.price,
//         'imageUrl': food.imageUrl,
//       });
//     }
//   }
//
//   log('Dummy data with images uploaded.');
// }
