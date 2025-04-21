import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/province_data.dart'; // 👈 Importa tu modelo

import 'province_detail_screen.dart'; // 👈 Asegúrate de tenerlo también

class ProvincesListScreen extends StatefulWidget {
  const ProvincesListScreen({super.key});

  @override
  State<ProvincesListScreen> createState() => _ProvincesListScreenState();
}

class _ProvincesListScreenState extends State<ProvincesListScreen> {
  String? svgBase;
  String? svgUpdated;
  String? selectedProvinceId;

  @override
  void initState() {
    super.initState();
    loadSvg();
  }

  Future<void> loadSvg() async {
    final rawSvg = await rootBundle.loadString('assets/images/mapa_ecuador.svg');
    setState(() {
      svgBase = rawSvg;
      svgUpdated = rawSvg;
    });
  }

  void updateSelectedProvince(String provinceId) {
    if (svgBase == null) return;

    final updated = svgBase!.replaceAllMapped(
      RegExp(r'<path([^>]*?)id="(.*?)"([^>]*)>', caseSensitive: false),
          (match) {
        final currentId = match.group(2);
        final originalPath = match.group(0)!;
        final fillColor = (currentId == provinceId) ? '#FFA500' : '#CCCCCC';

        if (originalPath.contains('fill=')) {
          return originalPath.replaceAll(RegExp(r'fill="[^"]*"'), 'fill="$fillColor"');
        } else {
          return originalPath.replaceFirst('>', ' fill="$fillColor">');
        }
      },
    );

    setState(() {
      selectedProvinceId = provinceId;
      svgUpdated = updated;
    });
  }

  void onProvinceTap(String provinceId, String provinceName) async {
    if (selectedProvinceId != provinceId) {
      updateSelectedProvince(provinceId);
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProvinceDetailsScreen(provinceName: provinceName),
        ),
      );
      setState(() {
        selectedProvinceId = null;
        svgUpdated = svgBase;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 1000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provincias del Ecuador'),
      ),
      body: Center(
        child: svgUpdated == null
            ? const CircularProgressIndicator()
            : Stack(
          children: [
            SvgPicture.string(
              svgUpdated!,
              width: screenWidth,
              fit: BoxFit.contain,
            ),
            ...provinceRegions.map((province) {
              return Positioned(
                left: province.left * scaleFactor,
                top: province.top * scaleFactor,
                child: GestureDetector(
                  onTap: () => onProvinceTap(province.id, province.name),
                  child: Container(
                    width: 80 * scaleFactor,
                    height: 80 * scaleFactor,
                    color: Colors.transparent,
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
