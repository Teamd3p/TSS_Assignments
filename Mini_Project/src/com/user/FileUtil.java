package com.user;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.List;

import com.model.Customer;

public class FileUtil {
	private static final String file_path = "customers.ser";
	public static void saveCustomers(List<Customer> customers) throws FileNotFoundException, IOException {
		try(ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(file_path))){
			oos.writeObject(customers);
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
		
		public static List<Customer> loadCustomers(){
			File file = new File(file_path);
			if(!file.exists()) {
				return new ArrayList<>();
			}
			try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file_path))) {
	            return (List<Customer>) ois.readObject();
	        } catch (IOException | ClassNotFoundException e) {
	            System.out.println("Error loading customers: " + e.getMessage());
	            return new ArrayList<>();
	        }
		}

}
