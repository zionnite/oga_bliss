import 'package:flutter/material.dart';

import '../widget/property_widget.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 15.0,
          right: 15,
        ),
        child: ListView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              PropertyWidget(
                props_image:
                    'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                props_name: 'Newly Built House',
                props_type: 'buy',
                props_price: '10000000',
                isFav: false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '10',
              ),
              PropertyWidget(
                props_image:
                    'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                props_name: 'Newly Built House',
                props_type: 'buy',
                props_price: '10000000',
                isFav: false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '10',
              ),
              PropertyWidget(
                props_image:
                    'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                props_name: 'Newly Built House',
                props_type: 'buy',
                props_price: '10000000',
                isFav: false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '10',
              ),
              PropertyWidget(
                props_image:
                    'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                props_name: 'Newly Built House',
                props_type: 'buy',
                props_price: '10000000',
                isFav: false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '10',
              ),
              PropertyWidget(
                props_image:
                    'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                props_name: 'Newly Built House',
                props_type: 'buy',
                props_price: '10000000',
                isFav: false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '10',
              ),
              PropertyWidget(
                props_image:
                    'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                props_name: 'Newly Built House',
                props_type: 'buy',
                props_price: '10000000',
                isFav: false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '10',
              ),
              PropertyWidget(
                props_image:
                    'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                props_name: 'Newly Built House',
                props_type: 'buy',
                props_price: '10000000',
                isFav: false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '10',
              ),
              PropertyWidget(
                props_image:
                    'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                props_name: 'Newly Built House',
                props_type: 'buy',
                props_price: '10000000',
                isFav: false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '10',
              ),
              PropertyWidget(
                props_image:
                    'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                props_name: 'Newly Built House',
                props_type: 'buy',
                props_price: '10000000',
                isFav: false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '10',
              ),
            ]),
      ),
    );
  }
}
