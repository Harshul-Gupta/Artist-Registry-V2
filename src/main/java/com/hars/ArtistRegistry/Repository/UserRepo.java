package com.hars.ArtistRegistry.Repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;


public interface UserRepo extends MongoRepository<User, String>{
	
	User findByUsername(String username);
}
