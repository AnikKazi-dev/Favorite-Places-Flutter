import 'dart:io';
import 'package:favorite_places/helpers/db_helper.dart';
import 'package:favorite_places/models/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class FavoritePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      // location: null!,
      location: PlaceLocation(address: '', latitude: 0, longitude: 0),
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert("places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("places");
    _items = dataList
        .map(
          (items) => Place(
            id: items["id"],
            title: items["title"],
            location: PlaceLocation(address: '', latitude: 0, longitude: 0),
            image: File(items["image"]),
          ),
        )
        .toList(); 
    notifyListeners();
  }
}
