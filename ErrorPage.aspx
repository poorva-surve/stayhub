<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ErrorPage.aspx.cs" Inherits="ErrorPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Something went wrong...</title>
    <link href="Stylesheet/Style.css" rel="stylesheet" type="text/css" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <style>
        h1
        {
            font-size: 2em;
        }
        h3
        {
            font-size: 1.5em;
        }
        #errContent
        {
            padding: 2em;
        }
    </style>
</head>
<body>
<center>
    <div id="errorPage" class="row flex-container" style="height: 90vh">
        <div id="errPic" class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
            <asp:Image ID="errImage" runat="server" ImageUrl="~/Images/error.jpg" Width="90%" />
        </div>
        <div id="errContent" class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
            <p>
                <h1>Oops... something went wrong!</h1>
                <br />
                <h3>Sorry for the inconvenience. <br />Please try again after some time!</h3>
            </p>
            <br />
            <p>
                <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="#F66400" Font-Size="1.25em">Go back</asp:HyperLink>
            </p>
        </div>
    </div>
    </center>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>
