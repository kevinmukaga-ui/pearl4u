class Species {
  final String id;
  final String commonName;
  final String scientificName;
  final String category; // Mammals, Birds, Plants, Primates
  final String conservationStatus;
  final String habitat;
  final String description;
  final String imageUrl;
  final List<String> primaryLocations;
  final String funFact;

  const Species({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.category,
    required this.conservationStatus,
    required this.habitat,
    required this.description,
    required this.imageUrl,
    required this.primaryLocations,
    required this.funFact,
  });

  static const List<Species> sampleSpecies = [
    Species(
      id: 'gorilla',
      commonName: 'Mountain Gorilla',
      scientificName: 'Gorilla beringei beringei',
      category: 'Primates',
      conservationStatus: 'Endangered',
      habitat: 'Afromontane rainforest canopy',
      description: 'Gentle giants inhabiting the mist-covered slopes of Bwindi Impenetrable and Mgahinga Gorilla National Parks. They live in family troops led by a dominant silverback.',
      imageUrl: 'https://images.unsplash.com/photo-1547970810-dc1eac8161a7?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Bwindi Impenetrable NP', 'Mgahinga Gorilla NP'],
      funFact: 'Gorillas share approximately 98.3% of their genetic code with humans and build fresh sleeping nests each night.',
    ),
    Species(
      id: 'shoebill',
      commonName: 'Shoebill Stork',
      scientificName: 'Balaeniceps rex',
      category: 'Birds',
      conservationStatus: 'Vulnerable',
      habitat: 'Papyrus swamps and freshwater wetlands',
      description: 'An ancient-looking, prehistoric bird known for its massive shoe-shaped bill capable of catching lungfish in the swamps.',
      imageUrl: 'https://images.unsplash.com/photo-1555169062-013468b47731?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Mabamba Bay Swamp', 'Murchison Falls Nile Delta', 'Lake Mburo'],
      funFact: 'A shoebill can stand motionless like a statue for hours waiting for lungfish to surface.',
    ),
    Species(
      id: 'crane',
      commonName: 'Grey Crowned Crane',
      scientificName: 'Balearica regulorum',
      category: 'Birds',
      conservationStatus: 'Endangered',
      habitat: 'Wetlands and open riverbanks',
      description: 'The elegant national bird of Uganda, famous for its crown of stiff golden feathers and distinctive syncopated mating dance.',
      imageUrl: 'https://images.unsplash.com/photo-1549608276-5786777e6587?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Lake Bunyonyi', 'Queen Elizabeth NP', 'Kabale Wetlands'],
      funFact: 'Featured proudly at the center of the Uganda national flag and coat of arms.',
    ),
    Species(
      id: 'tree_lion',
      commonName: 'Tree-Climbing Lion',
      scientificName: 'Panthera leo',
      category: 'Mammals',
      conservationStatus: 'Vulnerable',
      habitat: 'Sycamore fig tree savannas',
      description: 'A unique population of lions that regularly climb giant fig trees in Ishasha to escape midday heat and tsetse flies.',
      imageUrl: 'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Ishasha Sector (Queen Elizabeth NP)'],
      funFact: 'One of only two populations in the world known for habitual tree-climbing behaviour.',
    ),
  ];
}
