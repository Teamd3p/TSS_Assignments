package ShoppingCart;

public class LineItem {
    private int id;
    private int quantity;
    private Product product;

    public LineItem(int id, int quantity, Product product) {
        this.id = id;
        this.quantity = quantity;
        this.product = product;
    }

    public double calculateLineItemCost() {
        return quantity * product.getDiscountedPrice();
    }

    public void printItem() {
        System.out.printf("ItemID: %d | %s | Qty: %d | Unit ₹%.2f | Total ₹%.2f\n",
                id, product.getName(), quantity, product.getDiscountedPrice(), calculateLineItemCost());
    }
}

