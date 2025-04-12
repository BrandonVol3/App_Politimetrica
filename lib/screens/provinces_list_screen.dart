import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProvincesListScreen extends StatelessWidget {
  const ProvincesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provincias del Ecuador'),
      ),
      body: Center(
        child: SvgPicture.asset(
          'assets/images/mapa_ecuador.svg',
          width: MediaQuery.of(context).size.width * 0.9,
          semanticsLabel: 'Mapa del Ecuador',
        ),
      ),
    );
  }
}
