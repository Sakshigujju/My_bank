package BankServelets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class AccountDeposite
 */
@WebServlet("/AccountDeposite")
public class AccountDeposite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountDeposite() {
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
			
			String ano = request.getParameter("ano");
			Double amount = Double.parseDouble(request.getParameter("amount"));
			Double abal = User.getAbal();
			 Connection con = ConnectDB.dbCon();
		        if(amount>0){
		        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE ano=?");
		       
		        ps.setInt(1, Integer.parseInt(ano));
	            ResultSet rs = ps.executeQuery();
				if(rs.next()){
					
				abal=User.getAbal();
				abal=rs.getDouble("abal");
				abal = abal+amount;
				PreparedStatement ps1 = con.prepareStatement("UPDATE users SET abal=? WHERE ano=?");
				ps1.setDouble(1, abal);
				ps1.setInt(2, Integer.parseInt(ano));
				int i=ps1.executeUpdate();
				
				   if (i>0) 
				   {
					   response.sendRedirect("Welcome.html");
				   }
				   else{
					   response.sendRedirect("error.html");
				   }
				   }
				else{
					System.out.println("invalid account number");
				    }
				}
		        }
			catch(Exception e){
				e.printStackTrace();
			}
	}
}


