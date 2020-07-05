<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="Login.aspx.cs" Inherits="_Default" %>

<%@ MasterType VirtualPath="~/Site2.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="Server">

    <div id="loginForm" align="center">
        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnLogin">
        <br /><br />
            
            <p style="font-size: 2em">
                Login to your account
            </p>
            <hr width="10%" style=" background-color: #f66400; color: #f66400;" size="2" />
            <br />
            <br />
            <br />
            <p>
                E-mail ID: &nbsp;
                <asp:TextBox ID="txtUser" runat="server" autocomplete="on"></asp:TextBox>
                <br />
                <br />
                Password: &nbsp;
                <asp:TextBox ID="txtUserPass" runat="server" TextMode="Password"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Style="text-align: center"
                    Text="Login" UseSubmitBehavior="True" />
                <br />
                <br />
                <asp:Label ID="lblStatus" runat="server"></asp:Label>
                <br />
                <br />
                Not an existing user?
                <br />
                <asp:HyperLink ID="linkRegister" runat="server" NavigateUrl="~/Register.aspx">Create an account</asp:HyperLink>
            </p>
        </asp:Panel>
    </div>
    <br />
    <br />
</asp:Content>
