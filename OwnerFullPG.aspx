<%@ Page Title="" Language="C#" MasterPageFile="~/OwnerSite2.master" AutoEventWireup="true"
    CodeFile="OwnerFullPG.aspx.cs" Inherits="_Default" Theme="Theme" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="fullPG" ContentPlaceHolderID="ContentPage" runat="Server">
    <style>
        .flex-container
        {
            width: 100%;
            margin: 0;
            padding: 0;
        }
        .flex-container .amenities
        {
            margin: 10px 20px;
            padding: 30px;
            line-height: 2em;
            min-width: 30%;
            height: 100%;
        }
        #avAmn
        {
            background: rgba(0,255,0,0.2);
        }
        #unAmn
        {
            background: rgba(255,0,0,0.2);
        }
        @media screen and (min-width: 601px)
        {
            #editAmn
            {
                width: 50%;
            }
        }
        @media screen and (max-width: 600px)
        {
            html
            {
                overflow-x: visible;
            }
            #editAmn
            {
                width: 70%;
            }
        }
        .flex-container .imgIcons2
        {
            height: 100%;
            width: 100%;
            margin: 2%;
        }
        #editAmn .fieldLabels
        {
            padding: 0;
            margin: 0;
            font-size: 1em;
        }
    </style>
    <br />
    <br />
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="viewFullPG" style="margin: auto; width: 90%">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <center>
                    <asp:Label ID="lblEmpty" runat="server" Font-Size="24px" Visible="False"></asp:Label>
                    <br />
                    <br />
                </center>
                <p align="right" style="margin: auto; width: 90%">
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" SkinID="yellow" OnClick="btnCancel_Click"
                        Visible="False" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnUpdate" runat="server" Text="Edit PG" SkinID="green" OnClick="btnUpdate_Click" />
                    &nbsp;&nbsp;
                    <asp:Button ID="deletePG" runat="server" Text="Delete PG" SkinID="del" OnClick="deletePG_Click" />
                
                            <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="deletePG" ConfirmText="All details of this PG will be permanently deleted. Are you sure to continue?" />
                            </p>
                <br />
                <asp:DataList ID="DataListFullPG" runat="server" DataSourceID="SqlDataSourceFullPG"
                    Width="100%" Style="font-family: Arial, Helvetica, sans-serif; font-size: 1em"
                    OnPreRender="DataListFullPG_PreRender">
                    <ItemTemplate>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <table style="border-color: #800000; border-width: thick; padding: 1em; width: 90%;
                                    margin: auto;" cellpadding="20">
                                    <tr>
                                        <td colspan="3" bgcolor="#FFCC66" style="border-style: none; border-width: 0px; padding: 1em;
                                            color: #800000;">
                                            <asp:Label ID="lblName" runat="server" Font-Bold="False" Font-Size="1.5em" Text='<%# Eval("Name") %>'
                                                Style="font-weight: 700; display: run-in;"></asp:Label>
                                            <asp:TextBox ID="txtName" runat="server" Font-Bold="False" Font-Size="1.5em" Text='<%# Eval("Name") %>'
                                                Style="font-weight: 700;" Visible="False" SkinID="adm" />
                                            &nbsp;<span style="font-size: 1.25em"> [ </span>
                                            <asp:Label ID="lblID" runat="server" Font-Size=" 1.25em" Text='<%# Eval("ID") %>'
                                                Visible="True"></asp:Label>
                                            <span style="font-size: 1.25em">&nbsp;]<br />
                                            </span>
                                            <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="min-height: 3em; width: 30%" bgcolor="#FFFFCC">
                                            <asp:Label ID="lblAddr" runat="server" Text='<%# Eval("Address") %>' Style="font-size: 1em">
                                            </asp:Label>
                                            <asp:TextBox ID="txtAddr" runat="server" Font-Bold="False" Font-Size="1em" Text='<%# Eval("Address") %>'
                                                Style="font-weight: 700;" Visible="False" SkinID="adm" />
                                            <br />
                                        </td>
                                        <td style="min-height: 3em; width: 40%" bgcolor="#FFFFCC">
                                            <strong>Preferred Tenants:</strong><br />
                                            <asp:Label ID="lblOcc" runat="server" Text='<%# Eval("Occupancy") %>'>
                                            </asp:Label>
                                            <asp:TextBox ID="txtOcc" runat="server" Font-Bold="False" Font-Size="1em" Text='<%# Eval("Occupancy") %>'
                                                Style="font-weight: 700;" Visible="False" SkinID="adm" />
                                        </td>
                                        <td style="min-height: 3em; width: 30%" bgcolor="#FFFFCC">
                                            <strong>Rent per month:</strong><br />
                                            Rs.
                                            <asp:Label ID="lblRent" runat="server" Text='<%# Eval("Rent") %>'></asp:Label>
                                            <asp:TextBox ID="txtRent" runat="server" Font-Bold="False" Font-Size="1em" Text='<%# Eval("Rent") %>'
                                                Style="font-weight: 700;" Visible="False" SkinID="adm" />
                                            &nbsp;/-
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="min-height: 3em;" bgcolor="#F9F9F9">
                                            <strong>No. of interests :</strong>
                                            <asp:Label ID="lblInterests" runat="server" Text='<%# Eval("Interests") %>'></asp:Label>
                                        </td>
                                        <td style="min-height: 3em" bgcolor="#F9F9F9">
                                            <strong>Status :</strong>
                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                        </td>
                                        <td style="min-height: 3em;" bgcolor="#F9F9F9">
                                            <strong>Expiry Date :</strong>
                                            <br />
                                            <asp:Label ID="lblExp" runat="server" Text='<%# Eval("ExpiryDate", "{0:d}") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Table ID="infoTable" runat="server" Style="width: 90%; margin: auto;" BorderColor="#FFCC66"
                                    BorderStyle="Double">
                                    <asp:TableRow>
                                        <asp:TableCell Width="60%" HorizontalAlign="Center" ColumnSpan="3">
                    <span style="font-size: 24px;">
                                <br />
                                Amenities Available</span>
                            <hr width="5%" style="margin: 0.5em; background-color: #f66400; color: #f66400;" size="2" />


                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Visible="False" ID="editAmenitiesList">
                                        <asp:TableCell ColumnSpan="3">
                                            <div id="editAmn" class="container" style="margin: auto; width: 20em;">
                                                <br />
                                                <br />
                                                <dl type="none" style="font-size: 1em">
                                                    <dt>Electricity :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblElec" runat="server" Style="font-weight: 700" Text='<%# Eval("Electricity") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlElec" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl style="font-size: 1em">
                                                    <dt>Laundry :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblLndry" runat="server" Style="font-weight: bold" Text='<%# Eval("Laundry") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlLndry" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl style="font-size: 1em">
                                                    <dt>Geyser :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblGeyser" runat="server" Style="font-weight: bold" Text='<%# Eval("Geyser") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlGeyser" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl style="font-size: 1em">
                                                    <dt>Television :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblTV" runat="server" Style="font-weight: bold" Text='<%# Eval("TV") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlTV" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl style="font-size: 1em">
                                                    <dt>Fridge :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblFri" runat="server" Style="font-weight: bold" Text='<%# Eval("Refrigerator") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlFri" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl style="font-size: 1em">
                                                    <dt>AC :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblAC" runat="server" Style="font-weight: bold" Text='<%# Eval("AC") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlAC" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl style="font-size: 1em">
                                                    <dt>WiFi :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblWi" runat="server" Style="font-weight: bold" Text='<%# Eval("WiFi") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlWi" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl>
                                                    <dt style="font-size: 1em">Cooking Stove :&nbsp;
                                                        <asp:Label ID="lblCook" runat="server" Style="font-weight: bold" Text='<%# Eval("CookingStove") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlCook" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl>
                                                    <dt><span style="font-size: 1em">Meals :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </span>
                                                        <asp:Label ID="lblMeals" runat="server" Style="font-weight: bold"
                                                            Text='<%# Eval("Meals") %>' Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlMeals" runat="server">
                                                            <asp:ListItem Value="Provided"></asp:ListItem>
                                                            <asp:ListItem Value="Not Provided"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl>
                                                    <dt><span style="font-size: 1em">Non-Veg :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
                                                        <asp:Label ID="lblNonV" runat="server" Style="font-weight: bold"
                                                            Text='<%# Eval("NonVeg") %>' Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlNonV" runat="server">
                                                            <asp:ListItem Value="Allowed"></asp:ListItem>
                                                            <asp:ListItem Value="Not Allowed"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl>
                                                    <dt style="font-size: 1em">Study Table :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblTable" runat="server" Style="font-weight: bold" Text='<%# Eval("StudyTable") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlTable" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl>
                                                    <dt style="font-size: 1em">Balcony :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblBalc" runat="server" Style="font-weight: bold" Text='<%# Eval("Balcony") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlBalc" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl>
                                                    <dt style="font-size: 1em">Parking :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblPark" runat="server" Style="font-weight: bold" Text='<%# Eval("Parking") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlPark" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <dl>
                                                    <dt style="font-size: 1em">Security :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <asp:Label ID="lblSec" runat="server" Style="font-weight: bold" Text='<%# Eval("Security") %>'
                                                            Visible="False"></asp:Label>
                                                        <asp:DropDownList CssClass="fieldLabels" ID="ddlSec" runat="server">
                                                            <asp:ListItem Value="Yes"></asp:ListItem>
                                                            <asp:ListItem Value="No"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </dt>
                                                </dl>
                                                <br />
                                            </div>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="viewAmenitiesList" Visible="True">
                                        <asp:TableCell HorizontalAlign="Justify" ColumnSpan="3">
                                            <div id="form" class=" container" style="visibility: visible">
                                                <div style="margin: auto; width: 100%;">
                                                    <div class="row flex-container">
                                                        <div id="avAmn" class="amenities shadow rounded">
                                                            <asp:Label ID="lblAvailableAmn" runat="server" Text=" "></asp:Label>
                                                        </div>
                                                        <div id="unAmn" class="amenities shadow rounded">
                                                            <asp:Label ID="lblUnavailableAmn" runat="server" Text=""></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <br />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Center" ColumnSpan="3">
                        <span style="font-size: 1.5em">Photos</span>
                        <hr width="5%" style="margin: 10px; background-color: #f66400; color: #f66400;" size="2" />
                    
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="viewPhotos">
                                        <asp:TableCell HorizontalAlign="Center" ColumnSpan="3">
                                            <div class="row flex-container">
                                                <div class="col ">
                                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Pic1") %>' CssClass="imgIcons2" AlternateText=" " />
                                                    <%--<br />
                                                    <asp:Button ID="Button1" runat="server" Text="Button" SkinID="none" />--%>
                                                </div>
                                                <div class="col">
                                                    <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("Pic2") %>' CssClass="imgIcons2" AlternateText="  " />
                                                    <%--<br />
                                                    <asp:Button ID="Button2" runat="server" Text="Button" SkinID="none" />--%>
                                                </div>
                                                <div class="col">
                                                    <asp:Image ID="Image3" runat="server" ImageUrl='<%# Eval("Pic3") %>' CssClass="imgIcons2" AlternateText=" " />
                                                    <%--<br />
                                                    <asp:Button ID="Button3" runat="server" Text="Button" SkinID="none" />--%>
                                                </div>
                                                <div class="col">
                                                    <asp:Image ID="Image4" runat="server" ImageUrl='<%# Eval("Pic4") %>' CssClass="imgIcons2" AlternateText="  " />
                                                    <%--<br />
                                                    <asp:Button ID="Button4" runat="server" Text="Button" SkinID="none" />--%>
                                                </div>
                                                <div class="col">
                                                    <asp:Image ID="Image5" runat="server" ImageUrl='<%# Eval("Pic5") %>' CssClass="imgIcons2" AlternateText=" " />
                                                    <%--<br />
                                                    <asp:Button ID="Button5" runat="server" Text="Button" SkinID="none" />--%>
                                                </div>
                                                <br /><br />
                                            </div>

                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow Visible="False" ID="editPhotos">
                                        <asp:TableCell ColumnSpan="3">
                                            <div id="editPic" class="container" style="margin: auto; width: 20em;">
                                                <br />
                                                <br />
                                                <asp:FileUpload ID="FilePic1" runat="server" Visible="False" />
                                                <asp:Label ID="pic1Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                                                <br />
                                                <br />
                                                <asp:FileUpload ID="FilePic2" runat="server" Visible="False" />
                                                <asp:Label ID="pic2Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                                                <br />
                                                <br />
                                                <asp:FileUpload ID="FilePic3" runat="server" Visible="False" />
                                                <asp:Label ID="pic3Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                                                <br />
                                                <br />
                                                <asp:FileUpload ID="FilePic4" runat="server" Visible="False" />
                                                <asp:Label ID="pic4Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                                                <br />
                                                <br />
                                                <asp:FileUpload ID="FilePic5" runat="server" Visible="False" />
                                                <asp:Label ID="pic5Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                                                <br />
                                                <br />
                                            </div>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <br />
                                <br />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceFullPG" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
        SelectCommand="SELECT * FROM [PG] WHERE ([ID] = @ID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="id" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
