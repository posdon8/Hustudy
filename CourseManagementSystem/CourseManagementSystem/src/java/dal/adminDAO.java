/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.time.DayOfWeek;
import java.time.format.TextStyle;
import java.util.Locale;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.Set;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.courses;
import model.enrollments;
import model.schedules;
import model.shift;
import model.users;

/**
 *
 * @author admin
 */
public class adminDAO extends DBContext {

    public List<schedules> getSchedulesByLecid(int lectid) {
        List<schedules> list = new ArrayList<>();
        courseDAO cd = new courseDAO();
        String sql = "SELECT COALESCE(s.scheduleid, 0) as scheduleid, COALESCE(s.shiftid, 0) AS shiftid, COALESCE(s.courseid, 0) AS courseid\n"
                + "FROM shift sh\n"
                + "LEFT JOIN schedules s ON sh.shiftid = s.shiftid AND s.courseid IN (SELECT courseid FROM courses WHERE userid = ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, lectid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                schedules s = new schedules(rs.getInt("scheduleid"), cd.getCourseById(rs.getInt("courseid")), getShiftByid(rs.getInt("shiftid")));
                list.add(s);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<schedules> getAllSchedulesByStuid(int stuid) {
        List<schedules> list = new ArrayList<>();
        courseDAO cd = new courseDAO();
        String sql = "SELECT s.[scheduleid],sh.shiftid,c.[courseid]\n"
                + "FROM schedules s\n"
                + "INNER JOIN enrollments e ON s.courseid = e.courseid\n"
                + "INNER JOIN courses c ON s.courseid = c.courseid\n"
                + "INNER JOIN shift sh ON s.shiftid = sh.shiftid\n"
                + "WHERE e.userid = ?\n"
                + "GROUP BY s.[scheduleid],sh.shiftid,c.[courseid]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, stuid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                schedules s = new schedules(rs.getInt("scheduleid"), cd.getCourseById(rs.getInt("courseid")), getShiftByid(rs.getInt("shiftid")));
                list.add(s);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public shift getShiftByid(int shiftid) {
        String sql = "select * from [shift] where [shiftid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, shiftid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                shift s = new shift(rs.getInt("shiftid"), rs.getString("dayofweek"), rs.getString("shiftname"));
                return s;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public enrollments getEnrollByid(int enrollid) {
        String sql = "select * from [enrollments] where [enrollmentid] = ?";
        courseDAO cd = new courseDAO();
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, enrollid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                enrollments e = new enrollments(rs.getInt("enrollmentid"), cd.getUserById(rs.getInt("userid")), cd.getCourseById(rs.getInt("courseid")));
                return e;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<courses> getAllCourseInEnroll(int userid) {
        List<courses> list = new ArrayList<>();
        courseDAO cd = new courseDAO();
        String sql = "select distinct c.*\n"
                + "from [enrollments] e\n"
                + "join [courses] c on c.[courseid] = e.[courseid]\n"
                + "where c.[userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), cd.getTypecourseById(rs.getInt("typecourseid")), cd.getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<shift> getAllShift() {
        List<shift> list = new ArrayList<>();
        courseDAO cd = new courseDAO();
        String sql = "select * from [shift]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                shift s = new shift(rs.getInt("shiftid"), rs.getString("dayofweek"), rs.getString("shiftname"));
                list.add(s);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<users> getAllUserByRole(String role) {
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
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void deleteUser(users user) {
        String sql = "delete from [users] where [userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, user.getUserid());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteCourses(int courseid) {
        String sql = "DELETE FROM courses WHERE courseid = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addCategory(String categoryname) {
        String sql = "INSERT INTO category (categoryname)\n"
                + "VALUES ( ? );";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, categoryname);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    

    public void deleteCategory(int categoryid) {
        String sql = "DELETE FROM category WHERE categoryid = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, categoryid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addTypeCourse(String typecoursename, int categoryid) {
        String sql = "INSERT INTO typecourse (typecoursename, categoryid)\n"
                + "VALUES (?, ?);";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, typecoursename);
            pre.setInt(2, categoryid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addCourse(String title, String description, int price, String linkimg, int typecourseid, int userid) {
        String sql = "insert into [courses]([title],[description],[price],[linkimg],[typecourseid],[userid])\n"
                + "values ( ? , ? , ? , ? , ? , ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, title);
            pre.setString(2, description);
            pre.setInt(3, price);
            pre.setString(4, linkimg);
            pre.setInt(5, typecourseid);
            pre.setInt(6, userid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateCourse(String title, String description, int price, int courseid) {
        String sql = "update [courses] set [title] = ? ,[description] = ?,[price] = ? where [courseid] = ?\n";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, title);
            pre.setString(2, description);
            pre.setInt(3, price);
            pre.setInt(4, courseid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Integer> courseSold() {
        List<Integer> list = new ArrayList<>();
        String sql = "WITH Months AS (\n"
                + "    SELECT 1 AS MonthNumber\n"
                + "    UNION SELECT 2 UNION SELECT 3\n"
                + "    UNION SELECT 4 UNION SELECT 5\n"
                + "    UNION SELECT 6 UNION SELECT 7\n"
                + "    UNION SELECT 8 UNION SELECT 9\n"
                + "    UNION SELECT 10 UNION SELECT 11\n"
                + "    UNION SELECT 12\n"
                + ")\n"
                + "SELECT m.MonthNumber AS OrderMonth,COALESCE(YEAR(o.orderdate), YEAR(GETDATE())) AS OrderYear,COUNT(od.courseid) AS CoursesSold\n"
                + "FROM Months m\n"
                + "LEFT JOIN orders o ON m.MonthNumber = MONTH(o.orderdate)\n"
                + "LEFT JOIN orderdetails od ON o.orderid = od.orderid\n"
                + "GROUP BY m.MonthNumber, YEAR(o.orderdate)\n"
                + "ORDER BY OrderYear, OrderMonth;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int i = rs.getInt("CoursesSold");
                list.add(i);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Integer> totalAmountSold() {
        List<Integer> list = new ArrayList<>();
        String sql = "WITH Months AS (\n"
                + "    SELECT 1 AS MonthNumber\n"
                + "    UNION SELECT 2 UNION SELECT 3\n"
                + "    UNION SELECT 4 UNION SELECT 5\n"
                + "    UNION SELECT 6 UNION SELECT 7\n"
                + "    UNION SELECT 8 UNION SELECT 9\n"
                + "    UNION SELECT 10 UNION SELECT 11\n"
                + "    UNION SELECT 12\n"
                + ")\n"
                + "SELECT m.MonthNumber AS OrderMonth, COALESCE(YEAR(o.orderdate), YEAR(GETDATE())) AS OrderYear, ISNULL(SUM(o.totalamount), 0) AS TotalAmountSold\n"
                + "FROM Months m\n"
                + "LEFT JOIN orders o ON m.MonthNumber = MONTH(o.orderdate)\n"
                + "GROUP BY m.MonthNumber, YEAR(o.orderdate)\n"
                + "ORDER BY OrderYear, OrderMonth;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int i = rs.getInt("totalAmountSold");
                list.add(i);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void addNew(String title, String content) {
        LocalDate currentDate = LocalDate.now();
        String date = String.valueOf(currentDate);
        String sql = "insert into [news]([title],[content],[publisheddate],[userid])\n"
                + "values ( ? , ? , ? , 21 )";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, title);
            pre.setString(2, content);
            pre.setString(3, date);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteNew(int newsid) {
        String sql = "DELETE FROM [news] WHERE newsid = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, newsid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void send(String user, String pass, List<String> to, String sub, String msg) {
        for (int i = 0; i < to.size(); i++) {
            sendOne(user, pass, to.get(i), sub , msg);
        }
    }

    public void sendOne(String user, String pass, String to, String sub, String msg) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(sub);
            message.setContent(msg, "text/html");
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public List<String> getAllMailByRole(String role) {
        List<String> l = new ArrayList<>();
        String sql = "select u.[email]\n"
                + "from [users] u\n"
                + "where u.[role] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, role);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String e = rs.getString("email");
                l.add(e);
            }
            return l;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void addSchedules(int courseid, int shiftid) {
        String sql = "insert into [schedules]([courseid],[shiftid]) values ( ?  , ? ) ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseid);
            pre.setInt(2, shiftid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void dropSchedules(int userid) {
        String sql = "DELETE FROM s\n"
                + "FROM [schedules] s\n"
                + "INNER JOIN [courses] c ON s.[courseid] = c.[courseid]\n"
                + "WHERE c.[userid] = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Integer> generateRandomShiftIds(int numberOfShifts, int size) {
        List<Integer> shiftIds = new ArrayList<>();
        Random random = new Random();
        for (int i = 0; i < numberOfShifts; i++) {
            shiftIds.add(random.nextInt(size) + 1);
        }
        return shiftIds;
    }

    public List<Integer> getAllCourseidEnrolled(int userid) {
        dropSchedules(userid);
        List<Integer> l = new ArrayList<>();
        String sql = "select distinct e.courseid\n"
                + "from [enrollments] e\n"
                + "where e.courseid in (select courseid from [courses] c where c.[userid] = ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int i = rs.getInt("courseid");
                l.add(i);
            }
            return l;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void addAllSchedules(List<Integer> lc) {
        List<Integer> lshifta = generateRandomShiftIds(lc.size(), 18);
        List<Integer> lshiftb = generateRandomShiftIds(lc.size(), 12);
        for (int i = 0; i < lshifta.size(); i++) {
            addSchedules(lc.get(i), lshifta.get(i));
        }
        for (int i = 0; i < lshiftb.size(); i++) {
            addSchedules(lc.get(i), lshiftb.get(i) + 17);
        }
    }

    public List<Integer> getAllLectId() {
        List<Integer> l = new ArrayList<>();
        String sql = "select u.[userid]\n"
                + "from [users] u\n"
                + "where u.[role] = 'lecturer' ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int i = rs.getInt("userid");
                l.add(i);
            }
            return l;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void addAllSchedulesForAllLect() {
        List<Integer> l = getAllLectId();
        for (int i = 0; i < l.size(); i++) {
            addAllSchedules(getAllCourseidEnrolled(l.get(i)));
        }
    }
//            if (ls.get(i).getSchedulesid() == 0) {
//                System.out.print("X,");
//            } else {
//                System.out.print(ls.get(i).getShiftid().toString() + ",");
//            }

    public static void main(String[] args) {
        adminDAO ad = new adminDAO();
        courseDAO cd = new courseDAO();
        ad.addTypeCourse("physics", 8);

    }
}
