class CategoryImageUtils {
  /// Obtém a imagem fixa para a categoria de pet
  static String getCategoryImage(String categoryType) {
    switch (categoryType.toLowerCase()) {
      case 'dogs':
      case 'cachorro':
      case 'cão':
        return 'assets/images/dog_category_temp.png'; // Temporário - substitua pela imagem do beagle
      case 'cats':
      case 'gato':
        return 'assets/images/cat_category_temp.png'; // Temporário - substitua pela imagem do gato siamês
      default:
        return 'assets/images/img.svg';
    }
  }

  /// Obtém o ícone da categoria
  static String getCategoryIcon(String categoryType) {
    switch (categoryType.toLowerCase()) {
      case 'dogs':
      case 'cachorro':
      case 'cão':
        return 'assets/images/dog_category_temp.png'; // Temporário - substitua pela imagem do beagle
      case 'cats':
      case 'gato':
        return 'assets/images/cat_category_temp.png'; // Temporário - substitua pela imagem do gato siamês
      default:
        return 'assets/images/img.svg';
    }
  }

  /// Obtém o nome exibido da categoria
  static String getCategoryDisplayName(String categoryType) {
    switch (categoryType.toLowerCase()) {
      case 'dogs':
        return 'Cachorros';
      case 'cats':
        return 'Gatos';
      default:
        return 'Pets';
    }
  }

  /// Obtém a cor associada à categoria
  static String getCategoryColor(String categoryType) {
    switch (categoryType.toLowerCase()) {
      case 'dogs':
        return '#FF8A65'; // Laranja suave para cães
      case 'cats':
        return '#9C27B0'; // Roxo para gatos
      default:
        return '#FF4F20'; // Cor padrão do app
    }
  }

  /// Lista de todas as categorias disponíveis
  static List<Map<String, String>> getAllCategories() {
    return [
      {
        'type': 'dogs',
        'title': 'Cachorros',
        'image': getCategoryImage('dogs'),
        'icon': getCategoryIcon('dogs'),
        'color': getCategoryColor('dogs'),
      },
      {
        'type': 'cats',
        'title': 'Gatos',
        'image': getCategoryImage('cats'),
        'icon': getCategoryIcon('cats'),
        'color': getCategoryColor('cats'),
      },
    ];
  }
}
