<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true"
    CodeFile="SeekSchedule.aspx.cs" Inherits="Default2" %>

<asp:Content ID="seekerSched" ContentPlaceHolderID="ContentPage" runat="Server">
    <style>
        @media screen and (min-width: 601px)
        {
            #viewPG
            {
                margin: auto;
                width: 80%;
            }
        }
        @media screen and (max-width: 600px)
        {
            html
            {
                overflow-x: visible;
            }
            #viewPG
            {
                width: 100%;
            }
        }
    </style>
    <br />
    <br />
    <div id="viewPG">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <p style="font-size: 2em" align="center">
            PG Visit Schedule
        </p>
        <hr width="10%" style="background-color: #f66400; color: #f66400;" size="2" />
        <br />
        <br />
        <br />
        <p style="font-size: 1.5em" align="center">
            Upcoming Visits
        </p>
        <p runat="server" id="upcomingStatus" style="display: none; text-align: center">
            <asp:Label ID="lblNoUpcoming" runat="server" Text="No visits scheduled"></asp:Label>
        </p>
        <asp:GridView ID="GridViewSchedule" runat="server" AutoGenerateColumns="False" CellPadding="20"
            DataSourceID="SqlDataSourceVisits" ForeColor="#333333" GridLines="None" OnPreRender="GridViewSchedule_PreRender">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="PG Name" SortExpression="Name">
                    <ItemStyle Width="25%" />
                </asp:BoundField>
                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
                <asp:BoundField DataField="OwnerName" HeaderText="Owner" SortExpression="OwnerName">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="Mobile" HeaderText="Contact" SortExpression="Mobile">
                    <ItemStyle Width="10%" />
                </asp:BoundField>
                <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM, yyyy}" HeaderText="Visit Date"
                    SortExpression="VisitDate" NullDisplayText="Not Set" ReadOnly="True">
                    <ItemStyle Width="15%" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <SortedAscendingCellStyle BackColor="#FDF5AC" />
            <SortedAscendingHeaderStyle BackColor="#4D0000" />
            <SortedDescendingCellStyle BackColor="#FCF6C0" />
            <SortedDescendingHeaderStyle BackColor="#820000" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceVisits" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
            SelectCommand="SELECT SiteVisits.PID, SiteVisits.SID, SiteVisits.OID, SiteVisits.VisitDate, PG.Name, PG.Address, Users.Name AS OwnerName, Users.Mobile FROM Users INNER JOIN PG ON Users.ID = PG.OwnerID INNER JOIN SiteVisits ON SiteVisits.PID = PG.ID WHERE (SiteVisits.SID = @sid and SiteVisits.VisitDate >= @today)">
            <SelectParameters>
                <asp:SessionParameter Name="SID" SessionField="userid" Type="String" />
                <asp:Parameter Name="today" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <p style="font-size: 1.5em" align="center">
            Pending Visits
        </p>
        <p runat="server" id="pendingStatus" style="display: none; text-align: center">
            <asp:Label ID="lblNoPending" runat="server" Text="No pending visits"></asp:Label>
        </p>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridViewPending" runat="server" AutoGenerateColumns="False" CellPadding="20"
                    DataSourceID="SqlDataSourcePendingVisits" ForeColor="#333333" GridLines="None"
                    OnRowDeleting="GridViewPending_RowDeleting" OnPreRender="GridViewPending_PreRender">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="PG Name" SortExpression="Name">
                            <ItemStyle Width="25%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address">
                            <ItemStyle Width="30%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OwnerName" HeaderText="Owner" SortExpression="OwnerName">
                            <ItemStyle Width="20%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Mobile" HeaderText="Contact" SortExpression="Mobile">
                            <ItemStyle Width="10%" />
                        </asp:BoundField>
                        <asp:CommandField ButtonType="Button" DeleteText="Cancel Visit" EditText="" InsertText=""
                            NewText="" SelectText="" ShowDeleteButton="True" UpdateText="">
                            <ControlStyle BackColor="#CC0000" BorderStyle="None" Font-Bold="True" ForeColor="White" />
                        </asp:CommandField>
                    </Columns>
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <SortedAscendingCellStyle BackColor="#FDF5AC" />
                    <SortedAscendingHeaderStyle BackColor="#4D0000" />
                    <SortedDescendingCellStyle BackColor="#FCF6C0" />
                    <SortedDescendingHeaderStyle BackColor="#820000" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:SqlDataSource ID="SqlDataSourcePendingVisits" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
            SelectCommand="SELECT SiteVisits.PID, SiteVisits.SID, SiteVisits.OID, SiteVisits.VisitDate, PG.Name, PG.Address, Users.Name AS OwnerName, Users.Mobile FROM Users INNER JOIN PG ON Users.ID = PG.OwnerID INNER JOIN SiteVisits ON SiteVisits.PID = PG.ID WHERE (SiteVisits.SID = @sid and SiteVisits.VisitDate is null)"
            DeleteCommand="DELETE FROM SiteVisits WHERE (SID = @SID and PID = @PID and VisitDate is null)">
            <SelectParameters>
                <asp:SessionParameter Name="SID" SessionField="userid" Type="String" />
            </SelectParameters>
            <DeleteParameters>
                <asp:SessionParameter Name="SID" SessionField="userid" Type="String" />
                <asp:Parameter Name="PID" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <p style="font-size: 1.5em" align="center">
            Visits in the past
        </p>
        <p runat="server" id="pastStatus" style="display: none; text-align: center">
            <asp:Label ID="lblNoPast" runat="server" Text="No records found"></asp:Label>
        </p>
        <asp:GridView ID="GridViewPast" runat="server" AutoGenerateColumns="False" CellPadding="20"
            DataSourceID="SqlDataSourcePast" ForeColor="#333333" GridLines="None" AllowSorting="true"
            OnPreRender="GridViewPast_PreRender">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="PG Name" SortExpression="Name">
                    <ItemStyle Width="25%" />
                </asp:BoundField>
                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
                <asp:BoundField DataField="OwnerName" HeaderText="Owner" SortExpression="OwnerName">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="Mobile" HeaderText="Contact" SortExpression="Mobile">
                    <ItemStyle Width="10%" />
                </asp:BoundField>
                <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM, yyyy}" HeaderText="Visit Date"
                    SortExpression="VisitDate" ReadOnly="True">
                    <ItemStyle Width="15%" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <SortedAscendingCellStyle BackColor="#FDF5AC" />
            <SortedAscendingHeaderStyle BackColor="#4D0000" />
            <SortedDescendingCellStyle BackColor="#FCF6C0" />
            <SortedDescendingHeaderStyle BackColor="#820000" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourcePast" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
            SelectCommand="SELECT SiteVisits.PID, SiteVisits.SID, SiteVisits.OID, SiteVisits.VisitDate, PG.Name, PG.Address, Users.Name AS OwnerName, Users.Mobile FROM Users INNER JOIN PG ON Users.ID = PG.OwnerID INNER JOIN SiteVisits ON SiteVisits.PID = PG.ID WHERE (SiteVisits.SID = @sid and SiteVisits.VisitDate < @today)">
            <SelectParameters>
                <asp:SessionParameter Name="SID" SessionField="userid" Type="String" />
                <asp:Parameter Name="today" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
    </div>
</asp:Content>
