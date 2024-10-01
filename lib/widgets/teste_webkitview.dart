import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:place_gallery/utils/location_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewMapUrl;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (WebView.platform == null) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();

    final mapUrl = locationUtil.generateLocationUrl(
      latitude: locData.latitude!,
      longitude: locData.longitude!,
    );

    setState(() {
      _previewMapUrl = mapUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400, // Ajuste a altura conforme necessário
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewMapUrl == null
              ? const Text('Localização não informada!')
              : WebView(
                  initialUrl: _previewMapUrl, // Carregando a URL
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController; // Armazena o controlador
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
            TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.map),
                  Text(
                    'Selecione no Mapa',
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
