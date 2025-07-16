package com.delivery;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class RandomDeliveryPartner implements IDelivery {

	private static List<String> deliveryPartners = new ArrayList<>();

	private Random random = new Random();
	static {
	    deliveryPartners.add("Zomato");
	    deliveryPartners.add("Swiggy");
	    deliveryPartners.add("UberEats");
	}

	@Override
	public String assignDeliveryPartner() {
		return deliveryPartners.get(random.nextInt(deliveryPartners.size()));
	}

	public static void addDeliveryPartner(String deliveryPartnerName) {
		deliveryPartners.add(deliveryPartnerName);
	}

	public static void removeDeliveryPartner(int index) {
		if (index >= 0 && index < deliveryPartners.size()) {
			deliveryPartners.remove(index);
		}
	}

	public static List<String> getPartners() {
		return deliveryPartners;

	}

}
