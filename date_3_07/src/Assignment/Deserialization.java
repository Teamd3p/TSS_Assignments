package Assignment;

import java.io.FileInputStream;
import java.io.ObjectInputStream;

public class Deserialization{
    public static void main(String[] args) {
        Student s2 = null;

        try {
            FileInputStream fileIn = new FileInputStream("studentInfo.ser");
            ObjectInputStream in = new ObjectInputStream(fileIn);
            s2 = (Student) in.readObject();
            in.close();
            fileIn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (s2 != null) {
            System.out.print("Deserialized Student: ");
            s2.display();
        }
    }
}

