/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bigyula;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Kiss Bence
 */
public class MySQL {
    private String url  = "jdbc:mysql://127.0.0.1/bigyulabolt";
    private String user = "root";
    private String pass = "";
    private Connection conn;
    
    public MySQL() {
        try {
            //Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, pass);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Hiba az adatbázishoz csatlakozáskor: " + ex.getMessage());
        }
    }
    
    public ResultSet select(String sql, String[] ertekek) {
        try {
            PreparedStatement sta = conn.prepareStatement(sql);
            for (int i = 1; i < ertekek.length + 1; i++) {
                sta.setString(i, ertekek[i - 1]);
            }
            ResultSet rs = sta.executeQuery();
            return rs;
            //sta.close();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Hiba a lekérdezés során: " + ex.getMessage());
        }
        
        return null;
    }
} 
