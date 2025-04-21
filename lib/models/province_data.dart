class ProvinceRegion {
  final String id;
  final String name;
  final double left; // Coordenada X (basada en el SVG)
  final double top;  // Coordenada Y (basada en el SVG)

  ProvinceRegion({
    required this.id,
    required this.name,
    required this.left,
    required this.top,
  });
}

final List<ProvinceRegion> provinceRegions = [
  ProvinceRegion(id: "ECE", name: "Esmeraldas", left: 738.0 * (398/1000), top: 70.4 * (750/398)),
  ProvinceRegion(id: "ECC", name: "Carchi", left: 804.9 * (398/1000), top: 71.5 * (750/398)),
  ProvinceRegion(id: "ECU", name: "Sucumbios", left: 888.1 * (398/1000), top: 114.9 * (750/398)),
  ProvinceRegion(id: "ECD", name: "Orellana", left: 901.5 * (398/1000), top: 154.9 * (750/398)),
  ProvinceRegion(id: "ECY", name: "Pastaza", left: 865.7 * (398/1000), top: 202.0 * (750/398)),
  ProvinceRegion(id: "ECS", name: "Morona Santiago", left: 807.6 * (398/1000), top: 241.5 * (750/398)),
  ProvinceRegion(id: "ECZ", name: "Zamora Chinchipe", left: 757.8 * (398/1000), top: 328.1 * (750/398)),
  ProvinceRegion(id: "ECL", name: "Loja", left: 718.0 * (398/1000), top: 331.9 * (750/398)),
  ProvinceRegion(id: "ECO", name: "El Oro", left: 703.9 * (398/1000), top: 299.0 * (750/398)),
  ProvinceRegion(id: "ECG", name: "Guayas", left: 695.5 * (398/1000), top: 208.4 * (750/398)),
  ProvinceRegion(id: "ECW", name: "Galápagos", left: 99.6 * (398/1000), top: 150.5 * (750/398)),
  ProvinceRegion(id: "ECSE", name: "Santa Elena", left: 668.8 * (398/1000), top: 227.0 * (750/398)),
  ProvinceRegion(id: "ECM", name: "Manabi", left: 699.7 * (398/1000), top: 132.0 * (750/398)),
  ProvinceRegion(id: "ECA", name: "Azuay", left: 740.5 * (398/1000), top: 273.7 * (750/398)),
  ProvinceRegion(id: "ECF", name: "Cañar", left: 756.2 * (398/1000), top: 247.2 * (750/398)),
  ProvinceRegion(id: "ECN", name: "Napo", left: 777.5 * (398/1000), top: 176.7 * (750/398)),
  ProvinceRegion(id: "ECT", name: "Tungurahua", left: 807.1 * (398/1000), top: 151.2 * (750/398)),
  ProvinceRegion(id: "ECH", name: "Chimborazo", left: 764.7 * (398/1000), top: 211.9 * (750/398)),
  ProvinceRegion(id: "ECB", name: "Bolivar", left: 747.2 * (398/1000), top: 193.6 * (750/398)),
  ProvinceRegion(id: "ECI", name: "Imbabura", left: 787.7 * (398/1000), top: 85.8 * (750/398)),
  ProvinceRegion(id: "ECX", name: "Cotopaxi", left: 755.9 * (398/1000), top: 154.9 * (750/398)),
  ProvinceRegion(id: "ECR", name: "Los Rios", left: 718.9 * (398/1000), top: 190.0 * (750/398)),
  ProvinceRegion(id: "ECP", name: "Pichincha", left: 778.9 * (398/1000), top: 114.5 * (750/398)),
  ProvinceRegion(id: "ECSD", name: "Santo Domingo de los Tsáchilas", left: 740.2 * (398/1000), top: 123.6 * (750/398)),
];