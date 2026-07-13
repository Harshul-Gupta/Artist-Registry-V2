package com.hars.ArtistRegistry.Repository;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document(collation = "Songs")
public class Song {
	@Id
	private String mongoID;
	
	@Field("artist_id")
	private String artistId;
	
	private String title;
	private String album;
	
	@Field("duration_seconds")
	    private int durationSeconds;
	 
	@Field("release_year") // Maps directly to release_year in MongoDB
	    private int releaseYear;
	    
	@Field("stream_count")
	    private long streamCount;
	    
	@Field("cover_art_url")
	    private String coverURL;

		public String getMongoID() {
			return mongoID;
		}

		public void setMongoID(String mongoID) {
			this.mongoID = mongoID;
		}

		public String getArtistId() {
			return artistId;
		}

		public void setArtistId(String artistId) {
			this.artistId = artistId;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public String getAlbum() {
			return album;
		}

		public void setAlbum(String album) {
			this.album = album;
		}

		public int getDurationSeconds() {
			return durationSeconds;
		}

		public void setDurationSeconds(int durationSeconds) {
			this.durationSeconds = durationSeconds;
		}

		public int getReleaseYear() {
			return releaseYear;
		}

		public void setReleaseYear(int releaseYear) {
			this.releaseYear = releaseYear;
		}

		public long getStreamCount() {
			return streamCount;
		}

		public void setStreamCount(long streamCount) {
			this.streamCount = streamCount;
		}

		public String getCoverURL() {
			return coverURL;
		}

		public void setCoverURL(String coverURL) {
			this.coverURL = coverURL;
		}
}
