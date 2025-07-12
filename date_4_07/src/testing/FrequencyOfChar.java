package testing;

public class FrequencyOfChar {

	public static void main(String args[]) {
		String str = "aabbcdabbcss";
		
		int arr[] = new int[26];
		
		for(char c:str.toCharArray()) {
			arr[c-'a']++;
		}
		
		for(int i=0;i<26;i++) {
			if(arr[i] > 0) {System.out.println((char)('a'+i) +":"+arr[i] );}
		}
	}
}
