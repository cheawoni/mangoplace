
public class test {

	public static void main(String[] args) {
		int a = 1;
		int b = 4;
		int sum = 0;
		for(int i=a; i<=b; i++) {
			sum += i;
		}
		System.out.println("<h1>"+a+"+"+b+"="+sum+"</h1>");
		System.out.println(a+"+"+b);
		
		// 1+2+3+4
		for(int i=a; i<=b; i++) {
			if(i<b) System.out.println(i+"+");
			else System.out.println(i);
		}
	}
}
