package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;
import service.UserService;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");

		try {
		    UserService userService = new UserService();
		    User user = userService.login(username, password);

		    if (user != null && user.getUsername() != null) {
		        HttpSession session = req.getSession();
		        session.setAttribute("username", user.getUsername());
		        resp.sendRedirect("QuizServlet");
		    } else {
		        resp.sendRedirect("login.html?error=invalid");
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		    resp.sendRedirect("login.html?error=exception");
		}


	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
