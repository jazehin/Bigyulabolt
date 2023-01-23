/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bigyula;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Kiss Bence
 */
public class MySQL {
    private static String url  = "127.0.0.1";
    private static String user = "root";
    private static String pass = "";
    
    public Connection getConnection() {
        try {
            return DriverManager.getConnection(url, user, pass);
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Hiba az adatbázishoz csatlakozáskor: " + ex.getMessage());
        }
        
        return null;
    }
}
