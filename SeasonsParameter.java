package decisiontree;
public class SeasonsParameter {
	private int good = 0;
	public int getGood() {
		return this.good;
	}
	public void setGood(int value) {
		this.good = value;
	}
	private int bad = 0;
	public int getBad() {
		return this.bad;
	}
	public void setBad(int value) {
		this.bad = value;
	}
	
	public SeasonsParameter(int good, int bad) {
		this.good = good;
		this.bad = bad;
	}
}
