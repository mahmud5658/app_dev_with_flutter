void main() {
  // Creating a list of fruits
  List<Map<String, dynamic>> fruits = [
    {"name": "Apple", "color": "Red", "price": 2.5},
    {"name": "Banana", "color": "Yellow", "price": 1.0},
    {"name": "Grapes", "color": "Purple", "price": 3.0},
    {"name": "Watermelon", "color": "Green", "price": 5.0},
    {"name": "Mango", "color": "Yellow", "price": 4.0},
  ];

  // Displaying initial fruit details
  print("Original Fruit Details before Discount:");
  displayFruitDetails(fruits);

  // Applying a discount of 10%
  applyPriceDiscount(fruits, 10);

  // Displaying fruit details after applying discount
  print("\nFruit Details After Applying 10% Discount:");
  displayFruitDetails(fruits);
}

void displayFruitDetails(List<Map<String, dynamic>> fruits) {
  for (var fruit in fruits) {
    print("Name: ${fruit['name']}, Color: ${fruit['color']}, Price: \$${fruit['price'].toStringAsFixed(2)}");
  }
}

void applyPriceDiscount(List<Map<String, dynamic>> fruits, double discountPercentage) {
  for (var fruit in fruits) {
    double currentPrice = fruit['price'];
    double discountedPrice = currentPrice - (currentPrice * (discountPercentage / 100));
    fruit['price'] = discountedPrice;
  }
}
