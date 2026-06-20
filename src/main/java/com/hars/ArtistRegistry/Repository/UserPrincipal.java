package com.hars.ArtistRegistry.Repository;

import java.util.Collection;
import java.util.Collections;
import java.util.stream.*;

import org.jspecify.annotations.Nullable;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class UserPrincipal implements UserDetails {

	private final User user;
	
	public UserPrincipal(User user) {
		super();
		this.user = user;
	}
	
	public String getInitials() {
		return ""+ user.getUsername().charAt(0);
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return Collections.singleton(new SimpleGrantedAuthority("USER"));
	}

	@Override
	public @Nullable String getPassword() {
		return user.getPassword();
	}

	@Override
	public String getUsername() {
		return user.getUsername();
	}

}
