package com.test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;

import com.model.Calculate;

public class CalculateTest {
	@Test
	void testAddition() {
		Calculate calculator = new Calculate();
		assertEquals(5, calculator.addition(3, 2));
		assertEquals(9, calculator.addition(5, 4));
	}

	@Test
	void testSubstraction() {
		Calculate calculator = new Calculate();
		
		
		assertEquals(1, calculator.subtraction(3, 2));
		assertEquals(2, calculator.subtraction(5, 3));
	}

	@Test
	void testMultiplication() {
		Calculate calculator = new Calculate();

		assertEquals(6, calculator.multipler(3, 2));
		assertEquals(9, calculator.multipler(3, 3));
	}

	@Test
	void testDivision() {
		Calculate calculator = new Calculate();
		
		
		assertEquals(1, calculator.division(3, 2));
		assertEquals(2, calculator.division(4, 2));
		assertEquals(2, calculator.division(4, 0));
		assertThrows(Exception.class, () -> calculator.division(4, 0));
	}

}