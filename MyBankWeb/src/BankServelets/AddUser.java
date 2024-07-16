package BankServelets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class AddUser
 */
@WebServlet("/AddUser")
public class AddUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try{
			doGet(request, response);
		int ano=0;
		String aname=request.getParameter("aname");
		String amob=request.getParameter("amob");
		String acity = request.getParameter("acity");
		Double abal = Double.parseDouble(request.getParameter("abal"));
		
		 Connection con = ConnectDB.dbCon();
	        
	        PreparedStatement ps = con.prepareStatement("insert into users values(?,?,?,?,?)");
	        ps.setInt(1,ano);
			   ps.setString(2,aname);
			   ps.setString(3,amob);
			   ps.setString(4,acity);
			   ps.setDouble(5,abal);
			   int i=ps.executeUpdate();
			   if(i>0)
			   {
				  response.sendRedirect("Welcome.html");
			   }
			   else{
				   response.sendRedirect("error.html");;
			   }
		   }
		   catch(Exception e)
		   {
			   e.printStackTrace();
		   }
		   
	    }

}