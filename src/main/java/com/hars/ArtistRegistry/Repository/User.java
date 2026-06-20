package com.hars.ArtistRegistry.Repository;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import jakarta.validation.constraints.NotBlank;

@Document(collection = "User")
public class User {

	@Id
	String mogoId;
	
	@NotBlank(message = "Username can't be empty")
	String username;
	
	@NotBlank(message = "Username can't be empty")
	String password;
	
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
}
