<%@ Page Title="" Language="C#" MasterPageFile="~/OwnerSite2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="OwnExpiry.aspx.cs" Inherits="_Default" %>

<asp:Content ID="ownerExpiry" ContentPlaceHolderID="ContentPage" runat="Server">
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
    <div id="expStat" style="margin: auto; width: 80%">
        <p style="font-size: 36px" align="center">
            PG Status
        </p>
        <hr width="10%" style="background-color: #f66400; color: #f66400;" size="2" />
        <br />
        <br />
        <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:DataList ID="DataListExpiringPG" runat="server" DataKeyField="ID" Style="font-family: Arial, Helvetica, sans-serif;
            text-align: justify;" Width="100%" ForeColor="#333333" OnItemCommand="DataList1_ItemCommand"
            DataSourceID="SqlDataSourceRenew" OnPreRender="DataListExpiringPG_PreRender">
            <AlternatingItemStyle BackColor="#FDFDFD" />
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server"></asp:Label>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table cellspacing="0" style="width: 100%" cellpadding="15">
                            <tr>
                                <td style="width: 40%">
                                    <asp:Label ID="lblName" runat="server" Font-Bold="True" Font-Size="20px" Text='<%# Eval("Name") %>'></asp:Label>
                                    &nbsp; [
                                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                    &nbsp;]<br />
                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Label ID="lblAddr" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                </td>
                                <td rowspan="2" style="width: 15%; text-align: center;" valign="middle">
                                    <asp:Image ID="Image1" runat="server" Height="80px" ImageUrl='<%# Eval("Pic1") %>'
                                        Width="" />
                                    <br />
                                    <br />
                                    <asp:Image ID="Image2" runat="server" Height="80px" ImageUrl='<%# Eval("Pic2") %>'
                                        Width="" />
                                </td>
                                <td style="width: 25%">
                                    <span style="font-size: 20px">Rs.</span>
                                    <asp:Label ID="lblRent" runat="server" Font-Size="20px" Text='<%# Eval("Rent") %>'></asp:Label>
                                    &nbsp;per month<br />
                                    <br />
                                    <asp:Label ID="lblInterests" runat="server" Font-Bold="True" Text='<%# Eval("Interests") %>'></asp:Label>
                                    &nbsp;Interests<br />
                                    <br />
                                    <br />
                                    Status:
                                    <asp:Label ID="lblStatus" runat="server" Font-Bold="True" ForeColor="#009900" Text='<%# Eval("Status") %>'></asp:Label>
                                    <br />
                                    Expiry Date:
                                    <asp:Label ID="lblExpiry" runat="server" Font-Bold="True" Text='<%# Eval("ExpiryDate", "{0:d}") %>'></asp:Label>
                                    <br />
                                </td>
                                <td style="text-align: center">
                                    <asp:Button ID="btnReactivate" runat="server" CommandName="reactivatePG" CommandArgument='<%# Eval("ID") %>'
                                        Text="Reactivate" SkinID="green" />
                                    <asp:Button ID="btnDeactivate" runat="server" CommandName="deactivatePG" CommandArgument='<%# Eval("ID") %>'
                                        Text="Deactivate" SkinID="del" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br />
            </ItemTemplate>
            <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSourceRenew" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
            SelectCommand="SELECT * FROM [PG] WHERE (([OwnerID] = @OwnerID) AND ([ExpiryDate] &lt;&gt; @Exp))">
            <SelectParameters>
                <asp:SessionParameter Name="OwnerID" SessionField="ownerid" Type="String" />
                <asp:Parameter DefaultValue="1900-01-01" Name="Exp" DbType="Date" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <br />
    <br />
    <br />
</asp:Content>
