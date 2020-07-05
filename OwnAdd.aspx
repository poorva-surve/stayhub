<%@ Page Title="" Language="C#" MasterPageFile="~/OwnerSite2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="OwnAdd.aspx.cs" Inherits="_Default" %>

<asp:Content ID="ownerAddPG" ContentPlaceHolderID="ContentPage" runat="Server">
    <script type="text/javascript">
        function ValidateCheckBoxList(sender, args) {
            var checkBoxList = document.getElementById("<%=chkOccupancy.ClientID %>");
            var checkboxes = checkBoxList.getElementsByTagName("input");
            var isValid = false;
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    isValid = true;
                    break;
                }
            }
            args.IsValid = isValid;
        }
    </script>
    
    <style>
        @media screen and (min-width: 601px)
        {
            #addPG
            {
                width: 50%;
            }
            #addPG .amenitiesList
            {
                text-align: justify;
                width: 50%;
            }
        }
        @media screen and (max-width: 600px)
        {
            #addPG
            {
                width: 80%;
            }
            #addPG .amenitiesList
            {
                text-align: justify;
                width: 100%;
            }
        }
        #addPG .fieldLabels
        {
            font-size: 1em;
            padding: 0;
            margin: 0;
        }
    </style>
    <br />
    <br />
    <div id="addPG" style="margin: auto;">
        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnAdd">
            <p style="font-size: 2em" align="center">
                Add New PG
            </p>
            <hr width="10%" style="background-color: #f66400; color: #f66400;" size="2" />
            <br />
            <br />
            <center>
                <asp:Label ID="lblAddStatus" runat="server" Font-Size="1.2em" Font-Names="Arial"></asp:Label>
            </center>
            <br />
            <div id="form" class=" container">
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Apartment Name
                    </p>
                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ForeColor="Red" ID="RequiredFieldValidator1" runat="server"
                        Text="*" ErrorMessage="Please enter apartment name" SetFocusOnError ControlToValidate="txtName"
                        ValidationGroup="save"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator1"
                        runat="server" ControlToValidate="txtName" Text="*" ErrorMessage="Apartment Name is not valid"
                        ValidationExpression="([A-Za-z]*[\sA-Za-z.']*)" ValidationGroup="save"></asp:RegularExpressionValidator>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Address
                    </p>
                    <asp:TextBox ID="txtAddr" runat="server" TextMode="MultiLine" Columns="30" Rows="3"
                        SkinID="none"></asp:TextBox>
                    <asp:RequiredFieldValidator ForeColor="Red" ID="RequiredFieldValidator3" runat="server"
                        Text="*" ErrorMessage="Please enter apartment address" SetFocusOnError ControlToValidate="txtAddr"
                        ValidationGroup="save"></asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Select City
                    </p>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlCity" EventName="SelectedIndexChanged" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlCity" runat="server" Font-Size="1em" Height="2.5em" Width="15em"
                                AutoPostBack="True">
                                <asp:ListItem Value="">--Select City--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ForeColor="Red" ID="RequiredFieldValidator2" runat="server"
                                Text="*" ErrorMessage="Please select a city" SetFocusOnError ControlToValidate="ddlCity"
                                ValidationGroup="save"></asp:RequiredFieldValidator>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Occupancy
                        <br />
                        <span class="fieldLabels col-lg-4 col-xs-12">(Select all those applicable) </span>
                    </p>
                    <asp:CheckBoxList ID="chkOccupancy" runat="server">
                        <asp:ListItem Value="Boys">&nbsp;Boys</asp:ListItem>
                        <asp:ListItem Value="Girls">&nbsp;Girls</asp:ListItem>
                        <asp:ListItem Value="Students">&nbsp;Students</asp:ListItem>
                        <asp:ListItem Value="Professionals">&nbsp;Professionals</asp:ListItem>
                        <asp:ListItem Value="Couples">&nbsp;Married Couples</asp:ListItem>
                    </asp:CheckBoxList>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" Text="*" ErrorMessage="Please select at least one occupancy"
                        ForeColor="Red" ClientValidationFunction="ValidateCheckBoxList" ValidationGroup="save"
                        SetFocusOnError />
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Rent per person
                    </p>
                    Rs.&nbsp;
                    <asp:TextBox ID="txtRent" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ForeColor="Red" ID="RequiredFieldValidator4" runat="server"
                        Text="*" ErrorMessage="Please enter rent amount" SetFocusOnError ControlToValidate="txtRent"
                        ValidationGroup="save"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ForeColor="Red" ID="RegularExpressionValidator2"
                        runat="server" ControlToValidate="txtRent" Text="*" ErrorMessage="Please enter only numeric value for rent"
                        ValidationExpression="\d*" ValidationGroup="save"></asp:RegularExpressionValidator>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Photos<br />
                        <span class="fieldLabels col-lg-4 col-xs-12">(max size 2 MB)</span>
                    </p>
                    <div>
                        <br />
                        <asp:FileUpload ID="FilePic1" runat="server" />
                        <br />
                        <asp:Label ID="pic1Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <br />
                        <asp:FileUpload ID="FilePic2" runat="server" /><br />
                        <asp:Label ID="pic2Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <br />
                        <asp:FileUpload ID="FilePic3" runat="server" /><br />
                        <asp:Label ID="pic3Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <br />
                        <asp:FileUpload ID="FilePic4" runat="server" /><br />
                        <asp:Label ID="pic4Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <br />
                        <asp:FileUpload ID="FilePic5" runat="server" /><br />
                        <asp:Label ID="pic5Validation" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <br />
                    </div>
                    <br />
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Fully Furnished
                    </p>
                    <asp:RadioButtonList ID="rdFurnished" RepeatDirection="Horizontal" runat="server"
                        CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Yes</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;No</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Meals
                    </p>
                    <asp:RadioButtonList ID="rdMealsProvision" RepeatDirection="Horizontal" runat="server"
                        CssClass="amenitiesList">
                        <asp:ListItem Value="Provided" Selected>&nbsp;Provided</asp:ListItem>
                        <asp:ListItem Value="Not Provided">&nbsp;Not Provided</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Non-Veg
                    </p>
                    <asp:RadioButtonList ID="rdNonvegAllowance" RepeatDirection="Horizontal" runat="server"
                        CssClass="amenitiesList">
                        <asp:ListItem Value="Allowed" Selected>&nbsp;Allowed</asp:ListItem>
                        <asp:ListItem Value="Not Allowed">&nbsp;Not Allowed</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Cooking Stove
                    </p>
                    <asp:RadioButtonList ID="rdGas" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Electricity
                    </p>
                    <asp:RadioButtonList ID="rdElec" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; AC
                    </p>
                    <asp:RadioButtonList ID="rdAc" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; TV
                    </p>
                    <asp:RadioButtonList ID="rdTv" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; WiFi
                    </p>
                    <asp:RadioButtonList ID="rdWifi" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Laundry
                    </p>
                    <asp:RadioButtonList ID="rdWashing" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Geyser
                    </p>
                    <asp:RadioButtonList ID="rdGeyser" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Refrigerator
                    </p>
                    <asp:RadioButtonList ID="rdFridge" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Study Table
                    </p>
                    <asp:RadioButtonList ID="rdTable" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Balcony
                    </p>
                    <asp:RadioButtonList ID="rdBalcony" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Parking
                    </p>
                    <asp:RadioButtonList ID="rdParking" RepeatDirection="Horizontal" runat="server" CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        &nbsp; Security
                    </p>
                    <asp:RadioButtonList ID="rdSecurity" RepeatDirection="Horizontal" runat="server"
                        CssClass="amenitiesList">
                        <asp:ListItem Value="Yes" Selected>&nbsp;Available</asp:ListItem>
                        <asp:ListItem Value="No">&nbsp;Not Available</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <br />
            </div>
            <br />
            <br />
            <center>
                <asp:Button ID="btnAdd" runat="server" Text="Submit PG" OnClick="btnAdd_Click" ValidationGroup="save" />
                <br />
            </center>
            <br />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList"
                ForeColor="Red" HeaderText=" Oops! We've found some problems... " BackColor="WhiteSmoke"
                Font-Italic="True" ValidationGroup="save" />
        </asp:Panel>
    </div>
</asp:Content>
