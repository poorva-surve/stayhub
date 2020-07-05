<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite2.master" AutoEventWireup="true"
    CodeFile="AdFeedback.aspx.cs" Inherits="Default2" %>

<asp:Content ID="viewFB" ContentPlaceHolderID="ContentPage" runat="Server">
<br /><br />
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
    <div id="feedback" align="center" style="margin: auto; width: 80%">
        <p style="font-size: 2em" align="center">
            Feedbacks
        </p>
        <hr width="5%" style=" background-color: #f66400; color: #f66400;" size="2" />
        <br />
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            CellPadding="20" GridLines="None" DataSourceID="SqlDataSource1">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" NullDisplayText="Anonymous" >
                <ItemStyle Width="30%" Font-Bold="True" />
                </asp:BoundField>
                <asp:BoundField DataField="Feed" HeaderText="Feedback">
                <ItemStyle Width="40%" />
                </asp:BoundField>
                <asp:BoundField DataField="Timestamp" HeaderText="Date/Time" 
                    SortExpression="Timestamp" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" >
                    <ItemStyle Width="30%"  />
                    
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

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>" 
            SelectCommand="SELECT * FROM [Feedback] ORDER BY [Timestamp] DESC">
        </asp:SqlDataSource>
        <br /><br /><br />
    </div>
    </div>
</asp:Content>
