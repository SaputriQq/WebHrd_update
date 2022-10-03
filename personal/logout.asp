<!-- #include file="../connection_personal.asp"-->
<% 
Session.Abandon 
Response.Redirect("../login.asp")
%>