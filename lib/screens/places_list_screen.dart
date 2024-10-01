import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:place_gallery/providers/great_places.dart';
import 'package:place_gallery/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus lugares',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACES_FORM);
            },
            icon: const Icon(Icons.add),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                    ? const Center(
                        // Use o Center diretamente aqui
                        child: Text('Nenhum local cadastrado!'),
                      )
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatPlaces.itemByIndex(index).image,
                            ),
                          ),
                          title: Text(greatPlaces.itemByIndex(index).title),
                          subtitle: Text(
                              greatPlaces.itemByIndex(index).location!.address),
                          onTap: () {
                            Navigator.of(ctx).pushNamed(
                              AppRoutes.PLACE_DETAILS,
                              arguments: greatPlaces.itemByIndex(index),
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
