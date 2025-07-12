package com;

import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

public class SetTest {
	public static void main(String args[]) {
		
		Set<Integer> s = new TreeSet<>();
		Set<Integer> s1 = new HashSet<>();
		
		s.add(10);
		s.add(20);
		s.add(40);
		s.add(30);
		s.add(90);
		s1.add(1);
		s1.add(12);
		s1.add(122);
		
		System.out.println(s1.hashCode());
		
		System.out.println(s);
		
	}

}
