package decisiontree;
public class SummerParameter extends SeasonsParameter {
	
	private int sun = 0;
	public int getSun() {
		return this.sun;
	}
	public void setSun(int value) {
		this.sun = value;
	}
	
	private int wind = 0;
	public int getWind() {
		return this.wind;
	}
	public void setWind(int value) {
		this.wind = value;
	}
	
	
	public SummerParameter(int sun, int wind) {
		super(5, 0);
		this.sun = sun;
		this.wind = wind;
	}
}
