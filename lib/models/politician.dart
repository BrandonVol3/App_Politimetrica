class Politician {
  final String id;
  final String name;
  final String party;
  final String position;
  final String province;
  final String imageUrl;
  final double approvalRating;
  final String biography;
  final String partyColor;

  const Politician({
    required this.id,
    required this.name,
    required this.party,
    required this.position,
    required this.province,
    required this.imageUrl,
    required this.approvalRating,
    required this.biography,
    required this.partyColor,
  });
}

class EcuadorData {
  static const List<Politician> politicians = [
    // Asegúrate de que aquí esté el político de Carchi
    Politician(
      id: '1',
      name: 'Daniel Noboa',
      party: 'ADN (Acción Democrática Nacional)',
      position: 'Presidente de la República (2023-2025)',
      province: 'Santa Elena',
      imageUrl: 'assets/images/noboa.jpg',
      approvalRating: 47.3,
      biography: 'Daniel Noboa Azín, actual presidente de Ecuador buscando la reelección en 2025. Empresario y político que asumió el cargo en noviembre de 2023.',
      partyColor: '0000FF',
    ),
    Politician(
      id: '2',
      name: 'Luisa González',
      party: 'Revolución Ciudadana',
      position: 'Candidata Presidencial 2025',
      province: 'Manabí',
      imageUrl: 'assets/images/gonzalez.jpg',
      approvalRating: 45.8,
      biography: 'Exasambleísta y ministra durante el gobierno de Correa. Principal candidata opositora en las elecciones 2025.',
      partyColor: 'FF0000',
    ),
    Politician(
      id: '3',
      name: 'Jan Topic',
      party: 'Movimiento Construye',
      position: 'Candidato Presidencial 2025',
      province: 'Guayas',
      imageUrl: 'assets/images/topic.jpg',
      approvalRating: 38.6,
      biography: 'Empresario y exmilitar, emergió como tercera fuerza en las encuestas para 2025 con un discurso de seguridad y tecnocracia.',
      partyColor: 'FFA500',
    ),
    Politician(
      id: '4',
      name: 'Fernando Villavicencio†',
      party: 'Movimiento Construye',
      position: 'Candidato Presidencial 2023',
      province: 'Chimborazo',
      imageUrl: 'assets/images/villavicencio.jpg',
      approvalRating: 52.1,
      biography: 'Periodista y político asesinado durante campaña 2023. Su movimiento sigue influyente en el escenario político 2025.',
      partyColor: 'FFA500',
    ),
    Politician(
      id: '5',
      name: 'Pabel Muñoz',
      party: 'Revolución Ciudadana',
      position: 'Alcalde de Quito (2023-2027)',
      province: 'Pichincha',
      imageUrl: 'assets/images/munoz.jpg',
      approvalRating: 62.4,
      biography: 'Alcalde de Quito desde 2023 con alta aprobación por su gestión en transporte y seguridad.',
      partyColor: 'FF0000',
    ),
    Politician(
      id: '6',
      name: 'Aquiles Álvarez',
      party: 'Social Cristiano (PSC)',
      position: 'Prefecto del Guayas',
      province: 'Guayas',
      imageUrl: 'assets/images/alvarez.jpg',
      approvalRating: 58.2,
      biography: 'Líder del PSC y una de las figuras más influyentes en la costa ecuatoriana.',
      partyColor: '000080',
    ),
    Politician(
      id: '7',
      name: 'Virgilio Saquicela',
      party: 'Independiente',
      position: 'Presidente Asamblea Nacional',
      province: 'Cañar',
      imageUrl: 'assets/images/saquicela.jpg',
      approvalRating: 42.7,
      biography: 'Mantuvo su influencia en la Asamblea Nacional durante el periodo 2023-2025.',
      partyColor: '808080',
    ),
    Politician(
      id: '8',
      name: 'Pedro Freile',
      party: 'Sociedad Patriótica',
      position: 'Asambleísta Nacional',
      province: 'Pichincha',
      imageUrl: 'assets/images/freile.jpg',
      approvalRating: 39.5,
      biography: 'Líder opositor en la Asamblea con posturas conservadoras y nacionalistas.',
      partyColor: '800000',
    ),
    Politician(
      id: '9',
      name: 'Marcela Aguiñaga',
      party: 'Revolución Ciudadana',
      position: 'Asambleísta Nacional',
      province: 'Guayas',
      imageUrl: 'assets/images/aguinaga.jpg',
      approvalRating: 48.9,
      biography: 'Exministra de Ambiente y figura clave del correísmo en la costa.',
      partyColor: 'FF0000',
    ),
    Politician(
      id: '10',
      name: 'Henry Kronfle',
      party: 'Social Cristiano (PSC)',
      position: 'Asambleísta Nacional',
      province: 'Guayas',
      imageUrl: 'assets/images/kronfle.jpg',
      approvalRating: 51.3,
      biography: 'Presidente de la Comisión de Justicia y líder de la bancada del PSC.',
      partyColor: '000080',
    ),
    Politician(
      id: '11',
      name: 'Gissela Garzón',
      party: 'Izquierda Democrática',
      position: 'Asambleísta Nacional',
      province: 'Pichincha',
      imageUrl: 'assets/images/garzon.jpg',
      approvalRating: 55.1,
      biography: 'Una de las figuras jóvenes más populares en la Asamblea con enfoque en derechos sociales.',
      partyColor: 'FFA500',
    ),
    Politician(
      id: '12',
      name: 'Nathalie Arias',
      party: 'ADN',
      position: 'Ministra de Gobierno',
      province: 'Pichincha',
      imageUrl: 'assets/images/arias.jpg',
      approvalRating: 49.7,
      biography: 'Ministra clave del gobierno de Noboa con enfoque en seguridad ciudadana.',
      partyColor: '0000FF',
    ),
  ];

  static List<Politician> getPoliticiansByProvince(String province) {
    return politicians.where((politician) => politician.province == province).toList();
  }
}
