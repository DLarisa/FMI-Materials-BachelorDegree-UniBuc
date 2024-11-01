package pao.unibuc.demo;

import jdk.javadoc.internal.doclets.toolkit.taglets.SeeTaglet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/showUser")
public class ShowUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String nameParam = req.getParameter("name");
       if(nameParam == null){
           throw new ServletException("Missing parameter name");
       }
       User user = UserDB.getInstance().getUser(nameParam);
       if(user == null){
           resp.setStatus(404);
           req.getRequestDispatcher("userNotFound.jsp").forward(req, resp);
       }
       else {
           req.setAttribute("model", user);
           req.getRequestDispatcher("showUser.jsp").forward(req, resp);
       }
    }
}
