package pe.gallery.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import pe.gallery.dto.MyItem;

public class MyItemManager {

	public static void main(String[] args) {
		java.util.Date date = new java.util.Date();
		Timestamp regdt = new java.sql.Timestamp(date.getTime());
		MyItem item = new MyItem("010","9119","6300","A",regdt);
		try {
			MyItemManager.createMyItem(item);
			item.songList = "B";
			MyItemManager.updateMyItem(item);
			item = MyItemManager.getMyItem("010","9119","6300");
			System.out.println(item.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static boolean createMyItem(MyItem item) throws Exception {
		Connection conn =DataSource.getInstance().getConnection();
		String sql = "insert into users(hp1,hp2,hp3,songlist,regdt) values(?,?,?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, item.hp1);
		pstmt.setString(2, item.hp2);
		pstmt.setString(3, item.hp3);
		pstmt.setString(4, item.songList);
		pstmt.setTimestamp(5, item.regdt);
		
		boolean result = pstmt.execute();
		if(pstmt!=null) pstmt.close();
		if(conn!=null)  conn.close();
		return result;
	}
	
	public static boolean updateMyItem(MyItem item) throws Exception {
		Connection conn =DataSource.getInstance().getConnection();
		String sql = "update users set songlist=?,regdt=? where hp1=? and hp2=? and hp3=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);		
		pstmt.setString(1, item.songList);
		pstmt.setTimestamp(2,item.regdt);
		pstmt.setString(3, item.hp1);
		pstmt.setString(4, item.hp2);
		pstmt.setString(5, item.hp3);
		int cnt = pstmt.executeUpdate();
		if(pstmt!=null) pstmt.close();
		if(conn!=null)  conn.close();
		return cnt==1;
	}	
	
	public static MyItem getMyItem(String hp1,String hp2,String hp3) throws Exception {
		Connection conn =DataSource.getInstance().getConnection();
		String sql = "select hp1,hp2,hp3,songlist,regdt from users where hp1=? and hp2=? and hp3=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);		
		pstmt.setString(1,hp1);
		pstmt.setString(2,hp2);
		pstmt.setString(3,hp3);
		ResultSet rs = pstmt.executeQuery();
		boolean hasData = rs.next();
		MyItem item = null;
		if (hasData) {
			String songList = rs.getString("songlist");
			Timestamp regdt = rs.getTimestamp("regdt");
			item = new MyItem(hp1,hp2,hp3,songList,regdt);
		}
		rs.close();
		if(pstmt!=null) pstmt.close();
		if(conn!=null)  conn.close();
		return item;
	}
	
	//TODO  삭제기능추가.
}
