package Assignment;

import java.io.Serializable;

public class Movies implements Serializable {
	private static final long serialVersionUID = 1L;
	private String id;
	private String name;
	private String genre;
	private int year;

	public Movies(String id, String name, String genre, int year) {
		super();
		this.id = id;
		this.name = name;
		this.genre = genre;
		this.year = year;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	@Override
	public String toString() {
		return "ID: " + id + ", Name: " + name + ", Genre: " + genre + ", Year: " + year;
	}

}
