package com.hars.ArtistRegistry.Service;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hars.ArtistRegistry.Repository.Artist;
import com.hars.ArtistRegistry.Repository.ArtistRepo;

import tools.jackson.databind.ObjectMapper;

@Service
public class ArtistService {
	
	private final ArtistRepo artistRepo;
	private final ObjectMapper objectMapper;
	private final S3ImageService s3ImageService;
	
	public ArtistService(ArtistRepo artistRepo, ObjectMapper objectMapper, S3ImageService s3ImageService) {
		
		this.artistRepo= artistRepo;
		this.objectMapper= objectMapper;
		this.s3ImageService= s3ImageService;
	}
	
	public Artist updateArtist(String mongoId, Map<String, Object> updates, MultipartFile file)
	{
		Artist existingArtist= artistRepo.findById(mongoId).orElseThrow(() -> new RuntimeException("Artist not found"));
		
		Artist updatedArtist= objectMapper.convertValue(updates, Artist.class);
		
		boolean deleteImage= false;
		String oldImageURL= existingArtist.getImageURL();
		
		if(file!=null && !file.isEmpty())
		{
			try {
			String newImageURL= s3ImageService.uploadArtistImage(file);
			existingArtist.setImageURL(newImageURL);
			deleteImage= true;
			}catch (Exception e) {
				throw new RuntimeException("Failure to upload image");
			}
			
		}
		
		updates.forEach((K, V) -> {
			switch (K) {
			case "name" -> { 
				if(V == null || V.toString().isBlank())
					throw new IllegalArgumentException("Name can't be blank");
				existingArtist.setName(updatedArtist.getName());
			}
			case "bio" -> existingArtist.setBio(updatedArtist.getBio());
			case "country" -> existingArtist.setCountry(updatedArtist.getCountry());
			case "genre" -> existingArtist.setGenre(updatedArtist.getGenre());
			case "type" -> existingArtist.setType(updatedArtist.getType());
			}	
		});
		
		Artist newArtist = artistRepo.save(existingArtist);
		
		if(deleteImage && oldImageURL!=null && !oldImageURL.isBlank() && oldImageURL.contains("image/")) 
		{
			String key= oldImageURL.substring(oldImageURL.lastIndexOf("image/"));
			s3ImageService.deleteArtistImage(key);
		}
		return newArtist;
	}
	
	public void deleteArtist(String mongoId)
	{
		Artist artist= artistRepo.findById(mongoId).orElseThrow(() -> new IllegalArgumentException("Artist not found"));
		String imageURL= artist.getImageURL();
		if(imageURL != null && !imageURL.isBlank() && imageURL.contains("image/"))
		{
			String key= imageURL.substring(imageURL.lastIndexOf("image/"));
			s3ImageService.deleteArtistImage(key);
		}
		artistRepo.delete(artist);
	}
}
