package Assignment;

import java.io.*;
import java.util.*;

import Assignment.MovieException.MovieStoreAlreadyFull;
import Assignment.MovieException.MovieStoreEmpty;

public class MovieTest {

    static Scanner scanner = new Scanner(System.in);
    static List<Movies> movies = new ArrayList<>();
    static final String file_name = "movies.ser";

    public static void main(String[] args) {
        deserializeMovies();

        int choice;
        boolean loop = true;
        while (loop) {
            System.out.println("\n------ Movies System ------");
            System.out.println("1. Add a new Movie");
            System.out.println("2. Display Movies");
            System.out.println("3. Delete Movie");
            System.out.println("4. Clear All Movies");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    addMovie();
                    break;
                case 2:
                    displayMovies();
                    break;
                case 3:
                    deleteMovie();
                    break;
                case 4:
                    clearAll();
                    break;
                case 5:
                    System.out.println("Exiting...");
                    loop = false;
                    break;
                default:
                    System.out.println("Invalid choice. Try again.");
            }
        }

        serializeMovies();
    }

    static void addMovie() {
    	try {
    	if(movies.size() >6) {
    		 throw new MovieStoreAlreadyFull("Movie Store Full");
    		
    	}
        System.out.print("Enter Movie Name: ");
        String name = scanner.next();
        scanner.nextLine();
        System.out.print("Enter Movie Genre: ");
        String genre = scanner.nextLine();
        System.out.print("Enter Year: ");
        int year = scanner.nextInt();

        String id = generateID(name, genre, year);
        movies.add(new Movies(id, name, genre, year));
        System.out.println("Movie added successfully!");

        serializeMovies();}catch(Exception e) {System.out.println(e);}
    }

    static void displayMovies() {
    	try {
        if (movies.isEmpty()) {
            throw new MovieStoreEmpty("Movie Store Empty");
        }

        System.out.println("\n--- Available Movies ---");
        for (Movies movie : movies) {
            System.out.println(movie);
        }}catch(Exception e) {System.out.println(e);}
    }

    static void deleteMovie() {
        System.out.print("Enter Movie ID to delete: ");
        String id = scanner.next();

        boolean removed = movies.removeIf(movie -> movie.getId().equalsIgnoreCase(id));

        if (removed) {
            System.out.println("Movie deleted successfully.");
            serializeMovies();
        } else {
            System.out.println("Movie not found.");
        }
    }

    static void clearAll() {
        movies.clear();
        serializeMovies();
        System.out.println("All movies cleared.");
    }

    public static String generateID(String name, String genre, int year) {
        return name.substring(0, 2).toUpperCase()
                + genre.substring(0, 2).toUpperCase()
                + String.valueOf(year).substring(2);
    }

    static void serializeMovies() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(file_name))) {
            oos.writeObject(movies);
        } catch (IOException e) {
            System.out.println("Error saving movie list: " + e.getMessage());
        }
    }

    static void deserializeMovies() {
        File file = new File(file_name);
        if (!file.exists()) return;

        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
            movies = (List<Movies>) ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            System.out.println("Error loading movie list: " + e.getMessage());
        }
    }
}
