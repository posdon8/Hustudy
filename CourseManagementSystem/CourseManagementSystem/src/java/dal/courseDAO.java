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
import model.category;
import model.courses;
import model.document;
import model.enrollments;
import model.grades;
import model.lessons;
import model.news;
import model.reviews;
import model.typecourse;
import model.users;

/**
 *
 * @author admin
 */
public class courseDAO extends DBContext {

    public List<document> getAllDocument(lessons lesson) {
        List<document> list = new ArrayList<>();
        String sql = "select * from [document] where [lessonsid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, lesson.getLessonid());
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                document d = new document(rs.getInt("documentid"), rs.getString("videourl"), rs.getString("slideurl"), lesson);
                list.add(d);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<lessons> getAllLesson(courses course) {
        List<lessons> list = new ArrayList<>();
        String sql = "select * from [lessons] where [courseid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, course.getCourseid());
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                lessons d = new lessons(rs.getInt("lessonid"), rs.getString("lessonname"), course);
                list.add(d);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<courses> getAllCourse() {
        List<courses> list = new ArrayList<>();
        String sql = "select * from [courses]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<users> getAllUser() {
        List<users> list = new ArrayList<>();
        String sql = "select * from [users]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
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

    public List<users> getAllUserByCourseId(int courseid) {
        List<users> list = new ArrayList<>();
        String sql = "select u.*\n"
                + "from [enrollments] e\n"
                + "join [courses] c on e.[courseid] = c.[courseid]\n"
                + "join [users] u on u.[userid] = e.[userid]\n"
                + "where c.[courseid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseid);
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

    public List<users> getTop3LecturerBest() {
        List<users> list = new ArrayList<>();
        String sql = "select top 3 u.[userid],u.[username], u.[password], u.[fullname], u.[email], u.[avatar],u.[role], count(e.courseid) as courses_sold\n"
                + "from users u\n"
                + "join courses c on u.userid = c.userid\n"
                + "left join enrollments e on c.courseid = e.courseid\n"
                + "group by u.[userid],u.[username], u.[password], u.[fullname], u.[email], u.[avatar],u.[role]\n"
                + "order by courses_sold desc;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
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

    public List<category> getAllCategory() {
        List<category> list = new ArrayList<>();
        String sql = "select * from [category]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                category c = new category(rs.getInt("categoryid"), rs.getString("categoryname"));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public category getCategoryById(int categoryid) {
        String sql = "select * from [category] where [categoryid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, categoryid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                category c = new category(categoryid, rs.getString("categoryname"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<typecourse> getAllTypecourseByCategory(int categoryid) {
        List<typecourse> list = new ArrayList<>();
        String sql = "select * from [typecourse] where [categoryid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, categoryid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                typecourse t = new typecourse(rs.getInt("typecourseid"), rs.getString("typecoursename"), getCategoryById(rs.getInt("categoryid")));
                list.add(t);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<typecourse> getAllTypecourse() {
        List<typecourse> list = new ArrayList<>();
        String sql = "select *\n"
                + "from [typecourse] tc\n"
                + "order by tc.[categoryid] asc";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                typecourse t = new typecourse(rs.getInt("typecourseid"), rs.getString("typecoursename"), getCategoryById(rs.getInt("categoryid")));
                list.add(t);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public typecourse getTypecourseById(int typecourseid) {
        String sql = "select * from [typecourse] where [typecourseid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, typecourseid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                typecourse t = new typecourse(typecourseid, rs.getString("typecoursename"), getCategoryById(rs.getInt("categoryid")));
                return t;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<courses> getNumberOfCourseBought() {
        List<courses> list = new ArrayList<>();
        String sql = "select c.[courseid], c.[title], c.[description], c.[price], c.[linkimg], c.[typecourseid], c.[userid] ,COUNT(e.[enrollmentid]) as enrollments_count\n"
                + "from [courses] c\n"
                + "join [enrollments] e on c.[courseid] = e.[courseid]\n"
                + "group by c.[courseid], c.[title], c.[description], c.[price], c.[linkimg], c.[typecourseid], c.[userid]\n"
                + "order by enrollments_count desc;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<courses> getTop3NumberOfCourseBought() {
        List<courses> list = new ArrayList<>();
        String sql = "select top 3 c.[courseid], c.[title], c.[description], c.[price], c.[linkimg], c.[typecourseid], c.[userid] ,COUNT(e.[enrollmentid]) as enrollments_count\n"
                + "from [courses] c\n"
                + "join [enrollments] e on c.[courseid] = e.[courseid]\n"
                + "group by c.[courseid], c.[title], c.[description], c.[price], c.[linkimg], c.[typecourseid], c.[userid]\n"
                + "order by enrollments_count desc;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public courses getCourseById(int courseid) {
        String sql = "select * from [courses] where [courseid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public enrollments getEnrollById(int enrollid) {
        String sql = "select * from [enrollments] where [enrollmentid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, enrollid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                enrollments e = new enrollments(rs.getInt("enrollmentid"), getUserById(rs.getInt("userid")), getCourseById(rs.getInt("courseid")));
                return e;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<enrollments> getAllEnrollment() {
        List<enrollments> list = new ArrayList<>();
        String sql = "select * from [enrollments]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                enrollments e = new enrollments(rs.getInt("enrollmentid"), getUserById(rs.getInt("userid")), getCourseById(rs.getInt("courseid")));
                list.add(e);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<reviews> getAllReviewByCourseId(int courseid) {
        List<reviews> list = new ArrayList<>();
        String sql = "select * from [reviews] where [courseid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                reviews r = new reviews(rs.getInt("reviewid"), rs.getString("comment"), rs.getInt("rating"), getUserById(rs.getInt("userid")), getCourseById(rs.getInt("courseid")));
                list.add(r);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<courses> getAllCourseByCategory(String categoryname) {
        List<courses> list = new ArrayList<>();
        String sql = "select * \n"
                + "from [courses] c\n"
                + "join [typecourse] t on c.[typecourseid] = t.[typecourseid]\n"
                + "join [category] ca on ca.[categoryid] = t.[categoryid]\n"
                + "where ca.[categoryname] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, categoryname);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<courses> getAllCourseByCateType(String categoryname, String typename) {
        List<courses> list = new ArrayList<>();
        String sql = "select * \n"
                + "from [courses] c\n"
                + "join [typecourse] t on c.[typecourseid] = t.[typecourseid]\n"
                + "join [category] ca on ca.[categoryid] = t.[categoryid]\n"
                + "where ca.[categoryname] = ? and t.[typecoursename] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, categoryname);
            pre.setString(2, typename);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean checkEnrollment(int userid, int courseid) {
        String sql = "select *\n"
                + "from [enrollments]\n"
                + "where [userid] = ? and [courseid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, userid);
            pre.setInt(2, courseid);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public List<courses> getAllCourseByUserId(users user) {
        List<courses> list = new ArrayList<>();
        String sql = "select c.[courseid], c.[title], c.[description], c.[price], c.[linkimg], c.[typecourseid], c.[userid]\n"
                + "from [courses] c\n"
                + "join [enrollments] e on c.[courseid] = e.[courseid]\n"
                + "where e.[userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, user.getUserid());
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Float> getPercentRate(List<reviews> l) {
        List<Float> list = new ArrayList<>();
        int s1 = 0, s2 = 0, s3 = 0, s4 = 0, s5 = 0;
        for (int i = 0; i < l.size(); i++) {
            if (l.get(i).getRating() == 1) {
                s1 += 1;
            } else if (l.get(i).getRating() == 2) {
                s2 += 1;
            } else if (l.get(i).getRating() == 3) {
                s3 += 1;
            } else if (l.get(i).getRating() == 4) {
                s4 += 1;
            } else if (l.get(i).getRating() == 5) {
                s5 += 1;
            }
        }
        list.add((float) (Math.round((float) s1 / l.size() * 10.0) / 10.0));
        list.add((float) (Math.round((float) s2 / l.size() * 10.0) / 10.0));
        list.add((float) (Math.round((float) s3 / l.size() * 10.0) / 10.0));
        list.add((float) (Math.round((float) s4 / l.size() * 10.0) / 10.0));
        list.add((float) (Math.round((float) s5 / l.size() * 10.0) / 10.0));
        return list;
    }

    public List<news> getAllNews() {
        List<news> list = new ArrayList<>();
        String sql = "select *\n"
                + "from [news]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                news n = new news(rs.getInt("newsid"), rs.getString("title"), rs.getString("content"), rs.getDate("publisheddate"));
                list.add(n);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<courses> MyCourseSearch(String keyword, int userid) {
        List<courses> list = new ArrayList<>();
        String key = "%" + keyword + "%";
        String sql = "select c.*\n"
                + "from [courses] c\n"
                + "join [typecourse] t on c.[typecourseid] = t.[typecourseid]\n"
                + "join [category] ca on t.[categoryid] = ca.[categoryid]\n"
                + "join [users] u on c.[userid] = u.[userid]\n"
                + "where ( c.[title] like ? or c.[description] like ? or c.[price] like ? or c.[price] like ? or t.[typecoursename] = ? or ca.[categoryname] = ? or u.[fullname] like ? ) and c.[userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, key);
            pre.setString(2, key);
            pre.setString(3, key);
            pre.setString(4, key);
            pre.setString(5, key);
            pre.setString(6, key);
            pre.setString(7, key);
            pre.setInt(8, userid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<courses> courseSearch(String keyword) {
        List<courses> list = new ArrayList<>();
        String key = "%" + keyword + "%";
        String sql = "select c.*\n"
                + "from [courses] c\n"
                + "join [typecourse] t on c.[typecourseid] = t.[typecourseid]\n"
                + "join [category] ca on t.[categoryid] = ca.[categoryid]\n"
                + "join [users] u on c.[userid] = u.[userid]\n"
                + "where c.[title] like ? or c.[description] like ? or c.[price] like ? or c.[price] like ? or t.[typecoursename] = ? or ca.[categoryname] = ? or u.[fullname] like ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, key);
            pre.setString(2, key);
            pre.setString(3, key);
            pre.setString(4, key);
            pre.setString(5, key);
            pre.setString(6, key);
            pre.setString(7, key);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<users> userSearch(String keyword) {
        List<users> list = new ArrayList<>();
        String key = "%" + keyword + "%";
        String sql = "select * from [users] where [fullname] like ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, key);
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

    public List<courses> getAllCourseOfLecturer(users user) {
        List<courses> list = new ArrayList<>();
        String sql = "select *\n"
                + "from [courses]\n"
                + "where [userid] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, user.getUserid());
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                courses c = new courses(rs.getInt("courseid"), rs.getString("title"), rs.getString("description"), rs.getInt("price"), rs.getString("linkimg"), getTypecourseById(rs.getInt("typecourseid")), getUserById(rs.getInt("userid")));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int getTotalEnroll(courses c) {
        String sql = "select e.[courseid] , count(e.userid) as Totalenroll\n"
                + "from [enrollments] e\n"
                + "where e.courseid = ?\n"
                + "group by e.courseid";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, c.getCourseid());
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                int i = rs.getInt("totalenroll");
                return i;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<grades> getAllGradeByCourse(int courseid) {
        List<grades> list = new ArrayList<>();
        String sql = "select e.userid, g.[gradeid] , g.midtermscore , g.finalscore , g.average, e.[enrollmentid]\n"
                + "from [enrollments] e\n"
                + "join [grades] g on e.enrollmentid = g.enrollmentid\n"
                + "where e.courseid =  ?\n"
                + "order by g.average desc";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, courseid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                grades g = new grades(rs.getInt("gradeid"), rs.getFloat("midtermscore"), rs.getFloat("finalscore"), rs.getFloat("average"), getEnrollById(rs.getInt("enrollmentid")));
                list.add(g);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void deleteLesson(int lid) {
        String sql = "DELETE FROM [document] WHERE [lessonsid] = ?;\n"
                + "DELETE FROM [lessons] WHERE [lessonid] = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, lid);
            pre.setInt(2, lid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteDocument(int did) {
        String sql = "DELETE FROM [document] WHERE [documentid] = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, did);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addlesson(String lessonname, int cid) {
        String sql = "insert into [lessons]([lessonname],[courseid])"
                + "values ( ? , ? )";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, lessonname);
            pre.setInt(2, cid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addDoc(String file, int lid) {
        String sql = "insert into [document]([lessonsid],[slideurl])"
                + "values ( ? , ? )";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, lid);
            pre.setString(2, file);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addReview(String comment, int rate, int courseid, int userid) {
        String sql = "insert into [reviews] ([comment],[rating],[courseid],[userid])\n"
                + "values  ( ? , ? , ? , ? )";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, comment);
            pre.setInt(2, rate);
            pre.setInt(3, courseid);
            pre.setInt(4, userid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        courseDAO cd = new courseDAO();
        cd.addReview("fine", 3, 109 , 4);
    }
}
