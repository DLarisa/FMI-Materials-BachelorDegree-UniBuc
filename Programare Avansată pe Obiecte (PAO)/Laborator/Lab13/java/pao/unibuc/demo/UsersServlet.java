package pao.unibuc.demo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

@WebServlet("/users")
public class UsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDB userDB = UserDB.getInstance();
        Collection<User> users = userDB.getAllUsers();
        req.setAttribute("model", users);
        req.getRequestDispatcher("users.jsp").forward(req, resp);
    }
}
