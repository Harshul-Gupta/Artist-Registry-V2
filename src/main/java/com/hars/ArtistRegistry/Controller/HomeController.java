package com.hars.ArtistRegistry.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hars.ArtistRegistry.Repository.Artist;
import com.hars.ArtistRegistry.Repository.ArtistRepo;

@RestController
@RequestMapping("api/artists")
public class HomeController {
	
	@Autowired
	ArtistRepo repo;
	
	@GetMapping("{id}")
	public ResponseEntity<Artist> getArtist(@PathVariable String id)
	{
		Artist artist= repo.findById(id).orElse(null);
		return new ResponseEntity<Artist>(artist, HttpStatus.OK);
	}
	
	@PostMapping(value= "/send")
	public ResponseEntity<Artist> addArtist(@RequestBody Artist artist)
	{
		Artist createdArtist= repo.save(artist);
		return new ResponseEntity<Artist>(createdArtist, HttpStatus.CREATED);
	}
}
