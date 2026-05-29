package com.hars.ArtistRegistry.Controller;

import org.springframework.boot.webmvc.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController{
	
	@RequestMapping("/error")
	public String handleError(HttpServletRequest request , Model model)
	{
		
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        int statusCode   = Integer.parseInt(status.toString());

        Throwable throwable = (Throwable) request.getAttribute(RequestDispatcher.ERROR_EXCEPTION);

        String errorMessage = buildErrorMessage(statusCode, throwable,
                (String) request.getAttribute(RequestDispatcher.ERROR_MESSAGE));

        model.addAttribute("errorMessage", errorMessage);
        model.addAttribute("statusCode",   statusCode);

        return "errors";
    }

    private String buildErrorMessage(int statusCode, Throwable throwable, String servletMessage) {

        if (throwable != null) {
            String msg = throwable.getMessage();
            if (msg != null && !msg.isBlank()) {
                return msg;
            }
        }

        if (servletMessage != null && !servletMessage.isBlank()) {
            return servletMessage;
        }

        HttpStatus status = HttpStatus.resolve(statusCode);
        if (status != null) {
            return switch (status) {
                case NOT_FOUND            -> "The page or resource you requested could not be found.";
                case FORBIDDEN            -> "You do not have permission to access this resource.";
                case UNAUTHORIZED         -> "Authentication is required to access this resource.";
                case METHOD_NOT_ALLOWED   -> "The HTTP method used is not supported for this endpoint.";
                case BAD_REQUEST          -> "The request could not be understood due to malformed syntax.";
                case INTERNAL_SERVER_ERROR-> "An unexpected server error occurred. Please try again later.";
                case SERVICE_UNAVAILABLE  -> "The service is temporarily unavailable. Please try again later.";
                default                   -> "An error occurred (HTTP " + statusCode + ").";
            };
        }

        return "An unexpected error occurred. Please return home or try again.";
    }
}

