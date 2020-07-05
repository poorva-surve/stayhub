<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite2.master" AutoEventWireup="true"
    CodeFile="FullPG.aspx.cs" Inherits="_Default" Theme="Theme" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="fullPG" ContentPlaceHolderID="ContentPage" runat="Server">
    <style>
        html
        {
            overflow-x: visible;
        }
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
        
        }
        @media screen and (max-width: 600px)
        {
            html
            {
                overflow-x: visible;
            }
        }
        .flex-container .imgIcons2
        {
            height: 100%;
            width: 100%;
            margin: 2%;
        }
    </style>
    <br />
    <br />
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div id="viewFullPG" style="margin: auto; width: 90%">
                <center>
                    <asp:Label ID="lblEmpty" runat="server" Font-Size="24px" Visible="False"></asp:Label>
                    <br />
                    <br />
                    <asp:HyperLink ID="linkBack" runat="server" NavigateUrl="~/PendingList.aspx" ForeColor="#F66400"
                        Font-Underline="True" Visible="False">View other pending PGs</asp:HyperLink>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:HyperLink ID="linkAll" runat="server" Font-Underline="True" ForeColor="#F66400"
                        NavigateUrl="~/AdPG.aspx" Visible="False">View registered PGs</asp:HyperLink>
                </center>
                <p align="right" style="margin: auto; width: 90%">
                    <asp:Button ID="deletePG" runat="server" Text="Delete PG" SkinID="del" OnClick="deletePG_Click" />
                    <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="deletePG"
                        ConfirmText="All details of this PG will be permanently deleted. Are you sure to continue?" />
                </p>
                <br />
                <asp:DataList ID="DataListFullPG" runat="server" DataSourceID="SqlDataSourceFullPG"
                    Width="100%" Style="font-family: Arial, Helvetica, sans-serif; font-size: 1em"
                    OnPreRender="DataListFullPG_PreRender">
                    <ItemTemplate>
                        <table style="border-color: #800000; border-width: thick; padding: 20px; width: 90%;
                            margin: auto;" cellpadding="20">
                            <tr>
                                <td colspan="2" bgcolor="#FFCC66" style="border-style: none; border-width: 0px; padding: 20px;
                                    color: #800000;">
                                    <asp:Label ID="lblName" runat="server" Font-Bold="False" Font-Size="1.5em" Text='<%# Eval("Name") %>'
                                        Style="font-weight: 700"></asp:Label>
                                    &nbsp;<span style="font-size: 1.25em"> [ </span>
                                    <asp:Label ID="lblID" runat="server" Font-Size="1.25em" Text='<%# Eval("ID") %>'></asp:Label>
                                    <span style="font-size: 1.25em">&nbsp;]<br />
                                    </span>
                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                    <br />
                                </td>
                                <td align="justify" bgcolor="#FFCC66" style="border-style: none; border-width: 0px;
                                    padding: 20px; color: #800000;" valign="middle">
                                    <strong>Owner:</strong>&nbsp;
                                    <asp:Label ID="lblOwner" runat="server" Font-Bold="False" Text='<%# Eval("OwnerID") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lblOwnerName" runat="server" ></asp:Label>
                                
                                </td>
                            </tr>
                            <tr>
                                <td style="min-height: 3em; width: 40%" bgcolor="#FFFFCC">
                                    &nbsp;<strong>No. of interests :</strong>
                                    <asp:Label ID="lblInterests" runat="server" Text='<%# Eval("Interests") %>'></asp:Label>
                                </td>
                                <td style="min-height: 3em" bgcolor="#FFFFCC">
                                    <strong>Status :</strong><asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                    <br />
                                </td>
                                <td style="min-height: 3em; width: 30%;" bgcolor="#FFFFCC">
                                    <strong>Expiry Date :</strong>
                                    <asp:Label ID="lblExp" runat="server" Text='<%# Eval("ExpiryDate", "{0:d}") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="min-height: 3em; width: 40%" bgcolor="#F9F9F9">
                                    <asp:Label ID="lblAddr" runat="server" Text='<%# Eval("Address") %>' ></asp:Label>
                                    <br />
                                </td>
                                <td style="min-height: 3em" bgcolor="#F9F9F9">
                                    <strong>Preferred Tenants:</strong><br />
                                    <asp:Label ID="lblOcc" runat="server" Text='<%# Eval("Occupancy") %>'></asp:Label>
                                </td>
                                <td style="min-height: 3em" bgcolor="#F9F9F9">
                                    <strong>Rent per month:</strong><br />
                                    Rs.
                                    <asp:Label ID="lblRent" runat="server" Text='<%# Eval("Rent") %>'></asp:Label>
                                    &nbsp;/-
                                </td>
                            </tr>
                            <!--
                    <tr>
                        <td align="center" colspan="3" width="60%">
                            <span style="font-size: 24px">
                                <br />
                                Amenities Available</span>
                            <hr width="5%" style="margin: 10px; background-color: #f66400; color: #f66400;" size="2" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="font-size: 18px;" align="justify">
                            <div style="width: 55%; margin: auto;">
                                <div style="width: 49%; display: inline-block;">
                                    <ul style="font-size: 18px">
                                        <li>Electricity :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblElec" runat="server" Style="font-weight: 700" Text='<%# Eval("Electricity") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul style="font-size: 18px">
                                        <li>Laundry :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblLndry" runat="server" Style="font-weight: bold" Text='<%# Eval("Laundry") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul style="font-size: 18px">
                                        <li>Geyser :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblGeyser" runat="server" Style="font-weight: bold" Text='<%# Eval("Geyser") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul style="font-size: 18px">
                                        <li>Television :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblTV" runat="server"
                                            Style="font-weight: bold" Text='<%# Eval("TV") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul style="font-size: 18px">
                                        <li>Fridge :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblFri" runat="server" Style="font-weight: bold" Text='<%# Eval("Refrigerator") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul style="font-size: 18px">
                                        <li>AC :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblAC" runat="server" Style="font-weight: bold" Text='<%# Eval("AC") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul style="font-size: 18px">
                                        <li>WiFi :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblWi" runat="server" Style="font-weight: bold" Text='<%# Eval("WiFi") %>'></asp:Label>
                                        </li>
                                    </ul>
                                </div>
                                <div style="width: 49%; display: inline-block;">
                                    <ul>
                                        <li style="font-size: 18px">Cooking Stove :&nbsp;
                                            <asp:Label ID="lblCook" runat="server" Style="font-weight: bold" Text='<%# Eval("CookingStove") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul>
                                        <li><span style="font-size: 18px">Meals :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </span>
                                            <asp:Label ID="lblMeals" runat="server" Style="font-size: 18px; font-weight: bold"
                                                Text='<%# Eval("Meals") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul>
                                        <li><span style="font-size: 18px">Non-Veg :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
                                            <asp:Label ID="lblNonV" runat="server" Style="font-size: 18px; font-weight: bold"
                                                Text='<%# Eval("NonVeg") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul>
                                        <li style="font-size: 18px">Study Table :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblTable" runat="server" Style="font-weight: bold" Text='<%# Eval("StudyTable") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul>
                                        <li style="font-size: 18px">Balcony :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblBalc" runat="server" Style="font-weight: bold" Text='<%# Eval("Balcony") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul>
                                        <li style="font-size: 18px">Parking :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblPark" runat="server" Style="font-weight: bold" Text='<%# Eval("Parking") %>'></asp:Label>
                                        </li>
                                    </ul>
                                    <ul>
                                        <li style="font-size: 18px">Security :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="lblSec" runat="server" Style="font-weight: bold" Text='<%# Eval("Security") %>'></asp:Label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="3" width="100%">
                            <span style="font-size: 24px">Photos</span>
                            <hr width="5%" style="margin: 10px; background-color: #f66400; color: #f66400;" size="2" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align: center">
                            <br />
                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Pic1") %>' />
                            <br />
                            <br />
                            <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("Pic2") %>' />
                            <br />
                            <br />
                            <asp:Image ID="Image3" runat="server" ImageUrl='<%# Eval("Pic3") %>' />
                            <br />
                            <br />
                            <asp:Image ID="Image4" runat="server" ImageUrl='<%# Eval("Pic4") %>' />
                            <br />
                            <br />
                            <asp:Image ID="Image5" runat="server" ImageUrl='<%# Eval("Pic5") %>' />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
                <br />
                <br />
                -->
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
                                            <asp:Image ID="Image6" runat="server" ImageUrl='<%# Eval("Pic1") %>' CssClass="imgIcons2" />
                                            <%--<br />
                                                    <asp:Button ID="Button1" runat="server" Text="Button" SkinID="none" />--%>
                                        </div>
                                        <div class="col">
                                            <asp:Image ID="Image7" runat="server" ImageUrl='<%# Eval("Pic2") %>' CssClass="imgIcons2" />
                                            <%--<br />
                                                    <asp:Button ID="Button2" runat="server" Text="Button" SkinID="none" />--%>
                                        </div>
                                        <div class="col">
                                            <asp:Image ID="Image8" runat="server" ImageUrl='<%# Eval("Pic3") %>' CssClass="imgIcons2" />
                                            <%--<br />
                                                    <asp:Button ID="Button3" runat="server" Text="Button" SkinID="none" />--%>
                                        </div>
                                        <div class="col">
                                            <asp:Image ID="Image9" runat="server" ImageUrl='<%# Eval("Pic4") %>' CssClass="imgIcons2" />
                                            <%--<br />
                                                    <asp:Button ID="Button4" runat="server" Text="Button" SkinID="none" />--%>
                                        </div>
                                        <div class="col">
                                            <asp:Image ID="Image10" runat="server" ImageUrl='<%# Eval("Pic5") %>' CssClass="imgIcons2" />
                                            <%--<br />
                                                    <asp:Button ID="Button5" runat="server" Text="Button" SkinID="none" />--%>
                                        </div>
                                    </div>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <br />
                        <br />
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="SqlDataSourceFullPG" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
                    SelectCommand="SELECT * FROM [PG] WHERE ([ID] = @ID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ID" QueryStringField="id" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
</asp:Content>
