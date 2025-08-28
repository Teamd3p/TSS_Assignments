package com.tss.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tss.model.User;
import com.tss.util.Constants;

@WebFilter(filterName = "AuthFilter", urlPatterns = { "/admin/*", "/customer/*", "/loan/*", "/complaint/*" })
public class AuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		HttpSession session = req.getSession(false); // Don't create
		User user = null;

		if (session != null) {
			user = (User) session.getAttribute(Constants.SESSION_USER);
		}

		if (user == null) {
			// Create session only if needed
			HttpSession newSession = req.getSession(true);
			newSession.setAttribute(Constants.ATTR_ERRORS, "Please log in to continue.");
			resp.sendRedirect(req.getContextPath() + "/login.jsp");
			return;
		}

		chain.doFilter(request, response);
	}
}