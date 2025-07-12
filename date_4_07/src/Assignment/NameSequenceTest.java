package Assignment;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class NameSequenceTest {
	public static void main(String[] args) {

		Scanner scanner = new Scanner(System.in);
		List<String> names = new ArrayList<>();

		System.out.print("How many names do you want to enter? ");
		int count = scanner.nextInt();
		scanner.nextLine();

		for (int i = 0; i < count; i++) {
			System.out.print("Enter name " + (i + 1) + ": ");
			String name = scanner.nextLine().toLowerCase();
			names.add(name);
		}

		System.out.print("\nEnter the name to start from: ");
		String inputName = scanner.nextLine().toLowerCase();

		int index = names.indexOf(inputName);

		if (index == -1) {
			System.out.println("Name not found in the list.");
		} else {
			System.out.print(names.get(index));
			for (int i = index + 1; i < names.size(); i++) {
				System.out.print(" --> " + names.get(i));
			}
			scanner.close();

			System.out.println();

//	            for (int i = index + 1; i < names.size(); i++) {
//	                System.out.println("\t\t\t" + names.get(i));
//	            }
		}
	}

}
