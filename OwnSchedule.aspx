<%@ Page Title="" Language="C#" MasterPageFile="~/OwnerSite2.master" Theme="Theme"
    AutoEventWireup="true" CodeFile="OwnSchedule.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="scheduleContent" ContentPlaceHolderID="ContentPage" runat="Server">
<style>
    .mymodal
        {
            position: fixed;
            z-index: 999;
            height: 100vh;
            width: 100vw;
            top: 0;
            left:0;
            background-color: white;
            opacity: 0.7;
        }
        .mycenter
        {
            z-index: 1000;
            margin: 40vh auto;
            text-align:center;
            width: 8em;
            opacity: 1;
            height: 100vh;
        }
        .mycenter img
        {
            height: 5em;
            width: 5em;
        }
    </style>
</style>
    <br />
    <br />
    <br />
    <div id="sched" style="margin: auto; width: 80%">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <p style="font-size: 36px" align="center">
            PG Visit Schedule
        </p>
        <hr width="10%" style="background-color: #f66400; color: #f66400;" size="2" />
        <br />
        <br />
        <br />
        <p style="font-size: 1.5em" align="center">
            Pending Approvals
        </p>
        <p runat="server" id="pendingDL" style="display: none; text-align: center">
            <asp:Label ID="lblNoPending" runat="server" Text="No visits requested"></asp:Label>
        </p>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
            <ProgressTemplate>
                <div class="mymodal">
                    <div class="mycenter">
                        <img src="preloader.gif" alt="Please wait" />
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSourceVisits" Style="font-family: Arial, Helvetica, sans-serif;
                    text-align: justify;" Width="100%" ForeColor="#333333" OnItemCommand="DataList1_ItemCommand"
                    OnPreRender="DataList1_PreRender">
                    <AlternatingItemStyle BackColor="#FDFDFD" />
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <ItemTemplate>
                        <table cellspacing="0" style="width: 100%" cellpadding="15">
                            <tr>
                                <td style="width: 35%" valign="top">
                                    <asp:Label ID="lblPGID" runat="server" Text='<%# Eval("PID") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="lblName" runat="server" Font-Bold="True" Font-Size="20px" Text='<%# Eval("Name") %>'></asp:Label>
                                    &nbsp;
                                    <br />
                                    <br />
                                    <br />
                                    <asp:Label ID="lblAddr" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                </td>
                                <td style="width: 25%" valign="top">
                                    <asp:Label ID="lblSeekID" runat="server" Text='<%# Eval("SID") %>' Visible="False"></asp:Label>
                                    Seeker:
                                    <asp:Label ID="lblSeeker" runat="server" Font-Italic="True" Text='<%# Eval("SeekerName") %>'></asp:Label>
                                    <br />
                                    <br />
                                    Contact:<br />
                                    <asp:Label ID="lblContact" runat="server" Font-Size="20px" Text='<%# Eval("Mobile") %>'></asp:Label>
                                    &nbsp;
                                </td>
                                <td style="text-align: center" valign="middle">
                                    <asp:TextBox ID="txtDate" runat="server" autocomplete="off" placeholder="Set Visit Date"
                                        Text='<%# Eval("VisitDate", "{0:d}") %>' SkinID="adm"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                        ForeColor="Red" Visible="false" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*"
                                        ForeColor="Red" ControlToValidate="txtDate" ValidationExpression="\d{2}\s[A-Z][a-z][a-z],\s\d{4}"
                                        SetFocusOnError="True"></asp:RegularExpressionValidator>
                                    <br />
                                    <%--<asp:Label ID="lblDate" runat="server" Text="Set Visit Date" BackColor="White" BorderStyle="Solid" BorderColor="Black" Height="2.5em" BorderWidth="1px" Width="50%" Font-Size="1em"></asp:Label>--%>
                                    <%--<asp:ImageButton ID="ImageButton1" runat="server" 
                                ImageUrl="~/Images/calendar.png" Width="30px" />--%>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDate"
                                        EndDate="12/31/2020" StartDate="1/1/2020" Format="dd MMM, yyyy" />
                                    <br />
                                    <br />
                                    <asp:Button ID="btnConfirm" runat="server" Text="Confirm" CommandName="confirmVisit"
                                        SkinID="green" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Button ID="btnDelete" runat="server" Text="Discard" CommandName="deleteReq"
                                        SkinID="del" CausesValidation="False" />
                                    <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnDelete"
                                        ConfirmText="1 PG visit request will be permanently deleted. Do you want to continue?" />
                                </td>
                            </tr>
                        </table>
                        <br />
                    </ItemTemplate>
                    <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                </asp:DataList>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:SqlDataSource ID="SqlDataSourceVisits" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
            SelectCommand="SELECT SiteVisits.PID, SiteVisits.SID, SiteVisits.OID, SiteVisits.VisitDate, PG.Name, PG.Address, Users.Name AS SeekerName, Users.Mobile FROM PG INNER JOIN SiteVisits ON PG.ID = SiteVisits.PID INNER JOIN Users ON SiteVisits.SID = Users.ID WHERE (SiteVisits.OID = @oid and SiteVisits.VisitDate is null)">
            <SelectParameters>
                <asp:SessionParameter Name="oid" SessionField="ownerid" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <p style="font-size: 1.5em" align="center">
            Confirmed Upcoming Visits
        </p>
        <p runat="server" id="confirmedDL" style="display: none; text-align: center">
            <asp:Label ID="lblNoConfirmed" runat="server" Text="No visits scheduled"></asp:Label>
        </p>
        <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource1" Style="font-family: Arial, Helvetica, sans-serif;"
            Width="100%" ForeColor="#333333" OnPreRender="DataList2_PreRender">
            <AlternatingItemStyle BackColor="#FDFDFD" />
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <ItemTemplate>
                <table cellspacing="20" style="width: 100%" cellpadding="15">
                    <tr>
                        <td valign="middle">
                            <asp:Label ID="lblPGID2" runat="server" Text='<%# Eval("PID") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lblName2" runat="server" Font-Bold="True" Font-Size="20px" Text='<%# Eval("Name") %>'></asp:Label>
                            &nbsp;
                            <br />
                            <br />
                            <br />
                            <asp:Label ID="lblAddr2" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                        </td>
                        <td valign="middle">
                            <br />
                            <asp:Label ID="lblSeekID2" runat="server" Text='<%# Eval("SID") %>' Visible="False"></asp:Label>
                            Seeker:
                            <asp:Label ID="lblSeeker2" runat="server" Font-Italic="True" Text='<%# Eval("SeekerName") %>'></asp:Label>
                            <br />
                            <br />
                            Contact:
                            <asp:Label ID="lblContact2" runat="server" Font-Size="1.2em" Text='<%# Eval("Mobile") %>'></asp:Label>
                            <br />
                            <br />
                            &nbsp;Visit Date:
                            <asp:Label ID="lblDate2" runat="server" Font-Size="1.2em" Text='<%# Eval("VisitDate", "{0:dd MMM, yyyy}") %>'></asp:Label>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
            SelectCommand="SELECT SiteVisits.PID, SiteVisits.SID, SiteVisits.OID, SiteVisits.VisitDate, PG.Name, PG.Address, Users.Name AS SeekerName, Users.Mobile FROM PG INNER JOIN SiteVisits ON PG.ID = SiteVisits.PID INNER JOIN Users ON SiteVisits.SID = Users.ID WHERE (SiteVisits.OID = @oid and SiteVisits.VisitDate >= @today)">
            <SelectParameters>
                <asp:SessionParameter Name="oid" SessionField="ownerid" />
                <asp:Parameter Name="today" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <p style="font-size: 1.5em" align="center">
            Visits History
        </p>
        <p runat="server" id="pastDL" style="display: none; text-align: center">
            <asp:Label ID="lblNoPast" runat="server" Text="No records found"></asp:Label>
        </p>
        <asp:DataList ID="DataList3" runat="server" DataSourceID="SqlDataSourcePast" Style="font-family: Arial, Helvetica, sans-serif;"
            Width="100%" ForeColor="#333333" OnPreRender="DataList3_PreRender">
            <AlternatingItemStyle BackColor="#FDFDFD" />
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <ItemTemplate>
                <table cellspacing="20" style="width: 100%" cellpadding="15">
                    <tr>
                        <td valign="middle">
                            <asp:Label ID="lblPGID3" runat="server" Text='<%# Eval("PID") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lblName3" runat="server" Font-Bold="True" Font-Size="20px" Text='<%# Eval("Name") %>'></asp:Label>
                            &nbsp;
                            <br />
                            <br />
                            <br />
                            <asp:Label ID="lblAddr3" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                        </td>
                        <td valign="middle">
                            <br />
                            <asp:Label ID="lblSeekID3" runat="server" Text='<%# Eval("SID") %>' Visible="False"></asp:Label>
                            Seeker:
                            <asp:Label ID="lblSeeker3" runat="server" Font-Italic="True" Text='<%# Eval("SeekerName") %>'></asp:Label>
                            <br />
                            <br />
                            Contact:
                            <asp:Label ID="lblContact3" runat="server" Font-Size="1.2em" Text='<%# Eval("Mobile") %>'></asp:Label>
                            <br />
                            <br />
                            &nbsp;Visit Date:
                            <asp:Label ID="lblDate3" runat="server" Font-Size="1.2em" Text='<%# Eval("VisitDate", "{0:dd MMM, yyyy}") %>'></asp:Label>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSourcePast" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
            SelectCommand="SELECT SiteVisits.PID, SiteVisits.SID, SiteVisits.OID, SiteVisits.VisitDate, PG.Name, PG.Address, Users.Name AS SeekerName, Users.Mobile FROM PG INNER JOIN SiteVisits ON PG.ID = SiteVisits.PID INNER JOIN Users ON SiteVisits.SID = Users.ID WHERE (SiteVisits.OID = @oid and SiteVisits.VisitDate < @today)">
            <SelectParameters>
                <asp:SessionParameter Name="oid" SessionField="ownerid" />
                <asp:Parameter Name="today" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
    </div>
    <br />
    <br />
    <br />
</asp:Content>
