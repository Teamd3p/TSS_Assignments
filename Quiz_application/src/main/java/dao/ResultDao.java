package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import database.DBConnection;
import model.Result;

public class ResultDao {
    public void saveResult(Result result) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO results (username, score, total) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, result.getUsername());
            stmt.setInt(2, result.getScore());
            stmt.setInt(3, result.getTotal());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
