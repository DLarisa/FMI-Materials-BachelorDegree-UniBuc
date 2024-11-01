package pao.unibuc.demo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/registerUser")
public class RegisterUserServlet extends HttpServlet {
    public RegisterUserServlet(){
        System.out.println("Servlet constructor was called.");
    }

    @Override
    public void init() throws ServletException {
        System.out.println("Servlet init method was called");
    }

    @Override
    public void destroy() {
        System.out.println("Servlet destroy method was called");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doGet method was called");
        createUserAndStoreRespond(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doPost method was called");
        createUserAndStoreRespond(req, resp);
    }
    private void createUserAndStoreRespond(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        UserDB.getInstance().addUser(name, email,
                UserDB.getInstance().getAllUsers().stream().map(user -> user.getName()).toArray(String[]::new));
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(true);
        session.setAttribute("name", name);
        session.setAttribute("email", email);
        out.write("<html><body><h2>Name and email were stored.</h2></body></html>");

    }
}
