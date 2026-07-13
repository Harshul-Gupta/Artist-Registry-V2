package com.hars.ArtistRegistry.Repository;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@Document(collection = "User")
public class User {

	@Id
	private String mogoId;
	
	@NotBlank(message = "Username can't be empty")
	private String username;
	
	@NotBlank(message = "Username can't be empty")
	private String password;
	
	@Email
	private String email;
	
	private String provider;
	
	public String getMogoId() {
		return mogoId;
	}

	public void setMogoId(String mogoId) {
		this.mogoId = mogoId;
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
