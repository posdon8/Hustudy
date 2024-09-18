/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.users;

/*
 * Lấy tài khoản 
 * Lấy tất cả tài khoản theo role
 * Kiểm tra xem username đã tồn tại chưa
 * Thêm tài khoản
 * Tìm tài khoản bằng id
 * Cập nhật tài khoản bằng id
 * Xóa tài khoản bằng id
 */
public class accountDAO extends DBContext {

    // Lấy tài khoản
    public users checkLogin(String username, String password) {
        String sql = "select * from [users] where [username] = ? and [password] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, password);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                users u = new users(rs.getInt("userid"), rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("email"), rs.getString("avatar"), rs.getString("role"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    // Lấy tất cả tài khoản theo role
    public List<users> getAllUser(String role) {
        List<users> list = new ArrayList<>();
        String sql = "select * from [users] where [role] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, role);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                users u = new users(rs.getInt("userid"), rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("email"), rs.getString("avatar"), rs.getString("role"));
                list.add(u);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    // Kiểm tra xem username đã tồn tại chưa
    public boolean checkUsernameExits(String username) {
        List<String> listUsername = new ArrayList<>();
        String sql = "select [username] from [users]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String s = rs.getString("username");
                listUsername.add(s);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        for (String u : listUsername) {
            if (u.equalsIgnoreCase(username)) {
                return false;
            }
        }
        return true;
    }

    // Thêm tài khoản
    public String addUser(String username, String password, String fullname, String email, String avatar, String role) {
        String sql = "insert into [users]([username],[password],[fullname],[email],[avatar],[role])\n"
                + "values ( ? , ? , ? , ? , ? , ? )";
        try {
            if (checkUsernameExits(username)) {
                PreparedStatement pre = connection.prepareStatement(sql);
                pre.setString(1, username);
                pre.setString(2, password);
                pre.setString(3, fullname);
                pre.setString(4, email);
                pre.setString(5, avatar);
                pre.setString(6, role);
                int noadd = pre.executeUpdate();
                if (noadd > 0) {
                    return "Create Successfully !";
                }
            } else {
                return "Username available !";
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return "Create failed !";
    }

    // Tìm tài khoản bằng id
    public users findUserById(int userid) {
        String sql = "select * from [users] where [users].[userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                users u = new users(rs.getInt("userid"), rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("email"), rs.getString("avatar"), rs.getString("role"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public users findUserByUsername(String username) {
        String sql = "select * from [users] where [users].[username] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, username);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                users u = new users(rs.getInt("userid"), rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("email"), rs.getString("avatar"), rs.getString("role"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    // Cập nhật tài khoản bằng id
    public String updateInfo(int userid, String username, String password, String fullname, String email, String avatar) {
        users u = findUserById(userid);
        if (checkUsernameExits(username) || u.getUsername().equalsIgnoreCase(username)) {
            String sql = "update [users] set [username] = ?,[password] = ? , [fullname] = ? , [email] = ? , [avatar] =  ? where [userid] = ? ";
            try {
                PreparedStatement pre = connection.prepareStatement(sql);
                pre.setString(1, username);
                pre.setString(2, password);
                pre.setString(3, fullname);
                pre.setString(4, email);
                pre.setString(5, avatar);
                pre.setInt(6, userid);
                int rs = pre.executeUpdate();
                if (rs > 0) {
                    return "Update successfully !";
                }
            } catch (SQLException e) {
                System.out.println(e);
            }
            return null;
        } else {
            return "Username available !";
        }
    }

    // Xóa tài khoản bằng id
    public void deleteUserById(int id) {
        String sql = "delete from [users] where [users].[userid] = ?"
                + "delete from [courses] where [courses].[userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            pre.setInt(2, id);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    
    public static void main(String[] args) {
        accountDAO ad = new accountDAO();
        ad.deleteUserById(20);
    }
}
