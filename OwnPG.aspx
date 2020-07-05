<%@ Page Title="" Language="C#" MasterPageFile="~/OwnerSite2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="OwnPG.aspx.cs" Inherits="_Default" %>
    
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="ownerPG" ContentPlaceHolderID="ContentPage" runat="Server">
<style>
    html
    {
        overflow-x: visible;
    }
</style>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br /><br />
    <div id="allPG" style="margin: auto; width: 80%">
        <p style="font-size: 36px" align="center">
            My PG Homes
        </p>
        <hr width="10%" style=" background-color: #f66400; color: #f66400;" size="2" />
        <br />
        <br />
        <br />
        <asp:DataList ID="DataList1" runat="server" DataKeyField="ID" Style="font-family: Arial, Helvetica, sans-serif;
            text-align: justify;" Width="100%" ForeColor="#333333" OnItemCommand="DataList1_ItemCommand"
            DataSourceID="SqlDataSourceMyPG" onprerender="DataList1_PreRender">
            <AlternatingItemStyle BackColor="#FDFDFD" />
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <ItemTemplate>
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
                            <asp:Button ID="btnView" runat="server" CommandName="viewFull" CommandArgument='<%# Eval("ID") %>'
                                Text="View" SkinID="green" />
                        </td>
                        <td style="text-align: center">
                            <asp:Button ID="btnDelete" runat="server" CommandName="deletePG" CommandArgument='<%# Eval("ID") %>'
                                Text="Delete" SkinID="del" />
                            <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnDelete" ConfirmText="All details of this PG will be permanently deleted. Are you sure to continue?" />
                            
                        </td>
                    </tr>
                </table>
                <br />
            </ItemTemplate>
            <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSourceMyPG" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
            SelectCommand="SELECT * FROM [PG] WHERE ([OwnerID] = @OwnerID)">
            <SelectParameters>
                <asp:SessionParameter Name="OwnerID" SessionField="ownerid" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
    </div>
</asp:Content>
