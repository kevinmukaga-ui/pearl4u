class Species {
  final String id;
  final String commonName;
  final String scientificName;
  final String category; // Mammals, Birds, Reptiles, Plants, Trees, Primates
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
    // 1. African Elephant
    Species(
      id: 'elephant',
      commonName: 'African elephant',
      scientificName: 'Loxodonta africana',
      category: 'Mammals',
      conservationStatus: 'Endangered',
      habitat: 'Queen Elizabeth NP',
      description: 'The largest living terrestrial mammal on Earth. Intelligent social matriarchal herds congregate in large numbers along the Victoria Nile and Kazinga Channel.',
      imageUrl: 'https://images.unsplash.com/photo-1557050543-4d5f4e07ef46?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Queen Elizabeth NP', 'Murchison Falls NP', 'Kidepo Valley NP'],
      funFact: 'Elephants communicate over distances of up to 10 kilometers using seismic rumbles below the range of human hearing.',
    ),
    // 2. Mountain Gorilla
    Species(
      id: 'gorilla',
      commonName: 'Mountain gorilla',
      scientificName: 'Gorilla beringei beringei',
      category: 'Mammals',
      conservationStatus: 'Endangered',
      habitat: 'Bwindi Forest',
      description: 'Gentle giants inhabiting the mist-covered slopes of Bwindi Impenetrable and Mgahinga Gorilla National Parks. They live in cohesive family troops led by a dominant silverback.',
      imageUrl: 'https://images.unsplash.com/photo-1547970810-dc1eac8161a7?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Bwindi Forest', 'Mgahinga Gorilla NP'],
      funFact: 'Gorillas share approximately 98.3% of their genetic code with humans and build fresh sleeping nests out of foliage each night.',
    ),
    // 3. Grey Crowned Crane
    Species(
      id: 'crane',
      commonName: 'Grey crowned crane',
      scientificName: 'Balearica regulorum',
      category: 'Birds',
      conservationStatus: 'Endangered',
      habitat: 'Wetlands of Uganda',
      description: 'The graceful national bird of Uganda, famous for its crown of stiff golden feathers and distinctive syncopated mating dance.',
      imageUrl: 'https://images.unsplash.com/photo-1549608276-5786777e6587?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Wetlands of Uganda', 'Lake Bunyonyi', 'Queen Elizabeth NP'],
      funFact: 'Featured proudly at the center of the Uganda national flag and coat of arms as a symbol of gentle beauty.',
    ),
    // 4. Tree-Climbing Lion
    Species(
      id: 'tree_lion',
      commonName: 'Tree-climbing lion',
      scientificName: 'Panthera leo',
      category: 'Mammals',
      conservationStatus: 'Vulnerable',
      habitat: 'Ishasha sector',
      description: 'A unique population of lions that regularly climb giant fig trees in Ishasha to escape midday heat and tsetse flies, resting casually on high limbs.',
      imageUrl: 'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Ishasha sector (Queen Elizabeth NP)'],
      funFact: 'One of only two populations in the entire world known for habitual high-tree climbing behavior.',
    ),
    // 5. Flame Lily (Figma Exact)
    Species(
      id: 'flame_lily',
      commonName: 'Flame lily',
      scientificName: 'Gloriosa superba',
      category: 'Plants',
      conservationStatus: 'Native Flora',
      habitat: 'Woodland & grassland',
      description: 'Striking climbing lily with brilliant crimson and yellow wavy reflexed petals. Found thriving across Uganda\'s savannah woodlands and forest edges.',
      imageUrl: 'https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Woodland & grassland', 'Murchison savannahs', 'Lake Mburo margins'],
      funFact: 'The magnificent flame lily is known for its showy nodding flowers that turn bright scarlet as they mature.',
    ),
    // 6. African Mahogany (Figma Exact)
    Species(
      id: 'mahogany',
      commonName: 'African mahogany',
      scientificName: 'Khaya anthotheca',
      category: 'Trees',
      conservationStatus: 'Vulnerable',
      habitat: 'Uganda\'s forests',
      description: 'Towering rainforest canopy tree rising up to 60 meters high with massive buttress roots. Dominates the dense ancient canopy of Budongo and Mabira forests.',
      imageUrl: 'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Uganda\'s forests', 'Budongo Forest', 'Mabira Forest Reserve'],
      funFact: 'Some mahogany trees in Budongo Forest are estimated to be over 500 years old, providing vital nesting for chimpanzees.',
    ),
    // 7. Shoebill Stork
    Species(
      id: 'shoebill',
      commonName: 'Shoebill stork',
      scientificName: 'Balaeniceps rex',
      category: 'Birds',
      conservationStatus: 'Vulnerable',
      habitat: 'Mabamba Bay Swamp',
      description: 'An ancient-looking, prehistoric bird known for its massive Dutch-clog shoe-shaped bill capable of catching lungfish and baby crocodiles.',
      imageUrl: 'https://images.unsplash.com/photo-1555169062-013468b47731?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Mabamba Bay Swamp', 'Murchison Falls Nile Delta'],
      funFact: 'A shoebill can stand completely motionless like a stone statue for hours waiting for prey to surface.',
    ),
    // 8. Eastern Chimpanzee
    Species(
      id: 'chimpanzee',
      commonName: 'Eastern chimpanzee',
      scientificName: 'Pan troglodytes schweinfurthii',
      category: 'Mammals',
      conservationStatus: 'Endangered',
      habitat: 'Kibale Forest',
      description: 'Man\'s closest living relative sharing 98.7% DNA. Highly intelligent, tool-using primates thriving in troops across Kibale and Budongo.',
      imageUrl: 'https://images.unsplash.com/photo-1535268647677-300dbf3d78d1?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Kibale Forest', 'Budongo Forest'],
      funFact: 'Chimpanzees use modified twigs as fishing rods to harvest termites and medicinal leaves to treat infections.',
    ),
    // 9. Nile Crocodile
    Species(
      id: 'crocodile',
      commonName: 'Nile crocodile',
      scientificName: 'Crocodylus niloticus',
      category: 'Reptiles',
      conservationStatus: 'Least Concern',
      habitat: 'Murchison Nile Banks',
      description: 'Formidable apex aquatic predator sunbathing along the rocky banks below Murchison Falls and along Lake Albert.',
      imageUrl: 'https://images.unsplash.com/photo-1528181304800-259b08848526?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Victoria Nile', 'Kazinga Channel'],
      funFact: 'Nile crocodiles have one of the strongest bite forces in the animal kingdom, exceeding 5,000 pounds per square inch.',
    ),
    // 10. Rothschild's Giraffe
    Species(
      id: 'giraffe',
      commonName: 'Rothschild\'s giraffe',
      scientificName: 'Giraffa camelopardalis rothschildi',
      category: 'Mammals',
      conservationStatus: 'Near Threatened',
      habitat: 'Kidepo Valley',
      description: 'One of the tallest and most endangered giraffe sub-species, characterized by creamy white knee-high stockings with no markings below the knee.',
      imageUrl: 'https://images.unsplash.com/photo-1538099130811-745e64318258?auto=format&fit=crop&w=800&q=80',
      primaryLocations: ['Murchison Falls NP', 'Kidepo Valley', 'Lake Mburo'],
      funFact: 'A giraffe\'s heart weighs around 11 kilograms and pumps blood up to 3 meters straight up to its brain.',
    ),
  ];
}
