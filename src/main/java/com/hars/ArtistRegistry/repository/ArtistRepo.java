 package com.hars.ArtistRegistry.repository;


import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
public interface ArtistRepo extends MongoRepository<Artist, String>{

	List<Artist> findByNameContainingIgnoreCaseAndGenreContaining(String name, String genre);

	List<Artist> findByNameContainingIgnoreCase(String name);

	

}
