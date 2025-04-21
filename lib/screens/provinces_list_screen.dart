import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:politimetrica_ecuador/screens/province_detail_screen.dart';
import '../models/province_data.dart';

class ProvincesListScreen extends StatefulWidget {
  const ProvincesListScreen({super.key});

  @override
  State<ProvincesListScreen> createState() => _ProvincesListScreenState();
}

class _ProvincesListScreenState extends State<ProvincesListScreen> {
  String? _svgBase;
  String? _svgUpdated;
  String? _selectedProvinceId;
  String? _selectedProvinceName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  Future<void> _loadSvg() async {
    try {
      final rawSvg = await rootBundle.loadString('assets/images/mapa_ecuador4.svg');
      setState(() {
        _svgBase = rawSvg;
        _svgUpdated = rawSvg;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error loading SVG: $e');
    }
  }

  void _updateSelectedProvince(String provinceId, String provinceName) {
    if (_svgBase == null) return;

    final updated = _svgBase!.replaceAllMapped(
      RegExp(r'<path([^>]*?)id="(.*?)"([^>]*)>', caseSensitive: false),
          (match) {
        final currentId = match.group(2);
        final originalPath = match.group(0)!;
        final fillColor = (currentId == provinceId) ? '#FFA500' : '#CCCCCC';

        if (originalPath.contains('fill=')) {
          return originalPath.replaceAll(
              RegExp(r'fill="[^"]*"'),
              'fill="$fillColor"'
          );
        } else {
          return originalPath.replaceFirst('>', ' fill="$fillColor">');
        }
      },
    );

    setState(() {
      _selectedProvinceId = provinceId;
      _selectedProvinceName = provinceName;
      _svgUpdated = updated;
    });
  }

  Future<void> _onProvinceTap(String provinceId, String provinceName) async {
    if (_selectedProvinceId != provinceId) {
      _updateSelectedProvince(provinceId, provinceName);
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProvinceDetailsScreen(provinceName: provinceName),
        ),
      );

      setState(() {
        _selectedProvinceId = null;
        _selectedProvinceName = null;
        _svgUpdated = _svgBase;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const viewBoxWidth = 398.0; // Updated to match SVG viewBox
    const viewBoxHeight = 750.0; // Updated to match SVG viewBox

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provincias del Ecuador'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _svgUpdated == null
          ? const Center(child: Text('Error al cargar el mapa'))
          : Center(
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Stack(
            children: [
              SvgPicture.string(
                _svgUpdated!,
                width: screenSize.width,
                height: screenSize.height,
                fit: BoxFit.contain,
              ),
              ...provinceRegions.map((province) {
                // No need for additional scaling - coordinates are already correct
                return Positioned(
                  left: province.left,
                  top: province.top,
                  child: GestureDetector(
                    onTap: () => _onProvinceTap(province.id, province.name),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              if (_selectedProvinceName != null && _selectedProvinceId != null)
                Positioned(
                  left: provinceRegions
                      .firstWhere((p) => p.id == _selectedProvinceId)
                      .left,
                  top: provinceRegions
                      .firstWhere((p) => p.id == _selectedProvinceId)
                      .top,
                  child: GestureDetector(
                    onTap: () => _onProvinceTap(_selectedProvinceId!, _selectedProvinceName!),
                    child: Card(
                      elevation: 4,
                      color: Colors.blue[50],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _selectedProvinceName!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}