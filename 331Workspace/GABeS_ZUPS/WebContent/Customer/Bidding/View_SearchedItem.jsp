<%@ page language="java" import="java.sql.*"%>
<%@include file="../../Styles/Security.jsp"%>
<%@include file="../../Styles/CustomerStyle.jsp"%>
<jsp:useBean id="Item" class= "jsupton.gabes_ZUPS.GABeS_Item"/> 
<jsp:setProperty name="Item" property="*"/>
<%
	Item.setItemInfo();
	ResultSet rs = Item.getItemInfo();
	ResultSet rs2 = Item.getSimilarItems(account.getUserID());
%> 

<html style="background-color:white"> 
	<head>
		<title>GABeS Customer - Update Profile</title>
	</head>
	<style>
		.button2 {
    		background-color: #eeeeee;
    		border: 2px solid #dddddd;
    		color: #aaaaaa;
    		font-weight:bold;
    		padding: 15px 32px;
    		text-align: center;
    		text-decoration: none;
    		display: inline-block;
    		font-size: 18px;
    		cursor: pointer;
    		width:200px;
    		height:75%;
    		}
		td {
    		padding: 5;
    		width:300px;
    		border: 5px solid white;
		}
		table{
			border-collapse: collapse;
			background-color:#f5f5f5;
		}
	</style>
	<body>
		<div style="background-color:#8AC0D1;width:100%;min-width:1000px;height:190px;border:solid 3px white">
			<div style="background-color:White;width:70%;min-width:650px;height:110px;margin-left:auto;margin-right:auto;box-shadow: 10px 10px 5px #777">
				<h1 style="text-align:center"><img src="../../Images/GABES.png" style="width:200px;height:50px;padding-top:25px"> Item Information</h1>
			</div>
		</div>
		<div style="background-color:#777;min-width:1000px">
			<ul style="width:950px">
  				<li style="line-height:30px"><a class="active" href="../Customer_Welcome.jsp">Home</a></li>
  				<li><a href="../Update_Profile.jsp">Update Profile</a></li>
  				<li><a href="../Selling/Selling_Management.jsp">Selling Management</a></li>
  				<li><a href="Bidding_Management.jsp">Bidding Management</a></li>
  				<li><a href="../Leave_Feedback.jsp">Leave Feedback</a></li>
  				<li><a href="../View_Feedback.jsp">View My Feedback</a></li>
  				<li><a href="../Account_History.jsp">Account History</a></li>
  				<li style="line-height:30px"><a href="../../Logout_action.jsp">Logout</a></li>
			</ul>
		</div>
		<div style="background-color:#eaeaea;width:100%;min-width:1000px;height:auto;border:solid 2px white">
		<br/>
		<br/>
		<div style="font-size:22px;background-color:#8AC0D1;border:solid 2px white;width:175px;height:40px;margin-left:auto;margin-right:auto;text-align: center;">
			<p style="line-height:0px"><b>Item Info</b></p>
		</div>
		<br/>
		<%while(rs.next()){ %>
			<div style="padding:15px;border: solid 2px #000;width:475px;height:auto;margin-left:auto;margin-right:auto;text-align: center;background-color:white;box-shadow: 10px 10px 5px #888888">
				<table>
					<tr>
						<td style="width:80px"><b>Item ID</b></td>
						<td><%=rs.getInt(1)%></td>
					</tr>
					<tr>
						<td style="width:80px"><b>Item Name</b></td>
						<td><%=rs.getString(2)%></td>
					</tr>
					<tr>
						<td style="width:80px"><b>Category</b></td>
						<td><%=rs.getString(3)%></td>
					</tr>
					<tr>
						<td style="width:80px"><b>Start Price</b></td>
						<td><%=rs.getFloat(4)%></td>
					</tr>
					<tr>
						<td style="width:80px"><b>Auction Starts</b></td>
						<td><%=Item.getDate(rs.getTimestamp(5))%></td>
					</tr>
					<tr>
						<td style="width:80px"><b>Auction Ends</b></td>
						<td><%=Item.getDate(rs.getTimestamp(6))%></td>
					</tr>
					<tr>
						<td style="width:80px"><b>Description</b></td> 
						<%String des = rs.getString(7);
							if(des == null){%>
							<td style="text-align:center">-----</td>
						<%}else{ %>
							<td><%=des%></td>
						<%} %>
					</tr> 
					<tr>
					<%if(!(rs.getString(8).equals(account.getUserName()))) {%>
						<form method="post" action="Bid.jsp" name="Login" >
							<td style="padding:15px;width:80px"><input name="edit" value="Bid" type="submit" class="button" style="padding:0px;height:auto;margin-right:auto;margin-left:auto">
							<input name="itemID" type="hidden" value=<%=rs.getInt(1)%>></td>
						</form>
					<%}else{ %>
						<td style="padding:15px;width:80px"><input name="edit" value="Bid" type="submit" class="button2" style="padding:0px;height:auto;margin-right:auto;margin-left:auto" disabled="disabled"></td>
					<%} %>
						<form method="post" action="SearchResults.jsp" name="Login" >							
							<td style="padding:15px"><input type="submit" value="Cancel" class="button" style="padding:0px;height:auto;margin-right:auto;margin-left:auto"></td>
						</form>
					</tr>
				</table>
			</div>
			<%} %>
			<br/>
			<br/>
			<br/>
			<%if(rs2.next()){ %>
				<div style="font-size:22px;background-color:#8AC0D1;border:solid 2px white;width:200px;height:40px;margin-left:auto;margin-right:auto;text-align: center;">
					<p style="line-height:0px"><b>Similar Items</b></p>
				</div>
				<br/>
				<div style="padding:10px;border: solid 2px #000;width:auto;min-width:150px;max-width:1000px;
					display:table;margin-left:auto;margin-right:auto;background-color:white;box-shadow: 10px 10px 5px #888888">
					<table>
						<tr>
						<%do{ %>
							<td style="width:150px;text-align:center;border:2px solid #8AC0D1">
								<form method="post" action="View_SearchedItem.jsp" name="ItemInfo">
									<b><%=rs2.getInt(2)%></b><br/>
									<%=rs2.getString(1)%><br/>
									<%=rs2.getString(3)%><br/>
									<input name="Item-Info" value="Item-Info" type="submit" style="width:auto;height:auto;margin-right:auto;margin-left:auto">
									<input type="hidden" name="itemID" value=<%=rs2.getInt(2)%>>
								</form>
							</td>
						<%}while(rs2.next()); %>
						</tr>
					 </table>
				</div>
			<%} %>
			<br/>
			<div >
				<hr style="height:2px;background-color:#777;color:#777;border:solid 1px white;margin-left:20px;margin-right:20px"/>
				<p style="font-size:12px;margin-left:20px"> <b>Copyright �2017 ZUPS. Powered by Upton, Schmidgall, Pekarek, and Zins </b></p>
				<br/>
				<br/>
			</div>
		</div>
	</body>
</html>