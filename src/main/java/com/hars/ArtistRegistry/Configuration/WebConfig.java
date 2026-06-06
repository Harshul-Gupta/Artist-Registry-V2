package com.hars.ArtistRegistry.Configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer{
	@Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // Maps the clean web URL "/artist-details" directly to your "Artist.jsp" file
        registry.addViewController("/artist-details").setViewName("Artist");
    }
}
