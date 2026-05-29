package com.hars.ArtistRegistry.Aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
@Component
public class LoggingAspect {
	
	private static final Logger logger= LoggerFactory.getLogger(LoggingAspect.class);
	
	@Before("execution(public * com.hars.ArtistRegistry.Controller.HomeController.getArtist(String)) && args(id)")
	public void logArtist(String id)
	{
		logger.info("getArtist() method called for Artist ID: {}",id);
	}
	
	@After("execution(public * com.hars.ArtistRegistry.Controller.ArtistController.indexPage(..))")
	public void logHome()
	{
		logger.info("Homepage called.. ");
	}
	
	@Around("execution(public String com.hars.ArtistRegistry.Controller.ArtistController.search(..))")
	public Object logSearch(ProceedingJoinPoint joinPoint) throws Throwable
	{
		long startTime= System.currentTimeMillis();
		Object result = joinPoint.proceed();
		logger.info("[Search Metrics] Search method took {} ms", (System.currentTimeMillis()-startTime));
		return result;
	}
}
