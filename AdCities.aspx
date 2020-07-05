<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="AdCities.aspx.cs" Inherits="_Default" %>

<asp:Content ID="adminCities" ContentPlaceHolderID="ContentPage" runat="Server">
<style>
        
        @media screen and (max-width: 600px)
        {
            html
            {
                overflow-x: visible;
            }
        }
    </style>
<br /><br />
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div id="viewCities" style="margin: auto; text-align: center;">
                <asp:Panel ID="Panel1" runat="server" DefaultButton="ButtonAdd">
                    <asp:TextBox ID="txtID" placeholder="City ID" runat="server" SkinID="adm"></asp:TextBox>
                    <asp:TextBox ID="txtName" placeholder="City Name" runat="server" SkinID="adm"></asp:TextBox>
                    <asp:TextBox ID="txtImg" placeholder="City Image URL" runat="server" SkinID="adm"></asp:TextBox>
                    <br />
                    <asp:Button ID="ButtonAdd" runat="server" Text="Add New City >>" OnClick="btnAddCity_Click" />
                </asp:Panel>
                <br />
                <br />
                <asp:Label ID="addStatus" runat="server" Visible="False"></asp:Label>
                <p style="font-size: 2em" align="center">
                    Our Cities
                </p>
                <hr width="5%" style="background-color: #f66400; color: #f66400;" size="2" />
                <br />
                <br />
                <asp:SqlDataSource ID="SqlDataSourceCities" runat="server" ConflictDetection="CompareAllValues"
                    ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>" DeleteCommand="DELETE FROM [Cities] WHERE [CityID] = @original_CityID AND [CityName] = @original_CityName AND [CityImg] = @original_CityImg"
                    InsertCommand="INSERT INTO [Cities] ([CityID], [CityName], [CityImg]) VALUES (@CityID, @CityName, @CityImg)"
                    OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Cities]"
                    UpdateCommand="UPDATE [Cities] SET [CityName] = @CityName, [CityImg] = @CityImg WHERE [CityID] = @original_CityID AND [CityName] = @original_CityName AND [CityImg] = @original_CityImg">
                    <DeleteParameters>
                        <asp:Parameter Name="original_CityID" Type="String" />
                        <asp:Parameter Name="original_CityName" Type="String" />
                        <asp:Parameter Name="original_CityImg" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="CityID" Type="String" />
                        <asp:Parameter Name="CityName" Type="String" />
                        <asp:Parameter Name="CityImg" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="CityName" Type="String" />
                        <asp:Parameter Name="CityImg" Type="String" />
                        <asp:Parameter Name="original_CityID" Type="String" />
                        <asp:Parameter Name="original_CityName" Type="String" />
                        <asp:Parameter Name="original_CityImg" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <br />
                <asp:GridView ID="GridViewCities" runat="server" CellPadding="20" ForeColor="#333333"
                    GridLines="None" Style="text-align: center; margin: auto;" AutoGenerateColumns="False"
                    DataSourceID="SqlDataSourceCities" ShowHeader="False" DataKeyNames="CityID">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="CityID" HeaderText="CityID" SortExpression="CityID" ReadOnly="True" />
                        <asp:BoundField DataField="CityName" HeaderText="CityName" SortExpression="CityName" />
                        <asp:ImageField DataImageUrlField="CityImg" />
                        <asp:CommandField ShowEditButton="True">
                            <ItemStyle ForeColor="Green" Font-Bold="True" />
                        </asp:CommandField>
                        <asp:CommandField runat="server" DeleteText="Remove" ShowDeleteButton="True">
                            <ItemStyle ForeColor="Red" Font-Bold="True" />
                        </asp:CommandField>
                        <%--<asp:ImageField ImageURL="CityImg" HeaderText="CityImg" SortExpression="CityImg" />--%>
                        <%--<asp:TemplateField>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("CityImg") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("CityImg") %>' />
                    </ItemTemplate>
                    <FooterTemplate>  
                        <asp:Button ID="ButtonAdd" runat="server" Text="Add New City >>" onclick="btnAddCity_Click" />  
                    </FooterTemplate>
                </asp:TemplateField>  --%>
                    </Columns>
                    <FooterStyle HorizontalAlign="Right" BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <SortedAscendingCellStyle BackColor="#FDF5AC" />
                    <SortedAscendingHeaderStyle BackColor="#4D0000" />
                    <SortedDescendingCellStyle BackColor="#FCF6C0" />
                    <SortedDescendingHeaderStyle BackColor="#820000" />
                </asp:GridView>
                <br />
                <br />
                <br />
            </div>
    </div>
</asp:Content>
