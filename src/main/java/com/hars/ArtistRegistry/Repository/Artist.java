package com.hars.ArtistRegistry.Repository;

import java.util.HashSet;
import java.util.Set;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Document(collection = "Artist")
@Getter
@Setter
public class Artist {
	@Id
	private String mongoId;
	   
	@Field("id") 
	private String id;

	@NotBlank(message = "Name is required")
	private String name;

    private ArtistType type; 

    private String bio;

	@NotBlank(message = "Country is required")
	private String country;
	
	private Set<String> genre = new HashSet<>();
	
	private String imageURL;

	public String getMongoId() {
		return mongoId;
	}


	public void setMongoId(String mongoId) {
		this.mongoId = mongoId;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public ArtistType getType() {
		return type;
	}


	public void setType(ArtistType type) {
		this.type = type;
	}


	public String getBio() {
		return bio;
	}


	public void setBio(String bio) {
		this.bio = bio;
	}


	public String getCountry() {
		return country;
	}


	public void setCountry(String country) {
		this.country = country;
	}


	public Set<String> getGenre() {
		return genre;
	}


	public void setGenre(Set<String> genre) {
		this.genre = genre;
	}


	public Artist() {
		super();
	}


	public String getImageURL() {
		return imageURL;
	}


	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}
	
}
