<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true"
    CodeFile="SearchPG.aspx.cs" Inherits="_Default" %>

<asp:Content ID="searchContent" ContentPlaceHolderID="ContentPage" runat="Server">
<br /><br />

        <div class="container">
        <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
    <div id="allPG" style="margin: auto; width: 100%">
        <p style="font-size: 2em" align="center">
            Select City
        </p>
        <hr width="5%" style=" background-color: #f66400; color: #f66400;" size="2" />
        <br />
        <br />
        <br />
        <asp:DataList ID="DataListCities" runat="server" Style="font-family:  Verdana,Arial, sans-serif;
            text-align: center;" DataSourceID="SqlDataSourceCities" Width="100%" ForeColor="#333333"
            RepeatColumns="3" RepeatDirection="Horizontal" 
            onitemcommand="DataListCities_ItemCommand">
            <ItemTemplate>
                <asp:ImageButton ID="imgCity" runat="server" ImageAlign="Middle" Width="90%"
                    ImageUrl='<%# Eval("CityImg") %>' 
                    CommandArgument='<%# Eval("CityName") %>' CommandName="cityName"/>
                <br />
                <br />
                <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityName") %>' Font-Size="1em"></asp:Label>
                <br />
                <br />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        </div>
        </div>
        </div>
        </div>
        <asp:SqlDataSource ID="SqlDataSourceCities" runat="server" ConnectionString="<%$ ConnectionStrings:StayHubDBConnection %>"
            SelectCommand="SELECT [CityName], [CityImg] FROM [Cities]"></asp:SqlDataSource>
</asp:Content>
