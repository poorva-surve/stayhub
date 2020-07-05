<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite2.master" Theme="Theme"
    AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="_Default" %>

<asp:Content ID="adminContent" ContentPlaceHolderID="ContentPage" runat="Server">

<br /><br />
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
    <div id="adminIntro" align="center" style="margin: auto; width: 50%">
        <asp:Label ID="lblUser" runat="server" Font-Size="30px"></asp:Label>
        <p style="font-size: 20px" align="center">
            <br />
            You can use the admin panel to retrieve and update information about the members,
            cities, and PGs.
            <br />
            <br />
            Approve pending PG requests with a single click!
            <br />
            <br />
            Easily delete expired PG posts or user accounts.
            <br />
            You can also view the feedback messages posted by users.
        </p>
    </div>
    <br />
    <br />
    <br />
    </div>
</asp:Content>
