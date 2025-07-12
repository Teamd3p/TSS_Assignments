package Assignment;

import java.io.FileOutputStream;
import java.io.ObjectOutputStream;

public class Serialization {
	
	 public static void main(String[] args) {
	        Student s1 = new Student(101, "Alice");

	        try {
	            FileOutputStream fileOut = new FileOutputStream("studentInfo.ser");
	            ObjectOutputStream out = new ObjectOutputStream(fileOut);
	            out.writeObject(s1);
	            out.close();
	            fileOut.close();
	            System.out.println("Serialized data is saved in student.ser");
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

}
