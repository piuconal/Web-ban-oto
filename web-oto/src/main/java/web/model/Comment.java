package web.model;

public class Comment extends Product {
	private int uid;
	private String comment;
	private int rate;
	
	public Comment() {
	}

	public Comment(int uid, String comment, int rate) {
		super();
		this.uid = uid;
		this.comment = comment;
		this.rate = rate;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}
	
}