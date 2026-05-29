package com.hars.ArtistRegistry.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.hars.ArtistRegistry.Repository.Artist;
import com.hars.ArtistRegistry.Repository.ArtistRepo;

@RestController
public class HomeController {
	
	@Autowired
	ArtistRepo repo;
	
	@GetMapping("/artist/{id}")
	public Artist getArtist(@PathVariable("id") String id)
	{
		return repo.findById(id).orElse(null);
		 
	}
}
