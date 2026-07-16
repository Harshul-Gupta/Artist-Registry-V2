package com.hars.ArtistRegistry;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.hars.ArtistRegistry.Repository.Artist;
import com.hars.ArtistRegistry.Repository.ArtistRepo;

@SpringBootTest
public class TestArtists {
	
	@Autowired
	ArtistRepo repo;
	
	@ParameterizedTest
	@CsvSource({
		"Ed Sheeran",
		"Kanye West",
		"Fred Again",
		"Martin Garrix",
		"John Summit"
	})
	void checkType(String name) {
		Artist artist= repo.findByName(name).orElse(null);
		assertNotNull(artist);
	}
	
	@Disabled
	@ParameterizedTest
	@CsvSource({
		"1, 1, 2",
		"7, 3, 10",
		"2, 8, 10"
	})
	void testSum(int a, int b, int exp) {
		assertEquals(exp, a+b);
	}
}
