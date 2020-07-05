<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="Feedback.aspx.cs" Inherits="_Default" %>

<asp:Content ID="feedbackContent" ContentPlaceHolderID="ContentPage" runat="Server">
    <br />
    <br />
    <style>
        @media screen and (min-width: 601px)
        {
            #tbl
            {
                width: 50%;
            }
        }
    </style>
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="feedback" align="center" style="margin: auto;">
                <p style="font-size: 2em" align="center">
                    Send Feedback
                </p>
                <hr width="50vw" style="background-color: #f66400; color: #f66400;"
                    size="2" />
                <br />
                <br />
                <div id="tblFB" runat="server">
                    <table id="tbl" cellpadding="20">
                        <tr>
                            <td align="justify">
                                Name :
                                <asp:Label ID="lblName" runat="server" Text="" Visible="False"></asp:Label>
                                <asp:TextBox ID="txtName" runat="server" Width="100%"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ForeColor="Red" ID="RequiredFieldValidator1" runat="server"
                                    ErrorMessage="Please enter your name" SetFocusOnError ControlToValidate="txtName"></asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator1"
                                    runat="server" ControlToValidate="txtName" ErrorMessage="Name is not valid" ValidationExpression="([A-Za-z]*[\sA-Za-z.]*)"></asp:RegularExpressionValidator>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td align="justify">
                                <asp:TextBox ID="txtFeed" placeholder="Type your feedback..." runat="server" SkinID="none"
                                    TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox>
                                <asp:RequiredFieldValidator ForeColor="Red" ID="RequiredFieldValidator2" runat="server"
                                    ErrorMessage="Please enter some feedback!" SetFocusOnError ControlToValidate="txtFeed"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" OnClick="btnSubmit_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <asp:Label ID="lblStatus" runat="server" Visible="False" ForeColor="#006600"></asp:Label>
                <br />
                <br />
                <asp:HyperLink ID="goFB" runat="server" NavigateUrl="~/Feedback.aspx" SkinID="l"
                    Visible="False">Send another feedback</asp:HyperLink>
                <br />
                <br />
                <br />
            </div>
        </div>
    </div>
</asp:Content>
