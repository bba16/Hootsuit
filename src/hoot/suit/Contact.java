package hoot.suit;

public class Contact {
	private String name, phone, twitter;
	public Contact(String name, String phone, String twitter) {
		this.name = name;
		this.phone = phone;
		this.twitter = twitter;
	}
	public String getName() {
		return name;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public String getTwitter() {
		return twitter;
	}

}
