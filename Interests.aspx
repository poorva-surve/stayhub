<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="Interests.aspx.cs" Inherits="_Default" %>

<asp:Content ID="interestsContent" ContentPlaceHolderID="ContentPage" runat="Server">
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
        @media screen and (max-width: 600px)
        {
            html
            {
                overflow-x: visible;
            }
        }
    </style>
    <%--<p style="font-size: 36px" align="center">
            All PG Homes
        </p>
        <hr width="10%" style="margin: 0px; background-color: #f66400; color: #f66400;" size="2" />
        <br />--%>
    <br />
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="viewPG" style="margin: auto; width: 90%">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                <asp:DataList ID="DataListFullPG" runat="server" DataSourceID="SqlDataSourceFullPG"
                    Width="100%" Style="font-family: Arial, Helvetica, sans-serif; font-size: 1em"
                    OnItemCommand="DataListFullPG_ItemCommand" OnPreRender="DataListFullPG_PreRender">
                    <ItemTemplate>
                        <table id="Table1" style="border-color: #800000; border-width: thick; padding: 1em;
                            width: 90%; margin: auto;" cellpadding="20" runat="server">
                            <tr bgcolor="#FFCC66" style="border-style: none; border-width: 2px; padding: 1em;
                                color: #800000;">
                                <td width="55%" style="border-color: #800000; border-right-style: dotted; border-width: 2px">
                                    <asp:Label ID="lblName" runat="server" Font-Bold="False" Font-Size="1.5em" Text='<%# Eval("Name") %>'
                                        Style="font-weight: 700"></asp:Label>
                                    &nbsp;<span style="font-size: 1.25em"> [ </span>
                                    <asp:Label ID="lblID" runat="server" Font-Size="24px" Style="font-size: 1.25em" Text='<%# Eval("ID") %>'></asp:Label>
                                    <span style="font-size: 1.25em">&nbsp;]<br />
                                    </span>
                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                    <br />
                                </td>
                                <td style="line-height: 1.5em" valign="middle">
                                    <asp:Label ID="lblOID" runat="server" Font-Bold="True" Text='<%# Eval("Expr1") %>'
                                        Visible="False"></asp:Label>
                                    <asp:Label ID="lblOwner" runat="server" Font-Bold="True" Text='<%# Eval("Expr2") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lblContact" runat="server" Enabled="False" Font-Underline="False"
                                        Text='<%# Eval("Mobile") %>'></asp:Label>
                                    <asp:Label ID="lblSep" runat="server" Text="&nbsp; | &nbsp;"></asp:Label>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="min-height: 3em;" bgcolor="#FFFFCC">
                                    <asp:Label ID="lblAddr" runat="server" Text='<%# Eval("Address") %>' Style="font-size: 1em"></asp:Label>
                                    <br />
                                </td>
                                <td style="min-height: 3em" bgcolor="#FFFFCC">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <strong>Rent per month:</strong><br />
                                                Rs.
                                                <asp:Label ID="lblRent" runat="server" Text='<%# Eval("Rent") %>'></asp:Label>
                                                &nbsp;/- &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnVisit" runat="server" Text="Request A Visit" SkinID="small" CommandName="reqVisit"
                                                    CommandArgument='<%# Eval("ID") %>' />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="min-height: 3em; width: 50%" bgcolor="#F9F9F9">
                                    <strong>Preferred Tenants:</strong><br />
                                    <asp:Label ID="lblOcc" runat="server" Text='<%# Eval("Occupancy") %>'></asp:Label>
                                </td>
                                <td style="min-height: 3em" bgcolor="#F9F9F9">
                                    <strong>No. of interests :</strong>
                                    <asp:Label ID="lblInterests" runat="server" Text='<%# Eval("Interests") %>' Visible="True"></asp:Label>
                                    &nbsp;&nbsp;&nbsp;
                                    <%--<asp:Button ID="btnInterest1" runat="server" Text="Mark as Interested" SkinID="del" CommandName="addInterest" CommandArgument='<%# Eval("ID") %>' />--%>
                                    <asp:Button ID="btnInterest" runat="server" Text="Remove from Interests" SkinID="del"
                                        CommandName="remInterest" CommandArgument='<%# Eval("ID") %>' />
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnExpand" EventName="Click" />
                            </Triggers>
                            <ContentTemplate>
                                <div style="width: 90%; margin: auto;">
                                    <asp:Button ID="btnExpand" runat="server" Text="Read More..." CommandName="readMore"
                                        CommandArgument='<%# Eval("ID") %>' SkinID="blue" />
                                </div>
                                <asp:Table ID="infoTable" runat="server" Style="width: 90%; margin: auto;"
                                    Visible="False" BorderColor="#FFCC66" BorderStyle="Double">
                                    <asp:TableRow>
                                        <asp:TableCell Width="60%" HorizontalAlign="Center" ColumnSpan="3">
                    <span style="font-size: 24px;">
                                <br />
                                Amenities Available</span>
                            <hr width="5%" style="margin: 0.5em; background-color: #f66400; color: #f66400;" size="2" />

                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Justify" ColumnSpan="3">
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
                                        <asp:TableCell HorizontalAlign="Center"  ColumnSpan="3">
                        <span style="font-size: 1.5em">Photos</span>
                        <hr width="5%" style="margin: 10px; background-color: #f66400; color: #f66400;" size="2" />
                    
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow>
                                        <asp:TableCell HorizontalAlign="Center" ColumnSpan="3">
                                            <div class="row flex-container">
                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("Pic1") %>'
                                                    CommandName="pgImg" CommandArgument='<%# Eval("Pic1") %>' CssClass="imgIcons" />
                                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl='<%# Eval("Pic2") %>'
                                                    CommandName="pgImg" CommandArgument='<%# Eval("Pic2") %>' CssClass="imgIcons" />
                                                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl='<%# Eval("Pic3") %>'
                                                    CommandName="pgImg" CommandArgument='<%# Eval("Pic3") %>' CssClass="imgIcons" />
                                                <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl='<%# Eval("Pic4") %>'
                                                    CommandName="pgImg" CommandArgument='<%# Eval("Pic4") %>' CssClass="imgIcons" />
                                                <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl='<%# Eval("Pic5") %>'
                                                    CommandName="pgImg" CommandArgument='<%# Eval("Pic5") %>' CssClass="imgIcons" />
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
                
                    </ContentTemplate>
                    </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceFullPG" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
        SelectCommand="SELECT PG.ID, PG.OwnerID, PG.Name, PG.Address, PG.City, PG.Rent, PG.Occupancy, PG.Pic1, PG.Pic2, PG.Pic3, PG.Pic4, PG.Pic5, PG.Meals, PG.NonVeg, PG.Electricity, PG.AC, PG.TV, PG.WiFi, PG.Laundry, PG.Geyser, PG.Refrigerator, PG.CookingStove, PG.Furnished, PG.StudyTable, PG.Balcony, PG.Parking, PG.Security, PG.Interests, PG.ExpiryDate, PG.Status, Users.ID AS Expr1, Users.Name AS Expr2, Users.Mobile, Users.Email, Interests.UID, Interests.PID FROM PG INNER JOIN Users ON PG.OwnerID = Users.ID INNER JOIN Interests ON PG.ID = Interests.PID WHERE Interests.UID =  @uid and PG.Status = 'Active'">
        <SelectParameters>
            <asp:SessionParameter Name="uid" SessionField="userid" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
