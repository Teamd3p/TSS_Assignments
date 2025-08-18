package model;

public class Result {
    private String username;
    private int score;
    private int total;

    public Result(String username, int score, int total) {
        this.username = username;
        this.score = score;
        this.total = total;
    }

    public String getUsername() {
        return username;
    }

    public int getScore() {
        return score;
    }

    public int getTotal() {
        return total;
    }
}
