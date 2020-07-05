<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite2.master" AutoEventWireup="true"
    CodeFile="AdMembers.aspx.cs" Inherits="_Default" %>

<asp:Content ID="adminMembers" ContentPlaceHolderID="ContentPage" runat="Server">
<style>
    html
    {
        overflow-x: visible;   
    }
</style>
<br /><br />
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
    <div id="viewMembers" style="margin: auto;">
        <p style="font-size: 36px" align="center">
            Our Members
        </p>
        <hr width="5%" style="background-color: #f66400; color: #f66400;" size="2" />
        <br />
        <br />
        <asp:GridView ID="GridViewMembers" runat="server" CellPadding="20" GridLines="None"
            Style="text-align: center; margin: auto;" AutoGenerateColumns="False" DataKeyNames="ID"
            DataSourceID="SqlDataSourceMembers" AllowPaging="True" AllowSorting="True" OnRowDeleting="GridViewMembers_RowDeleting">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
                <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                <asp:BoundField DataField="TenantType" HeaderText="Occupation" SortExpression="TenantType" />
                <asp:BoundField DataField="DOB" HeaderText="DOB" SortExpression="DOB" />
                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:CommandField ShowDeleteButton="True" ButtonType="Button" ControlStyle-BackColor="#CC0000" ControlStyle-ForeColor="White" ControlStyle-BorderStyle="Outset" ControlStyle-BorderColor="#CC0000">
                    
                </asp:CommandField>
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" Font-Bold="True"
                Font-Overline="False" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <SortedAscendingCellStyle BackColor="#FDF5AC" />
            <SortedAscendingHeaderStyle BackColor="#4D0000" />
            <SortedDescendingCellStyle BackColor="#FCF6C0" />
            <SortedDescendingHeaderStyle BackColor="#820000" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceMembers" runat="server" ConflictDetection="CompareAllValues"
            ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>" DeleteCommand="DELETE FROM [Users] WHERE [ID] = @original_ID "
            OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Users]">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="String" />
            </DeleteParameters>
        </asp:SqlDataSource>
    </div>
    <br />
    <br />
    <br />
    <br />
    <br />
    </div>
</asp:Content>
