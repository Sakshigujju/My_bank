package BankServelets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AmountWithdraw")
public class AmountWithdraw extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AmountWithdraw() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ano = request.getParameter("ano");
        double amount = Double.parseDouble(request.getParameter("amount"));

        try (Connection con = ConnectDB.dbCon()) {
            // Retrieve current account balance
            try (PreparedStatement ps1 = con.prepareStatement("SELECT abal FROM users WHERE ano = ?")) {
                ps1.setInt(1, Integer.parseInt(ano));
                try (ResultSet rs1 = ps1.executeQuery()) {
                    if (rs1.next()) {
                        double abal = rs1.getDouble("abal");

                        if (amount > 0 && amount <= abal) {
                            abal -= amount;

                            // Update account balance
                            try (PreparedStatement ps2 = con.prepareStatement("UPDATE users SET abal = ? WHERE ano = ?")) {
                                ps2.setDouble(1, abal);
                                ps2.setInt(2, Integer.parseInt(ano));
                                int i = ps2.executeUpdate();
                                if (i > 0) {
                                    response.sendRedirect("Welcome.html");
                                } else {
                                    response.sendRedirect("error.html"); // Error in updating balance
                                }
                            }
                        } else {
                            response.sendRedirect("error.html"); // If amount is invalid or greater than balance
                        }
                    } else {
                        response.sendRedirect("error.html"); // If account number does not exist
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.html"); // Redirect to error page in case of exception
        }
    }
}
