<%@ page import="java.sql.*" %>
<%@ page import="BankServelets.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check Balance</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        height: 100vh;
        background:url("https://www.bhmpics.com/downloads/bank-backgrounds-/13.online-banking-banner-website-internet-mobile-phone-blue-background-electronic-bank-payment-copy-space-digital-204929150.jpg");
    }
    .sidebar {
        height: 100%;
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        background-color: #343a40;
        padding-top: 20px;
    }
    .sidebar a {
        padding: 15px;
        text-decoration: none;
        font-size: 18px;
        color: white;
        display: block;
        transition: 0.3s;
    }
    .sidebar a:hover {
        background-color: #575d63;
    }
    .container {
        background-color: white;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
        width: 700px;
    }
    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #007BFF;
    }
    .form-group {
        margin-bottom: 20px;
        text-align: center; /* Center the button */
    }
    .form-group input {
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .form-group button {
        padding: 10px 15px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .form-group button:hover {
        background-color: #0056b3;
    }
    table {
        margin-top: 20px;
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
        color: #333;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
</style>
</head>
<body>
<div class="sidebar">
    <h2 class="text-center text-light">APANA BANK</h2>
    <a href="AccountDeposite.html"><i class="fas fa-coins"></i> Deposite Amount</a>
    <a href="AmountWithdraw.html"><i class="fas fa-money-bill-wave"></i> Withdraw Amount</a>
    <a href="CheckBalance.jsp"><i class="fas fa-balance-scale"></i> Check Balance</a>
    <a href="viewUser.jsp"><i class="fas fa-user"></i> View User</a>
    <a href="DeleteAccount.html"><i class="fas fa-user-minus"></i> Delete Account</a>
    <a href="index.html"><i class="fas fa-sign-in-alt"></i> Log in</a>
</div>

<div class="container">
    <form action="CheckBalance.jsp" method="get">
        <h2>Check Balance</h2>
        <div class="form-group">
            <input type="text" name="ano" placeholder="Enter account number" required>
        </div>
        <div class="form-group">
            <button type="submit">Check Balance</button>
        </div>
    </form>

    <table>
        <%
        try {
            String ano = request.getParameter("ano");
            if (ano != null && !ano.isEmpty()) {
        %>
        <tr>
            <th>Account Number</th>
            <th>Name</th>
            <th>Mobile</th>
            <th>City</th>
            <th>Balance</th>
        </tr>
        <%
                Connection con = ConnectDB.dbCon();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE ano = ?");
                ps.setInt(1, Integer.parseInt(ano));
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("ano") %></td>
            <td><%= rs.getString("aname") %></td>
            <td><%= rs.getString("amob") %></td>
            <td><%= rs.getString("acity") %></td>
            <td><%= rs.getDouble("abal") %></td>
        </tr>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </table>
</div>
</body>
</html>
