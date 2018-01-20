package pe.gallery.dto;
import java.sql.*;

public class MyItem {
	public String hp1=null;
	public String hp2=null;
	public String hp3=null;
	public String songList=null;
	public Timestamp regdt = null;
	
	public MyItem() {}
	
	public MyItem(String hp1,String hp2,String hp3,String songList,Timestamp regdt) {
		this.hp1 = hp1;
		this.hp2 = hp2;
		this.hp3 = hp3;
		this.songList = songList;
		this.regdt = regdt;
	}
	
	public String toString() {
		return hp1+"-"+hp2+"-"+hp3+":"+songList+":"+regdt.toString();
	}
}
