package com.hars.ArtistRegistry.Repository;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@Document(collection = "User")
public class User {

	@Id
	private String mongoId;
	
	@NotBlank(message = "Username can't be empty")
	private String username;
	
	@NotBlank(message = "Password can't be empty")
	private String password;
	
	@NotBlank(message = "Name can't be empty")
	private String name;
	
	@Email
	private String email;
	
	private String provider;
	
	public String getMogoId() {
		return mongoId;
	}

	public void setMogoId(String mogoId) {
		this.mongoId = mogoId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}
}
