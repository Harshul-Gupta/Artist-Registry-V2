package com.hars.ArtistRegistry.Configuration;

import java.net.http.HttpRequest;
import java.text.Normalizer.Form;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.csrf.CsrfAuthenticationStrategy;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig{
	
	@Autowired
	private UserDetailsService userDetailsService;
	
	@Bean
	public AuthenticationProvider authProvider()
	{
		DaoAuthenticationProvider provider= new DaoAuthenticationProvider(userDetailsService);
		provider.setPasswordEncoder(new BCryptPasswordEncoder());
		return provider;
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		
		http	
			.csrf(csrf -> csrf.disable())
			.authorizeHttpRequests(auth -> auth
					.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
					.requestMatchers("/login", "/login?error=true", "/login?logout=true").permitAll()
					.anyRequest().authenticated()
					)
			.formLogin(form-> form.loginPage("/login")
					.defaultSuccessUrl("/", true)
					.permitAll()
					)
			.logout(logout -> logout.logoutUrl("/logout")
					.logoutSuccessUrl("/login?logout=true")
					.invalidateHttpSession(true)     
		            .clearAuthentication(true)        
		            .deleteCookies("JSESSIONID")       
		            .permitAll()
					)
			.httpBasic(Customizer.withDefaults());
		
		return http.build();
	}
	
//	@Bean
//	public UserDetailsService userDetailsService() { 
//		UserDetails user= User.builder()
//				.username("Lemon")
//				.password(passwordEncoder().encode("Password"))
//				.roles("user")
//				.build();
//		return new InMemoryUserDetailsManager(user);
//	}
//	
//	@Bean
//	public PasswordEncoder passwordEncoder()
//	{
//		return new BCryptPasswordEncoder();
//	}
}
