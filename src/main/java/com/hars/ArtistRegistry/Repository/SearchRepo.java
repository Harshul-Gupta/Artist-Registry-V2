package com.hars.ArtistRegistry.Repository;

import java.util.List;



public interface SearchRepo{
	record ArtistSlice(List<Artist> content, boolean hasPrevious, boolean hasNext) {}
	
	ArtistSlice findByNameAndGenre(String name, String genre, int page);  
}
