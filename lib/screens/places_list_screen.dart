import 'package:favorite_places/provider/favorite_places.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<FavoritePlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<FavoritePlaces>(
                  child: Center(
                    child: Text(
                      "Nothing to show",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  builder: (context, favoritePlaces, child) =>
                      favoritePlaces.items.length <= 0
                          ? child as Widget
                          : ListView.builder(
                              itemCount: favoritePlaces.items.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    favoritePlaces.items[index].image,
                                  ),
                                ),
                                title: Text(favoritePlaces.items[index].title),
                                onTap: () {
                                  //go to details page
                                },
                              ),
                            ),
                ),
        ),
      ),
    );
  }
}
