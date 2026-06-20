package com.hars.ArtistRegistry.Controller;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hars.ArtistRegistry.Repository.Artist;
import com.hars.ArtistRegistry.Repository.ArtistRepo;
import com.hars.ArtistRegistry.Repository.SearchRepo;
import com.hars.ArtistRegistry.Repository.SearchRepo.ArtistSlice;

@Controller
public class ArtistController {

    @Autowired
    ArtistRepo artistRepo;

    @Autowired
    MongoTemplate mongoTemplate;
    
    @Autowired
    SearchRepo sRepo;
    
    @ModelAttribute("genres")
    public List<String> populateGenres() {
        return Arrays.asList("Pop", "Jazz", "Classical", "Hip-Hop", "Electronic", "Rock", "R&B");
    }
    
    @GetMapping("/")
    public String indexPage(Model model) {
        model.addAttribute("stats", buildStats());
        return "index"; // resolves to /WEB-INF/views/index.jsp
    }
    
// First simple implementation of Search    
    
//    @GetMapping("/search")
//    public String searchPage(
//            @RequestParam(value = "name",  required = false, defaultValue = "") String name,
//            @RequestParam(value = "genre", required = false, defaultValue = "") String genre,
//            Model model) {
//
//        List<Artist> results;
//
//        if (!name.isBlank()) {
//            if (!genre.isBlank()) {
//                results = artistRepo.findByNameContainingIgnoreCaseAndGenreContaining(name, genre);
//            } else {
//                results = artistRepo.findByNameContainingIgnoreCase(name);
//            }
//        } else {
//            results = List.of(); // empty list — JSP shows hero, not results
//        }
//
//        model.addAttribute("artists", results);   // used by <c:forEach var="artist" items="${artists}">
//        return "search"; // re-uses index.jsp; EL shows results section when ${artists} is non-empty
//    }
    
// 	More production type search using MongoDB Lucene    
    
    @GetMapping("/search")
    public String search(@RequestParam(required = false) String name, 
    					@RequestParam(required= false) String genre ,
    					@RequestParam(defaultValue = "0") int page , Model model)
    {
    	ArtistSlice results =sRepo.findByNameAndGenre(name, genre, page);
    	model.addAttribute("artists", results);  
        return "search";
    }
    /**
     * Serves the full artist-library page at "/artists".
     * Populates ${artists} with every artist for a browse/listing view.
     */
    @GetMapping("/artists")
    public String artistLibraryPage(Model model) {
        model.addAttribute("artists", artistRepo.findAll());
        model.addAttribute("stats",   buildStats());
        return "artists"; // resolves to /WEB-INF/views/artists.jsp
    }
    
    @GetMapping("artist-details")
    public String getArtistDetails()
    {
    	return "Artist";
    }

    @GetMapping("/add")
    public String showAddArtistForm() {
        return "addArtist";
    }
    
    @RequestMapping("/login")
    public String loginUser()
    {
    	return "login";
    }
    
    /**
     * Serves a single-artist detail page at "/artist/{id}".
     * Populates ${artist} for EL expressions like ${artist.name}, ${artist.country}, etc.
     */

//     * Keys match the EL expressions used in index.jsp:
//     *   ${stats.totalArtists}  ${stats.totalGenres}  ${stats.totalCountries}
//     */
    private Map<String, Long> buildStats() {
        long totalArtists = mongoTemplate.getCollection("Artist").countDocuments();

        long totalGenres = mongoTemplate.getCollection("Artist")
                .distinct("genre", String.class)
                .into(new HashSet<>())
                .size();

        long totalCountries = mongoTemplate.getCollection("Artist")
                .distinct("country", String.class)
                .into(new HashSet<>())
                .size();

        return Map.of(
            "totalArtists",   totalArtists,
            "totalGenres",    totalGenres,
            "totalCountries", totalCountries
        );
    }
}