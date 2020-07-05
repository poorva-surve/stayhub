<%@ Page Title="" Language="C#" MasterPageFile="~/OwnerSite2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="OwnerProfile.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="profileContent" ContentPlaceHolderID="ContentPage" runat="Server">
    <style>
        @media screen and (min-width: 601px)
        {
            #viewProfile
            {
                width: 50%;
            }
            #viewProfile .fieldLabels
            {
                width: 40%;
                font-size: 1.2em;
            }
            .lblName
            {
                font-size: 1.5em;
            }
        }
        @media screen and (max-width: 600px)
        {
            #viewProfile
            {
                width: 80%;
            }
            #viewProfile .fieldLabels
            {
                width: 35%;
                font-size: 1em;
            }
            .lblName
            {
                font-size: 1.2em;
            }
        }
        .validator
        {
            color: Red;
        }
    </style>
    <br />
    <br />
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div id="viewProfile" style="margin: auto;">
            <center>
                <asp:Label ID="lblEmpty" runat="server" Font-Size="1.5em" Visible="False"></asp:Label>
                <br />
                <br />
            </center>
            <p align="right" style="margin: auto; width: 100%">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" SkinID="yellow" OnClick="btnCancel_Click"
                    Visible="False" UseSubmitBehavior="False" />
                &nbsp;&nbsp;
                <asp:Button ID="btnUpdate" runat="server" Text="Edit Profile" SkinID="green" OnClick="btnUpdate_Click"
                    UseSubmitBehavior="False" />
                <asp:Button ID="btnSave" runat="server" Text="Save Changes" SkinID="green" OnClick="btnSave_Click"
                    UseSubmitBehavior="False" Visible="False" ValidationGroup = "save" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete Account" SkinID="del" OnClick="btnDelete_Click" />
                <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnDelete"
                    ConfirmText="All details of your account including PGs and scheduled visits will be permanently deleted. Do you want to continue?" />
            
            </p>
            <br />
            <div class="rounded-lg shadow">
                <asp:DataList ID="DataListProfile" runat="server" Width="100%" Style="font-family: Arial, Helvetica, sans-serif;
                    font-size: 1em" DataSourceID="SqlDataSourceUsers" OnPreRender="DataListProfile_PreRender">
                    <ItemTemplate>
                        <table style="padding: 0; margin: auto; border: 2px solid #FFCC66" cellpadding="20"
                            bgcolor="#FEFFF2" width="100%">
                            <tr>
                                <td colspan="3" bgcolor="#FFCC66" style="padding: 1em; color: #800000;">
                                    <asp:Label ID="lblName" runat="server" CssClass="lblName" Text='<%# Eval("Name") %>'
                                        Style="font-weight: 700; display: run-in;"></asp:Label>
                                    <asp:TextBox ID="txtName" runat="server" placeholder="Enter your name" Text='<%# Eval("Name") %>'
                                        Style="font-weight: 700;" Visible="False" SkinID="adm" />
                                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator2" runat="server"
                                        Text="*" ErrorMessage="Name is required" SetFocusOnError ControlToValidate="txtName"
                                        ValidationGroup="save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator CssClass="validator" ID="RegularExpressionValidator1"
                                        runat="server" ControlToValidate="txtName" Text="*" ErrorMessage="Name is not valid"
                                        ValidationExpression="([A-Za-z]*[\sA-Za-z]*.)" ValidationGroup="save"></asp:RegularExpressionValidator>
                                    &nbsp; <span style="float: right">
                                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>' Visible="True"></asp:Label><br />
                                    </span>
                                    <br />
                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                    <asp:TextBox ID="txtCity" runat="server" placeholder="Enter your city" Text='<%# Eval("City") %>'
                                        Style="font-weight: 700;" Visible="False" SkinID="adm" />
                                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator6" runat="server"
                                        SetFocusOnError Text="*" ErrorMessage="City is required" ControlToValidate="txtCity"
                                        ValidationGroup="save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator CssClass="validator" ID="RegularExpressionValidator2"
                                        runat="server" ControlToValidate="txtCity" ErrorMessage="City name is not valid"
                                        Text="*" ValidationExpression="([A-Za-z]*)" ValidationGroup="save"></asp:RegularExpressionValidator>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="fieldLabels">
                                    Account Type
                                </td>
                                <td>
                                    <asp:Label ID="lblRole" runat="server" Text='<%# Eval("Role") %>'>
                                    </asp:Label>
                                    <asp:DropDownList ID="ddlRole" runat="server" Visible="False" Height="2.5em" Width="100%">
                                        <asp:ListItem Text="PG Seeker" Value="Seeker"></asp:ListItem>
                                        <asp:ListItem Text="PG Owner" Value="Owner"></asp:ListItem>
                                    </asp:DropDownList>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="fieldLabels">
                                    Date of Birth
                                </td>
                                <td>
                                    <asp:Label ID="lblDOB" runat="server" Text='<%# Eval("DOB") %>'>
                                    </asp:Label>
                                    <asp:TextBox ID="txtDOB" runat="server" placeholder="dd-mm-yyyy" autocomplete="off"
                                        Text='<%# Eval("DOB") %>' Visible="False" SkinID="normal"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDOB"
                                        EndDate="12/31/2001" StartDate="1/1/1940" Format="dd-MM-yyyy" />
                                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator5" runat="server"
                                        SetFocusOnError Text="*" ErrorMessage="DOB is required" ControlToValidate="txtDOB"
                                        ValidationGroup="save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator CssClass="validator" ID="RegularExpressionValidator4"
                                        runat="server" SetFocusOnError Text="*" ControlToValidate="txtDOB" ErrorMessage="DOB is not valid"
                                        ValidationExpression="(\d{2}-\d{2}-\d{4})" ValidationGroup="save"></asp:RegularExpressionValidator>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="fieldLabels">
                                    Gender
                                </td>
                                <td>
                                    <asp:Label ID="lblGender" runat="server" Text='<%# Eval("Gender") %>'>
                                    </asp:Label>
                                    <asp:DropDownList ID="ddlGender" runat="server" Visible="False" Height="2.5em" Width="100%">
                                        <asp:ListItem Value="M" Text="Male"></asp:ListItem>
                                        <asp:ListItem Value="F" Text="Female"></asp:ListItem>
                                    </asp:DropDownList>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="fieldLabels">
                                    Contact No.
                                </td>
                                <td>
                                    <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("Mobile") %>'>
                                    </asp:Label>
                                    <asp:TextBox ID="txtMobile" runat="server" Font-Size="1em" Text='<%# Eval("Mobile") %>'
                                        Visible="False" SkinID="normal" />
                                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator7" runat="server"
                                        SetFocusOnError Text="*" ErrorMessage="Mobile Number is required" ControlToValidate="txtMobile"
                                        ValidationGroup="save"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator CssClass="validator" ID="RegularExpressionValidator3"
                                        runat="server" ControlToValidate="txtMobile" Text="*" ErrorMessage="Mobile Number is not valid"
                                        ValidationExpression="\d{10}" ValidationGroup="save"></asp:RegularExpressionValidator>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="fieldLabels">
                                    E-Mail
                                </td>
                                <td>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'>
                                    </asp:Label>
                                    <asp:TextBox ID="txtEmail" runat="server" Font-Size="1em" Text='<%# Eval("Email") %>'
                                        Visible="False" SkinID="normal" Enabled="False" />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="fieldLabels">
                                    Password
                                </td>
                                <td>
                                    <asp:Label ID="lblPass" runat="server" Text='<%# Eval("Password") %>'>
                                    </asp:Label>
                                    <asp:TextBox ID="txtPass" runat="server" Font-Size="1em" Text='<%# Eval("Password") %>'
                                        Visible="False" SkinID="normal" TextMode="Password" />
                                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator9" runat="server"
                                        SetFocusOnError Text="*" ErrorMessage="Password is required" ControlToValidate="txtPass"
                                        ValidationGroup="save"></asp:RequiredFieldValidator>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="fieldLabels">
                                    <asp:Label ID="lblConPass" runat="server" Text="Confirm New Password  " Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtConPass" runat="server" Font-Size="2em" Visible="False" SkinID="normal"
                                        TextMode="Password" />
                                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator10" runat="server"
                                        SetFocusOnError Text="*" ErrorMessage="You need to confirm password" ControlToValidate="txtConPass"
                                        ValidationGroup="save"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator CssClass="validator" ID="CompareValidator1" runat="server"
                                        SetFocusOnError Text="*" ErrorMessage="Passwords do not match" ControlToCompare="txtPass"
                                        ControlToValidate="txtConPass" ValidationGroup="save"></asp:CompareValidator>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <asp:SqlDataSource ID="SqlDataSourceUsers" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
                SelectCommand="SELECT * FROM [Users] WHERE ([ID] = @ID)">
                <SelectParameters>
                    <asp:SessionParameter Name="ID" SessionField="ownerid" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList"
                ForeColor="Red" HeaderText=" Oops! We've found some problems... " BackColor="WhiteSmoke"
                Font-Italic="True" ValidationGroup="save" />
            <br />
        </div>
</asp:Content>
