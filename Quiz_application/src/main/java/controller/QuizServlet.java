package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.QuestionDao;
import model.Question;

/**
 * Servlet implementation class QuizServlet
 */
@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QuizServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		  HttpSession session = req.getSession();
		QuestionDao questionDao = new QuestionDao();
        List<Question> questions = questionDao.getAllQuestions();
        session.setAttribute("questions", questions);
        session.setAttribute("currentIndex", 0);
        session.setAttribute("score", 0);

        displayQuestion(resp, questions.get(0), 1);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		  HttpSession session = req.getSession();

		    if (session == null || session.getAttribute("questions") == null ||
		        session.getAttribute("currentIndex") == null || session.getAttribute("score") == null) {
		        
		        resp.sendRedirect("QuizServlet");
		        return;
		    }

		    List<Question> questions = (List<Question>) session.getAttribute("questions");
		    int currentIndex = (Integer) session.getAttribute("currentIndex");
		    int score = (Integer) session.getAttribute("score");

		    String selected = req.getParameter("answer");
		    Question currentQuestion = questions.get(currentIndex);

		    if (selected != null && selected.equalsIgnoreCase(currentQuestion.getCorrect())) {
		        score++;
		    }

		    currentIndex++;

		    if (currentIndex < questions.size()) {
		        session.setAttribute("currentIndex", currentIndex);
		        session.setAttribute("score", score);
		        displayQuestion(resp, questions.get(currentIndex), currentIndex + 1);
		    } else {
		        session.setAttribute("finalScore", score);
		        session.setAttribute("totalQuestions", questions.size());
		        session.removeAttribute("questions");
		        session.removeAttribute("currentIndex");
		        resp.sendRedirect("ResultServlet");
		    }
	}
	
	private void displayQuestion(HttpServletResponse resp, Question q, int qNum) throws IOException {
	    resp.setContentType("text/html");
	    PrintWriter out = resp.getWriter();

	    out.println("<!DOCTYPE html>");
	    out.println("<html lang='en'>");
	    out.println("<head>");
	    out.println("<meta charset='UTF-8'>");
	    out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
	    out.println("<title>Quiz Question</title>");
	    out.println("<style>");
	    out.println("    body {");
	    out.println("        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;");
	    out.println("        background: linear-gradient(120deg, #e0f7fa, #ffffff);");
	    out.println("        display: flex;");
	    out.println("        justify-content: center;");
	    out.println("        align-items: center;");
	    out.println("        height: 100vh;");
	    out.println("        margin: 0;");
	    out.println("    }");
	    out.println("    .quiz-box {");
	    out.println("        background: #fff;");
	    out.println("        padding: 30px 40px;");
	    out.println("        border-radius: 12px;");
	    out.println("        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);");
	    out.println("        width: 100%;");
	    out.println("        max-width: 600px;");
	    out.println("    }");
	    out.println("    h3 {");
	    out.println("        color: #333;");
	    out.println("        margin-bottom: 20px;");
	    out.println("    }");
	    out.println("    label {");
	    out.println("        display: block;");
	    out.println("        margin: 10px 0;");
	    out.println("        font-size: 16px;");
	    out.println("        cursor: pointer;");
	    out.println("    }");
	    out.println("    input[type='submit'] {");
	    out.println("        margin-top: 20px;");
	    out.println("        background-color: #039be5;");
	    out.println("        color: #fff;");
	    out.println("        border: none;");
	    out.println("        padding: 10px 20px;");
	    out.println("        font-size: 16px;");
	    out.println("        border-radius: 6px;");
	    out.println("        cursor: pointer;");
	    out.println("    }");
	    out.println("    input[type='submit']:hover {");
	    out.println("        background-color: #0288d1;");
	    out.println("    }");
	    out.println("</style>");
	    out.println("</head>");
	    out.println("<body>");
	    out.println("<div class='quiz-box'>");
	    out.printf("<h3>Question %d: %s</h3>", qNum, q.getQuestionTitle());
	    out.println("<form method='post' action='QuizServlet'>");

	    out.printf("<label><input type='radio' name='answer' value='A' required> %s</label>", q.getOptionA());
	    out.printf("<label><input type='radio' name='answer' value='B'> %s</label>", q.getOptionB());
	    out.printf("<label><input type='radio' name='answer' value='C'> %s</label>", q.getOptionC());
	    out.printf("<label><input type='radio' name='answer' value='D'> %s</label>", q.getOptionD());

	    out.println("<input type='submit' value='Next'>");
	    out.println("</form>");
	    out.println("</div>");
	    out.println("</body>");
	    out.println("</html>");
	}


}
