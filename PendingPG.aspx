<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite2.master" AutoEventWireup="true"
    CodeFile="PendingPG.aspx.cs" Inherits="_Default" Theme="Theme" %>

<asp:Content ID="pendingPG" ContentPlaceHolderID="ContentPage" runat="Server">
    <style>
        @media screen and (max-width: 600px)
        {
            html
            {
                overflow-x: visible;
            }
        }
    </style>
    <br />
    <br />
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="viewPG" style="margin: auto; width: 80%">
                <center>
                    <asp:Label ID="lblEmpty" runat="server" Font-Size="24px" Visible="False"></asp:Label>
                    <br />
                    <br />
                    <br />
                    <asp:HyperLink ID="linkBack" runat="server" NavigateUrl="~/PendingList.aspx" ForeColor="#F66400"
                        Font-Underline="True" Visible="False">View other pending PGs</asp:HyperLink>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:HyperLink ID="linkAll" runat="server" Font-Underline="True" ForeColor="#F66400"
                        NavigateUrl="~/AdPG.aspx" Visible="False">View registered PGs</asp:HyperLink>
                </center>
                <p align="right">
                    <asp:Button ID="btnApprove" runat="server" Text="Approve" SkinID="green" OnClick="btnApprove_Click" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnDelete" runat="server" Text="Disapprove" SkinID="del" OnClick="btnDelete_Click" />
                </p>
                <br />
                <br />
                <asp:DataList ID="DataListFullPG" runat="server" DataSourceID="SqlDataSourceFullPG"
                    Width="100%" Style="font-family: Arial, Helvetica, sans-serif; font-size: 20px"
                    OnPreRender="DataListFullPG_PreRender">
                    <ItemTemplate>
                        <table style="border-color: #800000; border-width: thick; padding: 20px; width: 100%;
                            margin: auto;" cellpadding="20" runat="server">
                            <tr>
                                <td colspan="2" bgcolor="#FFCC66" style="border-style: none; border-width: 0px; padding: 20px;
                                    color: #800000;">
                                    <asp:Label ID="lblName" runat="server" Font-Bold="False" Font-Size="30px" Text='<%# Eval("Name") %>'
                                        Style="font-weight: 700"></asp:Label>
                                    &nbsp;<span style="font-size: 24px"> [ </span>
                                    <asp:Label ID="lblID" runat="server" Font-Size="24px" Style="font-size: 24px" Text='<%# Eval("ID") %>'></asp:Label>
                                    <span style="font-size: 24px">&nbsp;]<br />
                                    </span>
                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                    <br />
                                </td>
                                <td align="justify" bgcolor="#FFCC66" style="border-style: none; border-width: 0px;
                                    padding: 20px; color: #800000;" valign="middle">
                                    <strong>Owner:</strong>&nbsp;
                                    <asp:Label ID="lblOwner" runat="server" Font-Bold="False" Text='<%# Eval("OwnerID") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lblOwnerName" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="min-height: 50px; width: 40%" bgcolor="#FFFFCC">
                                    <asp:Label ID="lblAddr" runat="server" Text='<%# Eval("Address") %>' Style="font-size: 18px"></asp:Label>
                                    <br />
                                </td>
                                <td style="min-height: 50px" bgcolor="#FFFFCC">
                                    <strong>Preferred Tenants:</strong><br />
                                    <asp:Label ID="lblOcc" runat="server" Text='<%# Eval("Occupancy") %>'></asp:Label>
                                </td>
                                <td style="min-height: 50px" bgcolor="#FFFFCC">
                                    <strong>Rent per month:</strong><br />
                                    Rs.
                                    <asp:Label ID="lblRent" runat="server" Text='<%# Eval("Rent") %>'></asp:Label>
                                    &nbsp;/-
                                </td>
                            </tr>
                        </table>
                        <asp:Table ID="infoTable" runat="server" Style="border-color: #800000; border-width: thick;
                            padding: 20px; width: 100%; margin: auto;" CellPadding="20" BackColor="#FFFFEE">
                            <asp:TableRow>
                                <asp:TableCell Width="60%" HorizontalAlign="Center" ColumnSpan="3">
                    <span style="font-size: 24px;">
                                <br />
                                Amenities Available</span>
                            <hr width="5%" style="margin: 10px; background-color: #f66400; color: #f66400;" size="2" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Justify" ColumnSpan="3">
                                    <div style="margin: auto; width: 60%;">
                                        <div style="width: 49%; display: inline-block;">
                                            <ul style="font-size: 18px">
                                                <li>Electricity :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label1" runat="server" Style="font-weight: 700" Text='<%# Eval("Electricity") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul style="font-size: 18px">
                                                <li>Laundry :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label2" runat="server" Style="font-weight: bold" Text='<%# Eval("Laundry") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul style="font-size: 18px">
                                                <li>Geyser :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label3" runat="server" Style="font-weight: bold" Text='<%# Eval("Geyser") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul style="font-size: 18px">
                                                <li>Television :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label4" runat="server"
                                                    Style="font-weight: bold" Text='<%# Eval("TV") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul style="font-size: 18px">
                                                <li>Fridge :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label5" runat="server" Style="font-weight: bold" Text='<%# Eval("Refrigerator") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul style="font-size: 18px">
                                                <li>AC :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label6" runat="server" Style="font-weight: bold" Text='<%# Eval("AC") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul style="font-size: 18px">
                                                <li>WiFi :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label7" runat="server" Style="font-weight: bold" Text='<%# Eval("WiFi") %>'></asp:Label>
                                                </li>
                                            </ul>
                                        </div>
                                        <div style="width: 49%; display: inline-block;">
                                            <ul>
                                                <li style="font-size: 18px">Cooking Stove :&nbsp;
                                                    <asp:Label ID="Label8" runat="server" Style="font-weight: bold" Text='<%# Eval("CookingStove") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul>
                                                <li><span style="font-size: 18px">Meals :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                </span>
                                                    <asp:Label ID="Label9" runat="server" Style="font-size: 18px; font-weight: bold"
                                                        Text='<%# Eval("Meals") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul>
                                                <li><span style="font-size: 18px">Non-Veg :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
                                                    <asp:Label ID="Label10" runat="server" Style="font-size: 18px; font-weight: bold"
                                                        Text='<%# Eval("NonVeg") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul>
                                                <li style="font-size: 18px">Study Table :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label11" runat="server" Style="font-weight: bold" Text='<%# Eval("StudyTable") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul>
                                                <li style="font-size: 18px">Balcony :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label12" runat="server" Style="font-weight: bold" Text='<%# Eval("Balcony") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul>
                                                <li style="font-size: 18px">Parking :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label13" runat="server" Style="font-weight: bold" Text='<%# Eval("Parking") %>'></asp:Label>
                                                </li>
                                            </ul>
                                            <ul>
                                                <li style="font-size: 18px">Security :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="Label14" runat="server" Style="font-weight: bold" Text='<%# Eval("Security") %>'></asp:Label>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Center">
                        <span style="font-size: 24px">Photos</span>
                        <hr width="5%" style="margin: 10px; background-color: #f66400; color: #f66400;" size="2" />
                    
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Center">
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
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <br />
                        <br />
                        <br />
                        <br />
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
        </div>
    </div>
</asp:Content>
