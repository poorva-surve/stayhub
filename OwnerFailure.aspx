<%@ Page Title="" Language="C#" MasterPageFile="~/OwnerSite2.master" AutoEventWireup="true"
    CodeFile="OwnerFailure.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPage" runat="Server">
    <br />
    <br />
    <style>
        @media screen and (min-width: 601px)
        {
            #renew_failure
            {
                width: 50%;
            }
        }
    </style>
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="renew_failure" align="center" style="margin: auto;">
                <p style="font-size: 2em" align="center">
                    Oops! Something went wrong...
                </p>
                <hr width="50vw" style="background-color: #f66400; color: #f66400;"
                    size="2" />
                <p>
                    Transaction ID:
                    <asp:Label ID="lblTxn" runat="server" Text=""></asp:Label>
                    <br />
                    <span style="color: Red; font-size: 1.25em">Your payment could not be processed</span>
                    <br />
                    <br />
                    Please check your payment details and try again after some time.
                    <br />
                    You can also reach out to us at
                    <br />
                    <a href="tel:+91 9821070248">+91 9821 070 248</a><br />
                    or
                    <br />
                    <a href="mailto:customer.care@stayhub.com">customer.care@stayhub.com</a>
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
