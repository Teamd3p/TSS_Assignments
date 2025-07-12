package ShoppingCart;

import java.util.*;

public class ShoppingCartTest{
    static Scanner sc = new Scanner(System.in);
    static Map<Integer, Product> productCatalog = new HashMap<>();
    static int productIdCounter = 1;
    static int lineItemIdCounter = 1;
    static int orderIdCounter = 1;

    public static void main(String[] args) {
        Customer customer = new Customer(1, "Deep");

        while (true) {
            System.out.println("\n====== Shopping Cart Menu ======");
            System.out.println("1. Add Product to Catalog");
            System.out.println("2. Show Product Catalog");
            System.out.println("3. Create Order");
            System.out.println("4. View All Orders");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            int choice = Integer.parseInt(sc.nextLine());

            switch (choice) {
                case 1 -> addProduct();
                case 2 -> showProducts();
                case 3 -> createOrder(customer);
                case 4 -> viewOrders(customer);
                case 5 -> {
                    System.out.println("Thank you for using Shopping Cart!");
                    return;
                }
                default -> System.out.println("Invalid choice!");
            }
        }
    }

    static void addProduct() {
        System.out.print("Enter product name: ");
        String name = sc.nextLine();
        System.out.print("Enter price: ");
        double price = Double.parseDouble(sc.nextLine());
        System.out.print("Enter discount percent: ");
        double discount = Double.parseDouble(sc.nextLine());

        Product product = new Product(productIdCounter++, name, price, discount);
        productCatalog.put(product.getId(), product);
        System.out.println("Product added successfully.");
    }

    static void showProducts() {
        if (productCatalog.isEmpty()) {
            System.out.println("No products available.");
            return;
        }
        System.out.println("----- Product Catalog -----");
        for (Product product : productCatalog.values()) {
            product.printDetails();
        }
    }

    static void createOrder(Customer customer) {
        if (productCatalog.isEmpty()) {
            System.out.println("No products available. Please add products first.");
            return;
        }

        Order order = new Order(orderIdCounter++);
        while (true) {
            showProducts();
            System.out.print("Enter Product ID to add to cart (-1 to finish): ");
            int pid = Integer.parseInt(sc.nextLine());
            if (pid == -1) break;

            Product product = productCatalog.get(pid);
            if (product == null) {
                System.out.println("Invalid product ID!");
                continue;
            }

            System.out.print("Enter quantity: ");
            int qty = Integer.parseInt(sc.nextLine());

            LineItem item = new LineItem(lineItemIdCounter++, qty, product);
            order.addItem(item);
            System.out.println("Item added to cart.");
        }

        if (!order.getItems().isEmpty()) {
            order.printOrder();
            customer.addOrder(order);
            System.out.println("Order placed successfully!");
        } else {
            System.out.println("Order was empty. Nothing saved.");
        }
    }

    static void viewOrders(Customer customer) {
        if (customer.getOrders().isEmpty()) {
            System.out.println("No orders placed yet.");
            return;
        }

        for (Order order : customer.getOrders()) {
            order.printOrder();
        }
    }
}

