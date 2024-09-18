/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.cart;
import model.courses;
import model.orders;
import model.users;

/**
 *
 * @author admin
 */
public class orderDAO extends DBContext {

    public boolean isCourseInCart(int courseid, int userid) {
        String sql = "select 1 from [cart] where [courseid] = ? and [userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseid);
            pre.setInt(2, userid);
            ResultSet rs = pre.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public String addToCart(int courseid, int userid) {
        if (isCourseInCart(courseid, userid)) {
            return "The course already exists in the cart!";
        }

        String sql = "insert into [cart]([courseid],[userid]) values (?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseid);
            pre.setInt(2, userid);
            int result = pre.executeUpdate();
            if (result > 0) {
                return "Successfully added course to cart!";
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return "Failed to add course to cart!";
    }

    public courses getCourseById(int courseid) {
        String sql = "select * from [courses] where [courseid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public users getUserById(int userid) {
        String sql = "select * from [users] where [userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                users u = new users(userid, rs.getString("username"), rs.getString("password"), rs.getString("fullname"), rs.getString("email"), rs.getString("avatar"), rs.getString("role"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<cart> getCartByUserId(int userid) {
        List<cart> list = new ArrayList<>();
        String sql = "select *\n"
                + "from [cart]\n"
                + "where [cart].[userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                cart ca = new cart(rs.getInt("cartid"), getCourseById(rs.getInt("courseid")), getUserById(rs.getInt("userid")));
                list.add(ca);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public String deleteCart(int cartid) {
        String sql = "delete from [cart]\n"
                + "where [cart].[cartid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, cartid);
            int result = pre.executeUpdate();
            if (result > 0) {
                return "Successfully deleted course from cart!";
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return "Removing course from cart failed!";
    }

    public orders addOrder(int userid, String note) {
        orders o = null;
        String sql = "insert into [orders]([orderdate],[totalamount],[note] ,[userid])\n"
                + "values  ( ? , ? , ? , ?)";
        orderDAO od = new orderDAO();
        List<cart> list = od.getCartByUserId(userid);
        LocalDate cur = LocalDate.now();
        String date = cur.toString();
        int totalamount = 0;
        for (int i = 0; i < list.size(); i++) {
            totalamount += list.get(i).getCourseid().getPrice();
        }
        try {
            PreparedStatement pre = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setString(1, date);
            pre.setInt(2, totalamount);
            pre.setString(3, note);
            pre.setInt(4, userid);
            int rs = pre.executeUpdate();
            if (rs > 0) {
                ResultSet findkey = pre.getGeneratedKeys();
                if (findkey.next()) {
                    int orderid = findkey.getInt(1);
                    o = new orders(orderid, convertStringToDate(date), note, totalamount, getUserById(userid));
                    String sql1 = "insert into [orderdetails]([orderid], [price], [courseid])\n"
                            + "values  ( ? , ? , ? )";
                    try {
                        for (int j = 0; j < list.size(); j++) {
                            PreparedStatement pre1 = connection.prepareStatement(sql1);
                            pre1.setInt(1, orderid);
                            pre1.setInt(2, list.get(j).getCourseid().getPrice());
                            pre1.setInt(3, list.get(j).getCourseid().getCourseid());
                            pre1.executeUpdate();
                            addEnrollment(list.get(j).getCourseid(), getUserById(userid));
                        }
                    } catch (SQLException e) {
                        System.out.println(e);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return o;
    }

    public orders addOrderNow(int userid, String note, courses course) {
        orders o = null;
        String sql = "insert into [orders]([orderdate],[totalamount],[note] ,[userid])\n"
                + "values  ( ? , ? , ? , ?)";
        orderDAO od = new orderDAO();
        LocalDate cur = LocalDate.now();
        String date = cur.toString();
        try {
            PreparedStatement pre = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setString(1, date);
            pre.setInt(2, course.getPrice());
            pre.setString(3, note);
            pre.setInt(4, userid);
            int rs = pre.executeUpdate();
            if (rs > 0) {
                ResultSet findkey = pre.getGeneratedKeys();
                if (findkey.next()) {
                    int orderid = findkey.getInt(1);
                    o = new orders(orderid, convertStringToDate(date), note, course.getPrice(), getUserById(userid));
                    String sql1 = "insert into [orderdetails]([orderid], [price], [courseid])\n"
                            + "values  ( ? , ? , ? )";
                    try {
                        PreparedStatement pre1 = connection.prepareStatement(sql1);
                        pre1.setInt(1, orderid);
                        pre1.setInt(2, course.getPrice());
                        pre1.setInt(3, course.getCourseid());
                        pre1.executeUpdate();
                        addEnrollment(course, getUserById(userid));
                    } catch (SQLException e) {
                        System.out.println(e);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return o;
    }

    public Date convertStringToDate(String s) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = sdf.parse(s);
            return date;
        } catch (ParseException e) {
            System.out.println(e);;
        }
        return null;
    }

    public void addEnrollment(courses course, users user) {
        String sql1 = "insert into [enrollments] ([courseid] , [userid])\n"
                + "values  ( ? , ? )";
        try {
            PreparedStatement pre1 = connection.prepareStatement(sql1);
            pre1.setInt(1, course.getCourseid());
            pre1.setInt(2, user.getUserid());
            pre1.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteFromCart(courses course, users user) {
        String sql1 = "delete\n"
                + "from [cart]\n"
                + "where [cart].[courseid] = ? and [cart].[userid] = ?";
        try {
            PreparedStatement pre1 = connection.prepareStatement(sql1);
            pre1.setInt(1, course.getCourseid());
            pre1.setInt(2, user.getUserid());
            pre1.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<orders> getAllOrder() {
        courseDAO cd = new courseDAO();
        List<orders> list = new ArrayList<>();
        String sql = "select *\n"
                + "from [orders]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                orders o = new orders(rs.getInt("orderid"), rs.getDate("orderdate"), rs.getString("note"), rs.getInt("totalamount"), cd.getUserById(rs.getInt("userid")));
                list.add(o);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<orders> getOrderByMonth(int month) {
        courseDAO cd = new courseDAO();
        List<orders> list = new ArrayList<>();
        String sql = "select *\n"
                + "from [orders] o\n"
                + "where month(o.[orderdate]) = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, month);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                orders o = new orders(rs.getInt("orderid"), rs.getDate("orderdate"), rs.getString("note"), rs.getInt("totalamount"), cd.getUserById(rs.getInt("userid")));
                list.add(o);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        orderDAO od = new orderDAO();
        od.deleteFromCart(od.getCourseById(11), od.getUserById(4));
    }
}
