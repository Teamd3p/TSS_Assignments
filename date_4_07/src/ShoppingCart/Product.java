package ShoppingCart;

public class Product {
    private int id;
    private String name;
    private double price;
    private double discountPercent;

    public Product(int id, String name, double price, double discountPercent) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.discountPercent = discountPercent;
    }

    public double getDiscountedPrice() {
        return price - (price * discountPercent / 100);
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public double getDiscountPercent() { return discountPercent; }

    public void printDetails() {
        System.out.printf("ID: %d | %s | ₹%.2f | %.1f%% OFF | ₹%.2f\n",
                id, name, price, discountPercent, getDiscountedPrice());
    }
}

