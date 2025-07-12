package ShoppingCart;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order {
	private int id;
	private Date date;
	private List<LineItem> items;

	public Order(int id) {
		this.id = id;
		this.date = new Date();
		this.items = new ArrayList<>();
	}

	public void addItem(LineItem item) {
		items.add(item);
	}

	public double calculateOrderPrice() {
		return items.stream().mapToDouble(LineItem::calculateLineItemCost).sum();
	}

	public void printOrder() {
		System.out.println("\n----- Order Summary -----");
		for (LineItem item : items) {
			item.printItem();
		}
		System.out.printf("Total Order Amount: ₹%.2f\n", calculateOrderPrice());
	}

	public List<LineItem> getItems() {
		return items;
	}
}
