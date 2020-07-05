<%@ Page Title="" Language="C#" MasterPageFile="~/OwnerSite2.master" AutoEventWireup="true"
    CodeFile="OwnerSuccess.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="Server">
    <br />
    <br />
    <style>
        @media screen and (min-width: 601px)
        {
            #renew_success
            {
                width: 50%;
            }
        }
    </style>
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="renew_success" align="center" style="margin: auto;">
                <p style="font-size: 2em" align="center">
                    Thank You!
                </p>
                <hr width="50vw" style=" background-color: #f66400; color: #f66400;"
                    size="2" />
                <p>
                    Transaction ID:
                    <asp:Label ID="lblTxn" runat="server" Text=""></asp:Label>
                    <br />
                    <span style="color: #008000; font-size: 1.25em">Your payment is processed successfully.</span>
                    <br />
                    <br />
                    Your PG will be advertised for another 30 days on StayHub.com
                    <br />
                    You can find your PG under the 'My PGs' tab in the menu.
                    <br />
                    <br />
                    <a href="RenewPG.aspx">Click here to renew another PG</a>
                </p>
            </div>
        </div>
    </div>
    <br />
    <br />
</asp:Content>
