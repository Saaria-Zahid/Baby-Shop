import 'package:Saz/screens/search/search_delegate.dart';
import 'package:get/get.dart';

class Product {
  final int id;
  final String brand;
  final String name;
  final String image;
  final String category;
  final double price;
  final String description;
  final double salePrice;

  Product( {
    required this.id,
    required this.brand,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.salePrice,
    required this.category,
  });

  // Convert Product to Map (for storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'category': category,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'salePrice': salePrice,
    };
  }

  // Convert Map to Product (for loading)
  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      brand: map['brand'],
      category: map['category'],
      name: map['name'],
      image: map['image'],
      price: map['price'],
      description: map['description'],
      salePrice: map['salePrice'],
    );
  }
}


class ProductController extends GetxController {
  // List of products
  final products = <Product>[].obs;

  // Cart and Wishlist
  final cart = <Product>[].obs;
  final wishlist = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  final List<Brand> brands = [
 Brand(name: "Girl Apparel", ),
  Brand(name: "Boy Apparel",),
  Brand(name: "Toys",),
  Brand(name: "Action Figures", ),
];




List<Map<String, dynamic>> data = [
  // Girl Apparel Category
  {
    "id": 1,
    "category": "Girl Apparel",
    "brand": "BrandA",
    "name": "Floral Shirt",
    "image": "images/products/girl_1.jpg",
    "price": 19.99,
    "description": "A cute floral shirt for girls.",
    "salePrice": 16.99,
  },
  {
    "id": 2,
    "category": "Girl Apparel",
    "brand": "BrandB",
    "name": "Pink Shirt",
    "image": "images/products/girl_2.jpg",
    "price": 18.99,
    "description": "A soft pink shirt for casual wear.",
    "salePrice": 15.99,
  },
  {
    "id": 3,
    "category": "Girl Apparel",
    "brand": "BrandC",
    "name": "Printed Shirt",
    "image": "images/products/girl_3.jpg",
    "price": 22.99,
    "description": "A stylish Printed shirt for girls.",
    "salePrice": 19.99,
  },
  {
    "id": 4,
    "category": "Girl Apparel",
    "brand": "BrandD",
    "name": "Denim Blue Jacket",
    "image": "images/products/girl_4.jpg",
    "price": 34.99,
    "description": "A trendy denim blue jacket for girls.",
    "salePrice": 30.99,
  },

  // Boy Apparel Category
  {
    "id": 5,
    "category": "Boy Apparel",
    "brand": "BrandE",
    "name": "Full Sleeve Shirt - Blue",
    "image": "images/products/boy_1.jpg",
    "price": 24.99,
    "description": "A comfortable full-sleeve shirt for boys.",
    "salePrice": 21.99,
  },
  {
    "id": 6,
    "category": "Boy Apparel",
    "brand": "BrandF",
    "name": "Full Sleeve Shirt - Green",
    "image": "images/products/boy_2.jpg",
    "price": 26.99,
    "description": "A stylish full-sleeve shirt for boys.",
    "salePrice": 22.99,
  },
  {
    "id": 7,
    "category": "Boy Apparel",
    "brand": "BrandG",
    "name": "Denim Jacket - Blue",
    "image": "images/products/boy_3.jpg",
    "price": 39.99,
    "description": "A cool blue denim jacket for boys.",
    "salePrice": 35.99,
  },
  {
    "id": 8,
    "category": "Boy Apparel",
    "brand": "BrandH",
    "name": "Denim Jacket - Black",
    "image": "images/products/boy_4.jpg",
    "price": 42.99,
    "description": "A stylish black denim jacket for boys.",
    "salePrice": 38.99,
  },

  // Toys Category
  {
    "id": 9,
    "category": "Toys",
    "brand": "ToyBrandA",
    "name": "Cooking Set",
    "image": "images/products/toy_5.jpg",
    "price": 19.99,
    "description": "A fun building blocks set for kids.",
    "salePrice": 16.99,
  },
  {
    "id": 10,
    "category": "Toys",
    "brand": "ToyBrandB",
    "name": "Toy Kitchen Set",
    "image": "images/products/toy_6.jpg",
    "price": 14.99,
    "description": "A cool toy car set for kids.",
    "salePrice": 12.99,
  },
  {
    "id": 11,
    "category": "Toys",
    "brand": "ToyBrandC",
    "name": "Toy Set",
    "image": "images/products/toy_7.jpg",
    "price": 24.99,
    "description": "A set of action figures for imaginative play.",
    "salePrice": 22.99,
  },
  {
    "id": 12,
    "category": "Toys",
    "brand": "ToyBrandD",
    "name": "Doll Set",
    "image": "images/products/toy_8.jpg",
    "price": 22.99,
    "description": "A beautiful doll set with accessories.",
    "salePrice": 20.99,
  },

  // Action Figures Category
  {
    "id": 13,
    "category": "Action Figures",
    "brand": "FigureBrandA",
    "name": "Thanos Action Figure",
    "image": "images/products/toy_3.jpg",
    "price": 19.99,
    "description": "Thanos action figure with movable joints.",
    "salePrice": 17.99,
  },
  {
    "id": 14,
    "category": "Action Figures",
    "brand": "FigureBrandB",
    "name": "Spider-Man Action Figure",
    "image": "images/products/toy_2.jpg",
    "price": 22.99,
    "description": "Spider-Man action figure with accessories.",
    "salePrice": 19.99,
  },
  {
    "id": 15,
    "category": "Action Figures",
    "brand": "FigureBrandC",
    "name": "Captain America Action Figure",
    "image": "images/products/toy_1.jpg",
    "price": 24.99,
    "description": "Captain America action figure with shield.",
    "salePrice": 21.99,
  },
  {
    "id": 16,
    "category": "Action Figures",
    "brand": "FigureBrandD",
    "name": "Avengers Marvel Action Figure Set",
    "image": "images/products/toy_4.jpg",
    "price": 59.99,
    "description": "Complete Avengers action figure set.",
    "salePrice": 54.99,
  },
];


  // Load products into the list
void loadProducts() {
  // Loop through the data list and add each baby to the products list
  data.forEach((baby) {
    products.add(
      Product(
        id: baby['id'],
        brand: baby['brand'],
        category: baby['category'],
        name: baby['name'],
        image: baby['image'],
        price: baby['price'],
        description: baby['description'],
        salePrice: baby['salePrice'],
      ),
    );
  });
}


  // Add to cart
  void addToCart(Product product) {
    if (!cart.contains(product)) {
      cart.add(product);
    } else {
      Get.snackbar("Info", "Product already in cart!");
    }
  }

  // Remove from cart
  void removeFromCart(Product product) {
    cart.remove(product);
  }

  // Add to wishlist
  void addToWishlist(Product product) {
    if (!wishlist.contains(product)) {
      wishlist.add(product);
    } else {
      Get.snackbar("Info", "Product already in wishlist!");
    }
  }

  // Remove from wishlist
  void removeFromWishlist(Product product) {
    wishlist.remove(product);
  }
}
