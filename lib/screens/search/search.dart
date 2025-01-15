import 'package:Saz/common/widgets/appbar/appbar_screen.dart';
import 'package:Saz/common/widgets/image_text_vertical_slide/image_text_verticle_slide.dart';
import 'package:Saz/common/widgets/products/card/product_card_verticle.dart';
import 'package:Saz/controllers/product_controller.dart';
import 'package:Saz/screens/search/search_delegate.dart';
import 'package:Saz/screens/user/home_screen.dart';
import 'package:Saz/utils/constants/sizes.dart';
import 'package:Saz/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? selectedBrand;
  String searchQuery = ''; 
  bool isSearching = true; 

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final productController = Get.put(
        ProductController()); // Correctly initializing the ProductController
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: isSearching? false:true,
        leadingIcon: 
        isSearching?
        Iconsax.search_normal: null,
        title: isSearching
            ? TextField(
                onChanged: (query) {
                  setState(() {
                    searchQuery = query; // Update search query
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  border:InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle:  Theme.of(context).textTheme.headlineSmall,

                ),
              
                autofocus: true,
              )
            : Text('Search Products', style: Theme.of(context).textTheme.headlineSmall,

 ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchQuery = ''; // Reset search query when closing search
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories/Brands List View
            TSectionHeading(title: "Filter By Brands", buttonTitle: 'Clear filter',onPressed: (){
              setState(() {
              selectedBrand = null;
                
              });
            },),
                            SizedBox(height: TSizes.spaceBtwItems,),

                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productController.brands
                        .length, // Use the list of brands from ProductController
                    itemBuilder: (context, index) {
                      final brand = productController.brands[
                          index]; // Correctly fetching brand from controller
                      return Container(
                        width: MediaQuery.of(context).size.width /
                            productController
                                .brands.length, // Equal width for each item
                        child: TVerticleImageText(
                          textColor: darkMode? Colors.white: Colors.black,
                          text: brand.name, // Assuming brand has a 'name' key
                          image: brand.image, // Assuming brand has an 'image' key
                          onTap: () {
                            setState(() {
                              selectedBrand =
                                  brand.name; // Set selected brand name
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections,),
                TSectionHeading(title: "${searchQuery == null || searchQuery == ''? selectedBrand == '' || selectedBrand == null?  "All Products" : " All Products of $selectedBrand" : "Search Result For $searchQuery" }"),
                SizedBox(height: TSizes.spaceBtwItems,),

                TGridLayout(
                  itemCount: productController.data
                      .where((product) =>
                          (selectedBrand == null ||
                              product['category'] == selectedBrand) &&
                          (searchQuery.isEmpty ||
                              product['name']
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase())))
                      .toList()
                      .length,
                  itemBuilder: (context, index) {
                    final filteredProducts = productController.data
                        .where((product) =>
                            (selectedBrand == null ||
                                product['category'] == selectedBrand) &&
                            (searchQuery.isEmpty ||
                                product['name']
                                    .toLowerCase()
                                    .contains(searchQuery.toLowerCase())))
                        .toList();
                    final product = Product.fromMap(filteredProducts[index]);
                    return TProductCardVerticle(product: product);
                  },
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}
