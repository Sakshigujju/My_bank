<%@ page import="java.sql.*" %>
<%@ page import="BankServelets.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View User</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 0;
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
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-top: 50px;
    }
    form {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 300px;
    }
    input[type="text"] {
        width: calc(100% - 22px); /* Adjust for padding */
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        margin: 10px 0;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    input[type="submit"]:hover {
        background-color: #45a049;
    }
    table {
        margin-top: 20px;
        width: 80%;
        border-collapse: collapse;
    }
    th, td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: center;
    }
    th {
        background-color: #4CAF50;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
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
    <form action="viewUser.jsp" method="Post">
        <input type="text" name="ano" placeholder="Enter Account Number" required>
        <input type="submit" value="View User">
    </form>
    <table>
    <%
        try {
            String ano = request.getParameter("ano");
            if (ano != null) {
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
                PreparedStatement ps = con.prepareStatement("select * from users where ano= ?");
                ps.setInt(1, Integer.parseInt(ano));
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt(1) %></td>
        <td><%= rs.getString(2) %></td>
        <td><%= rs.getString(3) %></td>
        <td><%= rs.getString(4) %></td>
        <td><%= rs.getString(5) %></td>
    </tr>
    <%
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    </table>
</div>
</body>
</html>
