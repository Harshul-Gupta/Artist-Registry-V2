package com.hars.ArtistRegistry.Service;

import com.hars.ArtistRegistry.Repository.UserPrincipal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hars.ArtistRegistry.Repository.User;
import com.hars.ArtistRegistry.Repository.UserRepo;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	UserRepo repo;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		User user = repo.findByUsername(username);
		if(user== null)
			throw new UsernameNotFoundException("Inavlid username! Please Try again");
		
		return new UserPrincipal(user);
	}

}
