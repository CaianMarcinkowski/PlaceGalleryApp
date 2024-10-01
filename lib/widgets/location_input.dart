import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:place_gallery/utils/location_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectedPosition;

  const LocationInput(this.onSelectedPosition);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewMapUrl;
  late WebViewController _controller;
  bool _isLoading = false;

  Future<void> _getCurrentUserLocation() async {
    setState(() {
      _isLoading = true;
    });

    final locData = await Location().getLocation();

    final mapUrl = locationUtil.generateLocationUrl(
      latitude: locData.latitude as double,
      longitude: locData.longitude as double,
    );

    final LatLng selectedPosition =
        LatLng(locData.latitude as double, locData.longitude as double);

    widget.onSelectedPosition(selectedPosition);

    setState(() {
      _isLoading = false;
      _previewMapUrl = mapUrl;
    });
  }

  @override
  void initState() {
    super.initState();

    WebView.platform ??=
        SurfaceAndroidWebView(); // Use esta linha se for Android
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: _previewMapUrl == null ? 60 : 400,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _previewMapUrl == null
                  ? const Text('Localização não informada!')
                  : WebView(
                      initialUrl: _previewMapUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller = webViewController;
                      },
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _getCurrentUserLocation,
              child: const Row(
                children: [
                  Icon(Icons.location_on),
                  Text(
                    'Localização atual',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
