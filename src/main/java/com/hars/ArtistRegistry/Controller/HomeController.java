package com.hars.ArtistRegistry.Controller;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hars.ArtistRegistry.Repository.Artist;
import com.hars.ArtistRegistry.Repository.ArtistRepo;
import com.hars.ArtistRegistry.Service.SpotifyMetricService;

@RestController
@RequestMapping("api/artists")
public class HomeController {
	
	private final ArtistRepo repo;
	private final SpotifyMetricService spotifyService;
	
	public HomeController(ArtistRepo repo, SpotifyMetricService spotifyService) {
		
		this.repo= repo;
		this.spotifyService= spotifyService;
	}
	
	
	
	@GetMapping("{id}")
	public ResponseEntity<Artist> getArtist(@PathVariable String id)
	{
		//3rd Part Rapid API to fetch Spotify Monthly listeners deprecated as it is a learning project 
		//Long liveListeners= spotifyService.getMonthlyListeners(artist.getSpotifyId());
		//Map<String, Object> response = new HashMap<>();
		//response.put("monthlyListeners", liveListeners);
        //response.put("artist", artist);
		Artist artist= repo.findById(id).orElse(null);
        
		return new ResponseEntity<>(artist, HttpStatus.OK);
	}
	
	@PostMapping(value= "/send")
	public ResponseEntity<Artist> addArtist(@RequestBody Artist artist)
	{
		Artist createdArtist= repo.save(artist);
		return new ResponseEntity<Artist>(createdArtist, HttpStatus.CREATED);
	}
}
