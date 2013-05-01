package hoot.suit;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

public class DataBase {
	private Connection connection;	

	public void open() throws Exception{
        try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection("jdbc:mysql://localhost/phonebook" + 
                    "?user=root&password=123456");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new Exception(e.toString());
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			throw new Exception(e.toString());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			throw new Exception(e.toString());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			throw new Exception(e.toString());
		}
	}
	
	public Vector<Contact> getAll() throws Exception {
		try {
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery("SELECT name, phone, twitter FROM phonebook");
			Vector<Contact> contacts = new Vector<Contact>();
			while(resultSet.next()) {
				String name, phone, twitter;
				name = resultSet.getString("name");
				phone = resultSet.getString("phone");
				twitter = resultSet.getString("twitter");				
				contacts.add(new Contact(phone, name, twitter));
			}
			resultSet.close();
			statement.close();
			return contacts;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new Exception(e.toString());
		}
		
		return null;		
	}
	
	public Contact getContact(String name) throws Throwable {
		try {
			PreparedStatement preparedStatement = connection.prepareStatement("SELECT name, phone,twitter FROM phonebook WHERE name = ?");
			preparedStatement.setString(1, name);
			ResultSet resultSet = preparedStatement.executeQuery();
			String phone, twitter;
			Contact contact;
			if (resultSet.next()) {
				name = resultSet.getString("name");
				phone = resultSet.getString("phone");
				twitter = resultSet.getString("twitter");
				contact = new Contact(name, phone, twitter);
			} else 
				contact = null;
			resultSet.close();
			preparedStatement.close();
			return contact;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new Exception(e.toString());
		}
	}
	
	public void add(Contact contact) throws Exception {
		try {
			PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO phonebook(name, phone, twitter) VALUES(?,?,?)");
			preparedStatement.setString(1,  contact.getName());
			preparedStatement.setString(2,  contact.getPhone());
			preparedStatement.setString(3,  contact.getTwitter());
			preparedStatement.execute(); // TODO error check!			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new Exception(e.toString());
		}
	}	
	
	public void close() {
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
