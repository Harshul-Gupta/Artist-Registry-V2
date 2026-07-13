package com.hars.ArtistRegistry.Configuration;

import java.lang.module.ModuleDescriptor.Builder;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.regions.providers.DefaultAwsRegionProviderChain;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3ClientBuilder;

@Configuration
public class S3Config {
	
	@Value("${aws.region}")
	private String region;
	
	@Bean
	public S3Client s3Client() {
		
		return S3Client.builder()
				.region(Region.of(region))
				.credentialsProvider(DefaultCredentialsProvider.builder().build())
				.build();
	}
}
