package com.hars.ArtistRegistry;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

@SpringBootApplication
@EnableMongoRepositories(basePackages = "com.hars.ArtistRegistry.model")
public class SpringMvcApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(SpringMvcApplication.class, args);
	}

}
