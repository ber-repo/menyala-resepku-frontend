List<String> categories = [ // untuk jenis kategori nambah manual disini
  'Breakfast',
  'Lunch',
  'Drinks',
  'Snacks',
  'Salads',
  'Desserts',
  'Soups',
  'Western',
  'Japanese',
  
];
//add category 
void addCategory(String newCategory) { 
  if (!categories.contains(newCategory)) {
    categories.add(newCategory);
  }
}
