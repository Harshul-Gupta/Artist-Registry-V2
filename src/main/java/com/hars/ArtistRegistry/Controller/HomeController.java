package com.hars.ArtistRegistry.Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.hars.ArtistRegistry.Repository.Artist;
import com.hars.ArtistRegistry.Repository.ArtistRepo;
import com.hars.ArtistRegistry.Service.ArtistService;
import com.hars.ArtistRegistry.Service.S3ImageService;
import com.hars.ArtistRegistry.Service.SpotifyMetricService;

@RestController
@RequestMapping("api/artists")
public class HomeController {
	
	private final ArtistRepo repo;
	private final S3ImageService s3ImageService;
	private final ArtistService artistService;
	
	@Autowired
	private SpotifyMetricService spotifyService;
	
	public HomeController(ArtistRepo repo, S3ImageService s3ImageService, ArtistService artistService) {
		
		this.repo= repo;
		this.s3ImageService= s3ImageService;
		this.artistService= artistService;
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
	
	@PostMapping("/send")
	public ResponseEntity<Artist> addArtist(@RequestPart Artist artist, @RequestPart MultipartFile file) throws IOException
	{
		String publicS3Url = s3ImageService.uploadArtistImage(file);
		artist.setImageURL(publicS3Url);
		Artist createdArtist= repo.save(artist);
		return new ResponseEntity<Artist>(createdArtist, HttpStatus.CREATED);
	}
	
	@PatchMapping("/{mongoId}")
	public ResponseEntity<Artist> editArtist(@PathVariable String mongoId, @RequestPart Map<String, Object> updates, @RequestPart MultipartFile file)
	{
		 return ResponseEntity.ok(artistService.updateArtist(mongoId, updates, file));
	}
	
	@DeleteMapping("/{mongoId}")
	public ResponseEntity<String> removeArtist(@PathVariable String mongoId)
	{
		artistService.deleteArtist(mongoId);
		return ResponseEntity.ok("Artist deleted successfully!");
	}
}
