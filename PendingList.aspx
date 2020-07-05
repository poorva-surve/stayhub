<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="PendingList.aspx.cs" Inherits="_Default" %>

<asp:Content ID="pendingList" ContentPlaceHolderID="ContentPage" runat="Server">
    <style>
        html
        {
            overflow-x: visible;
        }
    </style>
    <br />
    <br />
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <div id="viewPG" style="margin: auto; width: 80%">
            <p style="font-size: 36px" align="center">
                Pending PG Homes
            </p>
            <hr width="10%" style="background-color: #f66400; color: #f66400;" size="2" />
            <br />
            <br />
            <center>
                <asp:Label ID="lblEmpty" runat="server" Text=""></asp:Label>
            </center>
            <br />
            <asp:DataList ID="DataList1" runat="server" DataKeyField="ID" DataSourceID="SqlDataSourcePG"
                Style="font-family: Arial, Helvetica, sans-serif; text-align: justify;" Width="100%"
                ForeColor="#333333" OnItemCommand="DataList1_ItemCommand" 
                onprerender="DataList1_PreRender">
                <AlternatingItemStyle BackColor="#FDFDFD" />
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <ItemTemplate>
                    <table cellspacing="0" style="width: 100%" cellpadding="15">
                        <tr>
                            <td style="width: 40%" valign="top">
                                <asp:Label ID="lblName" runat="server" Font-Bold="True" Font-Size="20px" Text='<%# Eval("Name") %>'></asp:Label>
                                &nbsp; [
                                <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                &nbsp;]
                                <br />
                                <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                <br />
                                <br />
                                <asp:Label ID="lblAddr" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                            </td>
                            <td style="width: 10%; text-align: center;" valign="middle">
                                <asp:Image ID="Image1" runat="server" Height="80px" ImageUrl='<%# Eval("Pic1") %>'
                                    Width="130px" />
                                <br />
                                <br />
                                <asp:Image ID="Image2" runat="server" Height="80px" ImageUrl='<%# Eval("Pic2") %>'
                                    Width="130px" />
                            </td>
                            <td style="width: 30%" valign="top">
                                Owner: &nbsp;
                                <asp:Label ID="lblOwnerID" runat="server" Text='<%# Eval("OwnerID") %>'></asp:Label>
                                <br />
                                <asp:Label ID="lblOwnerName" runat="server" ></asp:Label>
                                <br />
                                <br />
                                <span style="font-size: 20px">Rs.</span>
                                <asp:Label ID="lblRent" runat="server" Font-Size="20px" Text='<%# Eval("Rent") %>'></asp:Label>
                                &nbsp;per month<br />
                                <br />
                                <br />
                                <asp:Label ID="lblOcc" runat="server" Text='<%# Eval("Occupancy") %>'></asp:Label>
                            </td>
                            <td style="text-align: center" valign="middle">
                                <asp:Button ID="btnView" runat="server" CommandName="viewFull" CommandArgument='<%# Eval("ID") %>'
                                    Text=" View Details " SkinID="small" />
                                <br />
                                <br />
                                <asp:Button ID="appPG" runat="server" Text="Approve" CommandArgument='<%# Eval("ID") %>'
                                    CommandName="approvePG" SkinID="green" />
                                <br />
                                <br />
                                <asp:Button ID="btnDelete" runat="server" CommandName="deletePG" CommandArgument='<%# Eval("ID") %>'
                                    Text="Disapprove" SkinID="del" />
                            </td>
                        </tr>
                    </table>
                    <br />
                </ItemTemplate>
                <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            </asp:DataList>
            <br />
            <asp:SqlDataSource ID="SqlDataSourcePG" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
                OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [PG] WHERE (([Status] = @Stat) AND ([ExpiryDate] = @Exp))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="Inactive" Name="Stat" Type="String" />
                    <asp:Parameter DbType="Date" DefaultValue="1900-01-01" Name="Exp" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
        </div>
    </div>
</asp:Content>
