<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="AdPG.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="adminPG" ContentPlaceHolderID="ContentPage" runat="Server">
    <style>
        html
        {
            overflow-x: visible;
        }
    </style>
    <br />
    <br />
    <br />
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div id="viewPG" style="margin: auto; width: 80%">
            <p style="font-size: 36px" align="center">
                Registered PG Homes
            </p>
            <hr width="10%" style="background-color: #f66400; color: #f66400;" size="2" />
            <br />
            <br />
            <br />
            <div align="center">
                    <asp:DropDownList ID="ddlSorting" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSorting_SelectedIndexChanged">
                        <asp:ListItem Value="">Sort By:</asp:ListItem>
                        <asp:ListItem Value="latest">Latest PG</asp:ListItem>
                        <asp:ListItem Value="name">Name [A-Z]</asp:ListItem>
                        <asp:ListItem Value="nameD">Name [Z-A]</asp:ListItem>
                        <asp:ListItem Value="city">City [A-Z]</asp:ListItem>
                        <asp:ListItem Value="cityD">City [Z-A]</asp:ListItem>
                    </asp:DropDownList>
                    <button type="button" runat="server" id="btnSelectFilters" class="btn btn-outline-dark"
                        data-toggle="modal" data-target="#filterModal" style="width: 20em; font-size: 1em;
                        height: 2.5em;">
                        View By Cities (<asp:Label ID="lblFilterCount" runat="server" Text="0"></asp:Label>)</button>
                    <div id="filterModal" class="modal fade" role="dialog">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">
                                        Select Cities:</h4>
                                    <button type="button" class="close" data-dismiss="modal">
                                        &times;</button>
                                </div>
                                <div class="modal-body">
                                    <asp:CheckBoxList ID="chkFilters" runat="server">
                                        <asp:ListItem Value="Mumbai">&nbsp;Mumbai</asp:ListItem>
                                        <asp:ListItem Value="Delhi">&nbsp;Delhi</asp:ListItem>
                                        <asp:ListItem Value="Bangalore">&nbsp;Bangalore</asp:ListItem>
                                        <asp:ListItem Value="Chennai">&nbsp;Chennai</asp:ListItem>
                                        <asp:ListItem Value="Kolkata">&nbsp;Kolkata</asp:ListItem>
                                        <asp:ListItem Value="Pune">&nbsp;Pune</asp:ListItem>
                                    </asp:CheckBoxList>
                                </div>
                                <div class="modal-footer">
                                    <%--<button type="button" runat="server" id="btnApplyFilters" class="btn btn-success">
                                        Apply Filters (<asp:Label ID="lblFilterCount" runat="server" Text="0"></asp:Label>)</button>--%>
                                    <asp:Button ID="btnApplyFilters" class="btn btn-success" runat="server" SkinID="none"
                                        Text="Apply Filters " OnClick="btnApplyFilters_Click" />
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">
                                        Cancel</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
                    <br /><br />
            <asp:DataList ID="DataList1" runat="server" DataKeyField="ID" DataSourceID="SqlDataSourcePG"
                Style="font-family: Arial, Helvetica, sans-serif; text-align: justify;" Width="100%"
                ForeColor="#333333" OnItemCommand="DataList1_ItemCommand" OnPreRender="DataList1_PreRender">
                <AlternatingItemStyle BackColor="#FDFDFD" />
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <ItemTemplate>
                    <table cellspacing="0" style="width: 100%" cellpadding="15">
                        <tr>
                            <td style="width: 35%">
                                <asp:Label ID="lblName" runat="server" Font-Bold="True" Font-Size="20px" Text='<%# Eval("Name") %>'></asp:Label>
                                &nbsp; [
                                <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                &nbsp;]<br />
                                <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                <br />
                                <br />
                            </td>
                            <td rowspan="2" style="width: 20%; text-align: center;" valign="middle">
                                <asp:Image ID="Image1" runat="server" Height="80px" ImageUrl='<%# Eval("Pic1") %>'
                                    Width="130px" />
                                <br />
                                <br />
                                <asp:Image ID="Image2" runat="server" Height="80px" ImageUrl='<%# Eval("Pic2") %>'
                                    Width="130px" />
                            </td>
                            <td style="width: 25%">
                                <span style="font-size: 20px">Rs.</span>
                                <asp:Label ID="lblRent" runat="server" Font-Size="20px" Text='<%# Eval("Rent") %>'></asp:Label>
                                &nbsp;per month<br />
                                <br />
                                <asp:Label ID="lblInterests" runat="server" Font-Bold="True" Text='<%# Eval("Interests") %>'></asp:Label>
                                &nbsp;Interests<br />
                            </td>
                            <td style="text-align: center">
                                <asp:Button ID="btnView" runat="server" CommandName="viewFull" CommandArgument='<%# Eval("ID") %>'
                                    Text="View" SkinID="green" />
                            </td>
                            <td style="text-align: center">
                                <asp:Button ID="btnDelete" runat="server" CommandName="deletePG" CommandArgument='<%# Eval("ID") %>'
                                    Text="Delete" SkinID="del" />
                                <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnDelete"
                                    ConfirmText="All details of this PG will be permanently deleted. Are you sure to continue?" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 35%">
                                Owner:
                                <asp:Label ID="lblOwnerID" runat="server" Font-Italic="True" Text='<%# Eval("OwnerID") %>'></asp:Label>
                                <br />
                                <asp:Label ID="lblOwnerName" runat="server" Font-Italic="True" ></asp:Label>
                                <br />
                            </td>
                            <td style="width: 25%">
                                Status:
                                <asp:Label ID="lblStatus" runat="server" Font-Bold="True" ForeColor="#009900" Text='<%# Eval("Status") %>'></asp:Label>
                                <br />
                                Expiry Date:
                                <asp:Label ID="lblExpiry" runat="server" Font-Bold="True" Text='<%# Eval("ExpiryDate", "{0:d}") %>'></asp:Label>
                                <br />
                            </td>
                        </tr>
                    </table>
                    <br />
                </ItemTemplate>
                <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:DataList>
            <br />
            <asp:SqlDataSource ID="SqlDataSourcePG" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
                OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [PG] WHERE ([ExpiryDate] &lt;&gt; @Exp) ">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1900-01-01" Name="Exp" DbType="Date" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            
            <br />
        </div>
    </div>
</asp:Content>
