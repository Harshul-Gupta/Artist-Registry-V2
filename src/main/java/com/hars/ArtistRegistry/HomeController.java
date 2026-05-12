package com.hars.ArtistRegistry;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hars.ArtistRegistry.repository.Artist;
import com.hars.ArtistRegistry.repository.ArtistRepo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
	private final SpringMvcApplication springMvcApplication;

	HomeController(SpringMvcApplication springMvcApplication) {
		this.springMvcApplication = springMvcApplication;
	}
	
	@Autowired
	ArtistRepo artistRepo;
	
	@ModelAttribute
	public void ModelClass(Model m)
	{
		m.addAttribute("name", "Guest");
	}
	
//	@RequestMapping("/")
//	public String home()
//	{
//		System.out.println("Homepage");
//		return "index";
//	}
	
	@GetMapping("getArtists")
	public String getArtist(Model m)
	{
		
		m.addAttribute("artists", artistRepo.findAll());
		return "showArtist" ;
	}
	
//	@GetMapping("getArtist")
//	public String getArtist(@RequestParam("id") int aid, Model m)
//	{
//		m.addAttribute("artist", artistRepo.getReferenceById(aid));
//		return "dispArtist";
//	}
	
//	@GetMapping("getId")
//	public String getId(@RequestParam("name") String aname, Model m)
//	{
//		m.addAttribute("artist", artistRepo.getByName(aname));
//		return "dispArtist";
//	}
	
	
	@PostMapping(value= "addArtist")
	public String addArtist(@ModelAttribute("a1") Artist artist)
	{
		artistRepo.save(artist);
		return "page";
	}
}
