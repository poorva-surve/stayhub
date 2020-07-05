<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true"
    Theme="Theme" CodeFile="Register.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="registerContent" ContentPlaceHolderID="ContentPage" runat="Server">
    <script type="text/javascript">
        function ValidateDOB(sender, args) {
            var isValid = false;
            var txtDOB = document.getElementById("<%=txtDOB.ClientID %>");
            var dt = txtDOB.value;
            var day = dt.substr(0, 2);
            var month = dt.substr(3, 2);
            var year = dt.substr(6, 4);
            if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1940 || year > 2001)
                isValid = false;

            switch (month) {
                case "04":
                case "06":
                case "09":
                case "11":
                    if (day > 30) {
                        isValid = false;
                    }
                    else
                        isValid =  true;
                    break;

                case "02":
                    if (day > 29) {
                        isValid = false;
                        break;
                    }
                    if (!((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) && day > 28) {
                        isValid = false;
                        break;
                    }
                    else
                        isValid = true;
                    break;

                default:

                    isValid = true;
                    break;

            }
            args.IsValid = isValid;

        }
        
    </script>
    <br />
    <br />
    <style>
        @media screen and (min-width: 601px)
        {
            #registerForm
            {
                width: 50%;
            }
        }
        @media screen and (max-width: 600px)
        {
            #registerForm
            {
                width: 70%;
            }
        }
        #registerForm .fieldLabels
        {
            padding: 0;
            margin: 0;
        }
        #form p
        {
            font-size: 1.2em;
        }
        .validator
        {
            color: Red;
        }
    </style>
    <div id="registerForm" style="margin: auto;">
        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnReg">
            <p style="font-size: 2em" align="center">
                Create your account
            </p>
            <hr width="10%" style="background-color: #f66400; color: #f66400;" size="2" />
            <br />
            <center><asp:Label ID="lblRegStatus" runat="server" ForeColor="Red" align="center"></asp:Label>
            </center><br />
            <br />
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div id="form" class=" container">
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Account Type <span style="color: Red">*</span>
                    </p>
                    <asp:RadioButtonList ID="userRole" RepeatDirection="Horizontal" runat="server" OnSelectedIndexChanged="userRole_SelectedIndexChanged"
                        AutoPostBack="True" CssClass="col-lg-8 col-xs-12">
                        <asp:ListItem Text="&nbsp; PG Seeker" Value="Seeker"></asp:ListItem>
                        <asp:ListItem Text="&nbsp; PG Owner" Value="Owner"></asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator1" runat="server"
                        ErrorMessage="This field is required" ControlToValidate="userRole" SetFocusOnError></asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Name<span style="color: Red">&nbsp;*</span>
                    </p>
                    <asp:TextBox ID="txtName" runat="server" CssClass="col-lg-8 col-xs-12"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator2" runat="server"
                        ErrorMessage="This field is required" SetFocusOnError ControlToValidate="txtName"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator CssClass="validator" ID="RegularExpressionValidator1"
                        runat="server" ControlToValidate="txtName" ErrorMessage="Name is not valid" ValidationExpression="([A-Za-z]*[\sA-Za-z]*.)"></asp:RegularExpressionValidator>
                </div>
                <br />
                <div class="row">
                    <p id="i_am" class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        I am...<span style="color: Red">&nbsp;*</span>
                    </p>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlOccupation" EventName="SelectedIndexChanged" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlOccupation" runat="server" Font-Size="1em" Height="2.5em"
                                Width="10em" AutoPostBack="True" OnSelectedIndexChanged="ddlOccupation_SelectedIndexChanged">
                                <asp:ListItem Value="">--Select--</asp:ListItem>
                                <asp:ListItem>Student</asp:ListItem>
                                <asp:ListItem>Professional</asp:ListItem>
                                <asp:ListItem Value="Other">Other</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;
                            <asp:TextBox ID="txtOcc" placeholder="Please Specify..." runat="server" SkinID="none"
                                Font-Size="1em" Height="2.5em" Width="10em" Visible="False"></asp:TextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator3" runat="server"
                        SetFocusOnError ErrorMessage="This field is required" ControlToValidate="ddlOccupation"></asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Gender<span style="color: Red">&nbsp;*</span>
                    </p>
                    <asp:RadioButtonList ID="userGender" RepeatDirection="Horizontal" runat="server"
                        CssClass="col-lg-8 col-xs-12">
                        <asp:ListItem Text="&nbsp; Male" Value="M"></asp:ListItem>
                        <asp:ListItem Text="&nbsp; Female" Value="F"></asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator4" runat="server"
                        SetFocusOnError ErrorMessage="This field is required" ControlToValidate="userGender"></asp:RequiredFieldValidator>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Date of Birth<span style="color: Red">&nbsp;*</span>
                    </p>
                    <%--<asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="imgDOB" EventName="Click" />
                        </Triggers>
                        <ContentTemplate>
                        <asp:TextBox ID="txtDOB" runat="server" placeholder="E.g. 01-01-1990" autocomplete="off"></asp:TextBox>
                        <asp:ImageButton ID="imgDOB" runat="server" ImageUrl="~/Images/calendar.png" Height="2em"
                            Width="2em" OnClick="imgDOB_Click" /><br />
                        <asp:Calendar ID="calDOB" Style="float: right" runat="server" Visible="False" BackColor="#FFFFCC"
                            BorderColor="#F66400" BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana"
                            Font-Size="8pt" ForeColor="#000000" Height="10em" Width="20em" OnSelectionChanged="calDOB_SelectionChanged"
                            SelectedDate="1990-01-01">
                            <DayHeaderStyle BackColor="#F66400" Font-Bold="True" Height="1px" ForeColor="White" />
                            <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                            <OtherMonthDayStyle ForeColor="#CC9966" />
                            <SelectedDayStyle BackColor="#F66400" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#F66400" />
                            <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                            <TodayDayStyle ForeColor="#000000" />
                        </asp:Calendar>
                            
                        </ContentTemplate>
                        </asp:UpdatePanel>--%>
                    <asp:TextBox ID="txtDOB" runat="server" placeholder="dd-mm-yyyy" autocomplete="off"
                        CssClass="col-lg-8 col-xs-12">
                        
                    </asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDOB"
                        EndDate="12/31/2001" StartDate="1/1/1940" Format="dd-MM-yyyy" />
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator5" runat="server"
                        SetFocusOnError ErrorMessage="This field is required" ControlToValidate="txtDOB"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator CssClass="validator" ID="RegularExpressionValidator4"
                        runat="server" SetFocusOnError ControlToValidate="txtDOB" ErrorMessage="DOB is not valid"
                        ValidationExpression="(\d{2}-\d{2}-\d{4})"></asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" Text="*" ErrorMessage="DOB is not valid"
                            CssClass="validator" ClientValidationFunction="ValidateDOB" ValidationGroup="save"
                            SetFocusOnError />
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        City of Residence<span style="color: Red">&nbsp;*</span>
                    </p>
                    <asp:TextBox ID="txtUsrCity" runat="server" CssClass="col-lg-8 col-xs-12"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator6" runat="server"
                        SetFocusOnError ErrorMessage="This field is required" ControlToValidate="txtUsrCity"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator CssClass="validator" ID="RegularExpressionValidator2"
                        runat="server" ControlToValidate="txtUsrCity" ErrorMessage="City name is not valid"
                        ValidationExpression="([A-Za-z]*)"></asp:RegularExpressionValidator>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Mobile No.<span style="color: Red">&nbsp;*</span>
                    </p>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="col-lg-8 col-xs-12" MaxLength="10"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator7" runat="server"
                        SetFocusOnError ErrorMessage="This field is required" ControlToValidate="txtMobile"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator CssClass="validator" ID="RegularExpressionValidator3"
                        runat="server" ControlToValidate="txtMobile" ErrorMessage="Mobile Number is not valid"
                        ValidationExpression="\d{10}"></asp:RegularExpressionValidator>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        E-mail<span style="color: Red">&nbsp;*</span>
                    </p>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="col-lg-8 col-xs-12"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator8" runat="server"
                        SetFocusOnError ErrorMessage="This field is required" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator  CssClass="validator" ID="RegularExpressionValidator5" runat="server" ErrorMessage="Email is not valid"
                        ControlToValidate="txtEmail" SetFocusOnError="True" ValidationExpression="^.+@[^\.].*\.[a-z]{2,}$"></asp:RegularExpressionValidator>
                    
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Set Password<span style="color: Red">&nbsp;*</span>
                    </p>
                    <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="col-lg-8 col-xs-12"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator9" runat="server"
                        SetFocusOnError ErrorMessage="This field is required" ControlToValidate="txtPass"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator CssClass="validator" ID="RegularExpressionValidator6" runat="server"
                     ValidationExpression="\S{6,}" SetFocusOnError  ControlToValidate="txtPass"
                     ErrorMessage="Password should be at least 6 characters long"></asp:RegularExpressionValidator>
                </div>
                <br />
                <div class="row">
                    <p class="fieldLabels col-lg-4 col-xs-12 font-weight-bold">
                        Confirm Password<span style="color: Red">&nbsp;*</span>
                    </p>
                    <asp:TextBox ID="txtCPass" runat="server" TextMode="Password" CssClass="col-lg-8 col-xs-12"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="validator" ID="RequiredFieldValidator10" runat="server"
                        SetFocusOnError ErrorMessage="This field is required" ControlToValidate="txtCPass"></asp:RequiredFieldValidator>
                    <asp:CompareValidator CssClass="validator" ID="CompareValidator1" runat="server"
                        SetFocusOnError ErrorMessage="Passwords do not match" ControlToCompare="txtPass"
                        ControlToValidate="txtCPass"></asp:CompareValidator>
                </div>
                <br />
            </div>
            <br />
            <br />
            <center>
                <asp:Button ID="btnReg" runat="server" Text="Create Account" OnClick="btnReg_Click" />
            </center>
            <br />
            <br />
        </asp:Panel>
    </div>
</asp:Content>
