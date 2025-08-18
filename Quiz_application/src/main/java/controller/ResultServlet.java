package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Result;
import model.User;
import service.ResultService;


@WebServlet("/ResultServlet")
public class ResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ResultServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        if (session == null || session.getAttribute("finalScore") == null) {
            out.println("<h2>No result available. Please take the quiz first.</h2>");
            out.println("<a href='login.html'>Login</a>");
            return;
        }

        int score = (int) session.getAttribute("finalScore");
        int total = (int) session.getAttribute("totalQuestions");
        String username = (String) session.getAttribute("username");

        Result result = new Result(username, score, total);
        ResultService resultService = new ResultService();
        resultService.saveQuizResult(result);

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Quiz Result</title>");
        out.println("<style>");
        out.println("body { font-family: 'Segoe UI', sans-serif; background: #f0f4f8; margin: 0; padding: 0; display: flex; justify-content: center; align-items: center; height: 100vh; }");
        out.println(".result-container { background: #ffffff; padding: 40px; border-radius: 10px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); text-align: center; width: 400px; }");
        out.println("h2 { color: #333; margin-bottom: 20px; }");
        out.println("p { font-size: 18px; color: #444; margin-bottom: 30px; }");
        out.println("a { text-decoration: none; background-color: #007bff; color: white; padding: 10px 20px; border-radius: 5px; transition: background 0.3s; }");
        out.println("a:hover { background-color: #0056b3; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='result-container'>");
        out.println("<h2>Quiz Completed!</h2>");
        out.println("<p><strong>Your Score:</strong> " + score + " out of " + total + "</p>");
        out.println("<a href='login.html'>Logout</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");

        session.invalidate();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
