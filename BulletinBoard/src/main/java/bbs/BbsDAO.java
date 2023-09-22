package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.math.BigInteger;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO(){
		try {
			
			String dbURL = "jdbc:mysql://localhost:3306/bbs";
			String dbUsername = "root";
			String dbPassword = "dbuserdbuser";
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// returns the index
	public int getNext() {
		String sql = "SELECT bbsIndex FROM article ORDER BY bbsIndex DESC";
		try {
			NamedParameterStatement pstmt = new NamedParameterStatement(conn, sql);
			rs = pstmt.executeQuery();
			if(rs.next()) { // if there is a next 
				return rs.getInt(1) + 1;
			}
			return 1; // if this is a first
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // error
	}
	
	public int write(String bbsTitle, String bbsContent, String bbsAuthor, String bbsDate) {
		String sql = "INSERT INTO article VALUES (:bbsIndex, :bbsTitle, :bbsContent, :bbsAuthor, :bbsDate, :availableInt)";
		try {
			NamedParameterStatement pstmt = new NamedParameterStatement(conn, sql);
			pstmt.setInt("bbsIndex", getNext());
			pstmt.setString("bbsTitle", bbsTitle);
			pstmt.setString("bbsContent", bbsContent);
			pstmt.setString("bbsAuthor", bbsAuthor);
			pstmt.setString("bbsDate", bbsDate);
			pstmt.setInt("availableInt", 1);
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			
		}
		return -1;
	}
	
	public Bbs getBbs(int bbsIndex) {
		String sql = "SELECT * FROM article WHERE bbsIndex =:bbsIndex";
		try {
			NamedParameterStatement pstmt = new NamedParameterStatement(conn, sql);
			pstmt.setInt("bbsIndex", bbsIndex);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsIndex(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setBbsContent(rs.getString(3));
				bbs.setBbsAuthor(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setAvailableInt(rs.getInt(6));
				return bbs;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	public int edit(int bbsIndex, String bbsTitle, String bbsContent, String bbsAuthor, String bbsDate) {
		System.out.println("bbsAuthor="+bbsAuthor);
		String sql = "UPDATE article SET bbsTitle =:bbsTitle, bbsContent =:bbsContent, bbsAuthor =:bbsAuthor, bbsDate =:bbsDate WHERE bbsIndex =:bbsIndex";
		try {
			NamedParameterStatement pstmt = new NamedParameterStatement(conn, sql);
			pstmt.setString("bbsTitle", bbsTitle);
			pstmt.setString("bbsContent", bbsContent);
			pstmt.setString("bbsAuthor", bbsAuthor);
			pstmt.setString("bbsDate", bbsDate);
			pstmt.setInt("bbsIndex", bbsIndex);
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			
		}
		return -1;
	}
	
	public int getBbsCount(String search) {
		String sql = "SELECT COUNT(*) FROM article WHERE availableInt = 1 AND (bbsauthor LIKE CONCAT('%', :search, '%') OR bbscontent LIKE CONCAT('%', :search, '%') OR bbstitle LIKE CONCAT('%', :search, '%'))";
		try {
			NamedParameterStatement pstmt = new NamedParameterStatement(conn, sql);
			pstmt.setString("search", search);
			pstmt.setString("search", search);
			pstmt.setString("search", search);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsIndex) {
		String sql = "UPDATE article SET availableInt=0 WHERE bbsIndex=:bbsIndex";
		try {
			NamedParameterStatement pstmt = new NamedParameterStatement(conn, sql);
			pstmt.setInt("bbsIndex", bbsIndex);
			return pstmt.executeUpdate(); //returns the number of deleted articles
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Bbs> getList(String search, int pageNumber, int postsPerPage) {
		String sql = "SELECT bbsIndex, bbsAuthor, bbsContent, bbsTitle, bbsDate, availableInt FROM article WHERE availableint = 1 AND "
				+ "(bbsauthor LIKE CONCAT('%', :search, '%') OR bbscontent LIKE CONCAT('%', :search, '%') OR bbstitle LIKE CONCAT('%', :search, '%')) "
				+ "ORDER BY bbsindex DESC LIMIT :min, :max";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		int startRow = (pageNumber-1)*postsPerPage+1;
		try {
			NamedParameterStatement pstmt = new NamedParameterStatement(conn, sql);
			pstmt.setString("search", search);
			pstmt.setString("search", search);
			pstmt.setString("search", search);
			pstmt.setInt("min", startRow-1);
			pstmt.setInt("max", postsPerPage);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsIndex(rs.getInt("bbsIndex"));
				bbs.setBbsTitle(rs.getString("bbsAuthor"));
				bbs.setBbsContent(rs.getString("bbsContent"));
				bbs.setBbsAuthor(rs.getString("bbsTitle"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setAvailableInt(rs.getInt("availableInt"));
				list.add(bbs);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// login function
	public int login(String userID, String userPassword) {
		SHA sha = new SHA();
		String encrypted = sha.getSHA512(userPassword);
		
		String sql = "SELECT userPassword FROM USER WHERE userID = :userID"; // find the saved password of the input user
		try {
			NamedParameterStatement pstmt = new NamedParameterStatement(conn, sql);
			pstmt.setString("userID", userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("userPassword").equals(encrypted)) {
					return 1; // the input password IS the user's password! (passwords matched)
				}
				else {
					return 0; // the input password is not the user's password! (uh-oh wrong password)
				}
			}
			return -1; // no such user (failed to find a password)
		} 
		catch (Exception e) {
			e.printStackTrace();
			
		}
		return -2; // database exception
	}
	
	// create user
	public int register(String userID, String userPassword, String userName, String userGender, String userEmail) {
		SHA sha = new SHA();
		String encrypted = sha.getSHA512(userPassword);
		
		String sql = "INSERT INTO USER VALUES (:userID, :userPassword, :userName, :userGender, :userEmail)";
		try {
			NamedParameterStatement pstmt = new NamedParameterStatement(conn, sql);
			pstmt.setString("userID", userID);
			pstmt.setString("userPassword", encrypted);
			pstmt.setString("userName", userName);
			pstmt.setString("userGender", userGender);
			pstmt.setString("userEmail", userEmail);
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			
		}
		return -1;
	}

}
