<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true"
    CodeFile="Home.aspx.cs" Inherits="_Default" %>

<%@ MasterType VirtualPath="~/Site2.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="homeContent" ContentPlaceHolderID="ContentPage" runat="Server">
    <style>
        @media screen and (min-width: 992px)
        {
            #testCarousel .carousel-inner
            {
                height: 30vw;
            }
        }
        .carousel-indicators li
        {
            width: 0.8vw;
            height: 0.8vw;
            border-radius: 100%;
            background-color: #f66400;
            margin-bottom: 1vw;
        }
        .carousel-control-prev-icon, .carousel-control-next-icon
        {
            padding: 1.5vw;
        }
        .fa-quote-left
        {
            color: #ffb480;
            font-size: 8vw;
            margin: 0 2vw;
        }
        
        @media screen and (min-width: 601px)
        {
            body
            {
                margin: 0;
                padding: 0;
                font-size: 1.2em;
            }
            #lblUser, #welcome, #desc
            {
                font-size: 2em;
            }
            #sub
            {
                font-size: 1.2em;
            }
            h1
            {
                font-size: 2.5em;
            }
            h2
            {
                font-size: 2em;
            }
            #cardContainer .card-deck .card
            {
                margin: 2%;
            }
        
        }
        
        @media screen and (max-width: 600px)
        {
            body
            {
                font-size: 0.8em;
            }
            #lblUser, #welcome
            {
                font-size: 1.5em;
            }
            #sub, #desc
            {
                font-size: 1em;
            }
            h1
            {
                font-size: 2em;
            }
            h2
            {
                font-size: 2em;
            }
            #aboutUs .abtHead, #testimonials .testHead
            {
                width: 100vw;
            }
            #cardContainer .card-deck .card
            {
                margin: 5% auto;
            }
            #testCarousel .carousel-inner
            {
                height: 70vh;
            }
        }
    </style>
    <div class="row" id="outer-wrapper" style="width: 100vw; height: 90vh; margin: 0;
        padding: 0;">
        <div id="pic-slider" class="carousel slide" data-ride="carousel" style="width: 100vw;">
            <!-- The slideshow -->
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="Images/Bedrooms/23.jfif" alt=" ">
                </div>
                <div class="carousel-item">
                    <img src="Images/Bedrooms/20.jfif" alt=" ">
                </div>
                <div class="carousel-item">
                    <img src="Images/Bathrooms/2.jfif" alt=" ">
                </div>
                <div class="carousel-item">
                    <img src="Images/Living Rooms/18.jfif" alt=" ">
                </div>
                <div class="carousel-item">
                    <img src="Images/Living Rooms/1.jfif" alt=" ">
                </div>
            </div>
        </div>
        <!-- PAGE CONTENT -->
        <div id="homeIntro" style="width: 100%;" align="center">
            <br />
            <br>
            <p id="lblUser">
                <asp:Label ID="lblUser" runat="server"></asp:Label></p>
            <hr width="80em" style="background-color: #f66400; color: #f66400;" size="3" />
            <p id="welcome">
                Welcome to <span style="color: #800300"><strong>Stay</strong></span><span style="color: #F66400"><strong>Hub</strong></span><strong>.com
                </strong>
                <br />
            </p>
            <p id="sub" style="text-align: center">
                The one stop to find your destination...
            </p>
            <%--<table cellspacing="0" align="center" cellpadding="0" style="width: 40%">
            <tr>
                <td style="width: 70%">
                    <asp:TextBox ID="txtCity" runat="server" BorderColor="#800300" BorderWidth="1px"
                        Height="2em" placeholder=" Enter your city..." Font-Size="18px" AutoCompleteType="BusinessCity"
                        Width="100%"></asp:TextBox>
                </td>
                <td  style="width: 30%">
                    <asp:Button ID="btnSearch" runat="server" BackColor="#800300" BorderStyle="None"
                        Font-Bold="True" Font-Size="18px" ForeColor="White" Height="2em" Width="100%"
                        Text="   Search   " PostBackUrl="~/SearchPG.aspx" />
                </td>
            </tr>
        </table>--%>
            <div class="flex-container">
                <div>
                    <asp:TextBox class="rounded-left" ID="txtCity" runat="server" BorderColor="#800300" BorderWidth="1px"
                        Height="2em" placeholder=" Enter your city..." Font-Size="18px" Columns="20"></asp:TextBox>
                    <ajaxToolkit:AutoCompleteExtender ID="txtCity_AutoCompleteExtender" runat="server"
                        BehaviorID="txtCity_AutoCompleteExtender" DelimiterCharacters="" ServiceMethod="SearchCity"
                        TargetControlID="txtCity" CompletionInterval="100" CompletionSetCount="10" MinimumPrefixLength="1" FirstRowSelected="True">
                    </ajaxToolkit:AutoCompleteExtender>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCity"
                        ValidationGroup="searchCity" SetFocusOnError ErrorMessage=""></asp:RequiredFieldValidator>
                </div>
                <div>
                    <%--<asp:Button ID="btnSearch" runat="server" BackColor="#800300" BorderStyle="None"
                        Font-Bold="True" Font-Size="18px" ForeColor="White" Height="2em"
                        Text="   Search   " PostBackUrl="~/SearchPG.aspx" />--%>
                    <asp:LinkButton class="rounded-right" ID="btnSearch" runat="server" BackColor="#800300" ValidationGroup="searchCity"
                        ForeColor="White" Height="36px" Width="37px" OnClick="btnSearch_Click">
            <i class="fa fa-search fa-flip-horizontal" style="padding:10px; font-size: 18px;"></i>
                    </asp:LinkButton>
                </div>
            </div>
            <br />
            <div id="desc" class="row">
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <p id="P1" style="text-align: center; font-weight: bold;">
                        Verified <span style="font-weight: normal">Owners</span>
                    </p>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <p id="P2" style="text-align: center; font-weight: bold;">
                        Spacious <span style="font-weight: normal">Homes</span>
                    </p>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                    <p id="P3" style="text-align: center; font-weight: bold;">
                        Affordable <span style="font-weight: normal">Rent</span>
                    </p>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div class="row" id="aboutUs" style="background-color: #f9f9f9; width: 100vw;">
        <div class="col-lg-4 col-md-5 col-sm-5 col-xs-12">
            <div class="abtHead" style="background: #F66400; color: #fff; padding: 30px; height: 100%;">
                <h1>
                    About Us</h1>
                <br />
                <br />
                <cite>"Home is the shelter from storms -
                    <br />
                    all sorts of storms"
                    <br />
                    <br />
                    <span style="float: right">&ndash; William Bennett</span> </cite>
                <br />
            </div>
        </div>
        <div class="col-lg-8 col-md-7 col-sm-7 col-xs-12">
            <div style="margin: 20px; padding: 20px;">
                <center>
                    An Arabic proverb says, <cite>"A little bird wants but a little nest"!</cite>
                </center>
                <br />
                <p style="text-align: justify; font-size: 0.9em;">
                    StayHub is a home rental platform that helps you find your dream home without paying
                    any brokerage.
                    <br />
                    <br />
                    Our goal is to connect home seekers with home owners directly and make the hunt
                    for tenants and rental homes simple. We want to make housing affordable and cater
                    to individual needs, which greatly vary from person to person. As of now we provide
                    services to only a few major cities in India, but we'll soon be expanding into many
                    other cities across the country.
                    <br />
                    <br />
                    So start exploring...Whatever be your requirement, whether you want to find a home
                    or rent one, we have something for you!
                    <br />
                </p>
            </div>
        </div>
    </div>
    <div style="width: 100%; margin: auto">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Timer ID="Timer1" runat="server" Interval="1000">
                </asp:Timer>
                <div style="margin: 2em auto; max-height: 10em; width: 100%; overflow: hidden;" align="center">
                    <asp:AdRotator ID="AdRotator1" runat="server" AdvertisementFile="~/AdsData.xml" Height="10em"
                        Target="_blank" ToolTip="Visit Site" Style="margin: 2vw" KeywordFilter="Interiors" />
                    <asp:AdRotator ID="AdRotator2" runat="server" AdvertisementFile="~/AdsData.xml" Height="10em"
                        Target="_blank" ToolTip="Visit Site" Style="margin: 2vw" KeywordFilter="Packers" />
                    <asp:AdRotator ID="AdRotator3" runat="server" AdvertisementFile="~/AdsData.xml" Height="10em"
                        Target="_blank" ToolTip="Visit Site" Style="margin: 2vw" KeywordFilter="Interiors" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <br />
    <center>
        <h2>
            Our Cities</h2>
    </center>
    <hr width="80em" style="background-color: #f66400; color: #f66400;" size="3" />
    <div id="ourCities" class="row flex-container" style="width: 100vw;">
        <div>
            <a href="SeekPG.aspx?city=Mumbai">
                <img src="Images/Cities/mumbai-circle.png" height="230px" alt="Mumbai" /></a>
            <br />
            <center>
                Mumbai</center>
            <br />
        </div>
        <div>
            <a href="SeekPG.aspx?city=Bangalore">
                <img src="Images/Cities/bangalore-circle.png" height="230px" alt="Bangalore" /></a>
            <br />
            <center>
                Bangalore</center>
            <br />
        </div>
        <div>
            <a href="SeekPG.aspx?city=Delhi">
                <img src="Images/Cities/delhi-circle.png" height="230px" alt="Delhi" /></a>
            <br />
            <center>
                Delhi</center>
            <br />
        </div>
        <div>
            <a href="SeekPG.aspx?city=Chennai">
                <img src="Images/Cities/chennai-circle.png" height="230px" alt="Chennai" /></a>
            <br />
            <center>
                Chennai</center>
            <br />
        </div>
        <div>
            <a href="SeekPG.aspx?city=Pune">
                <img src="Images/Cities/pune-circle.png" height="230px" alt="Pune" /></a>
            <br />
            <center>
                Pune</center>
            <br />
        </div>
        <div>
            <a href="SeekPG.aspx?city=Kolkata">
                <img src="Images/Cities/kolkata-circle.png" height="230px" alt="Kolkata" /></a>
            <br />
            <center>
                Kolkata</center>
            <br />
        </div>
    </div>
    <br />
    <center>
        <h2>
            Why Us</h2>
    </center>
    <hr width="80em" style="background-color: #f66400; color: #f66400;" size="3" />
    <div id="cardContainer" class=" mx-auto" style="width: 90%;">
        <br />
        <div class="card-deck mx-auto">
            <div class="shadow card w-75 ">
                <div class="card-body text-center">
                    <h4 class="card-title">
                        Verified Homes</h4>
                    <br />
                    <img src="Images\Icons\verified.png" width="60%" height="auto" /><br />
                    <p class="card-text text-justify">
                        <br />
                        We verify each PG listing & ensure that these are direct owners or shared accommodation
                        parties and there are no middlemen or brokers involved.</p>
                </div>
            </div>
            <div class="shadow card w-75 ">
                <div class="card-body text-center">
                    <h4 class="card-title">
                        Free Advertising</h4>
                    <br />
                    <img src="Images\Icons\money.png" width="60%" height="auto" /><br />
                    <p class="card-text text-justify">
                        <br />
                        As the owner of a property looking for paying guests, you can advertise your PG absolutely
                        free!<br />
                        Create an account as a PG seeker or owner on StayHub.com at zero costs.
                    </p>
                </div>
            </div>
            <div class="shadow card w-75 ">
                <div class="card-body text-center">
                    <h4 class="card-title">
                        Schedule Home Visits</h4>
                    <br />
                    <img src="Images\Icons\visit.png" width="60%" height="auto" /><br />
                    <p class="card-text text-justify">
                        <br />
                        Now what if you really liked a home and want to check it out in person?<br />
                        At StayHub.com you can easily request a home visit from the owner and also track
                        your previous visits.
                    </p>
                </div>
            </div>
        </div>
    </div>
    <br />
    <br />
    <div class="row" id="testimonials" style="background-color: #f9f9f9; width: 100vw;">
        <div class="col-lg-4 col-md-5 col-sm-5 col-xs-12">
            <div class="testHead" style="background: #F66400; color: #fff; padding: 30px; height: 100%;">
                <h1>
                    Testimonials</h1>
                <br />
                <br />
                <cite>"A customer talking about their experience with you is worth ten times that which
                    you write or say about yourself"
                    <br />
                    <br />
                    <span style="float: right">&ndash; David J. Greer</span> </cite>
                <br />
            </div>
        </div>
        <div id="testContent" class=" container-fluid col-lg-8 col-md-7 col-sm-7 col-xs-12">
            <div id="testCarousel" class="carousel slide" data-ride="carousel" data-interval="3000"
                data-pause="hover">
                <!-- Indicators -->
                <ul class="carousel-indicators">
                    <li data-target="#testCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#testCarousel" data-slide-to="1"></li>
                    <li data-target="#testCarousel" data-slide-to="2"></li>
                    <li data-target="#testCarousel" data-slide-to="3"></li>
                </ul>
                <!-- The slideshow -->
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div id="trial1" class="media border bg-white rounded-lg shadow-lg p-3 w-75 mx-auto m-5">
                            <i class="fa fa-quote-left"></i>
                            <div class="media-body">
                                <h4 style="font-size: 1.5em">
                                    Raj Malhotra
                                </h4>
                                <small><i>Posted on December 10, 2019</i></small>
                                <p>
                                    <br />
                                    Found this gem amidst the frustration of traditional brokerage system. Instead of
                                    a broker deciding the best places for me, I was able to easily choose one for myself.
                                    Great initiative by StayHub!</p>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="media border bg-white rounded-lg shadow-lg p-3 w-75 mx-auto m-5">
                            <i class="fa fa-quote-left"></i>
                            <div class="media-body">
                                <h4 style="font-size: 1.5em">
                                    Naina Kapoor
                                </h4>
                                <small><i>Posted on February 16, 2018</i></small>
                                <p>
                                    <br />
                                    It's so easy here to find homes in any city according to our needs! Being able to
                                    directly contact the owner is an added advantage.
                                    <br />
                                    Awesome website.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="media border bg-white rounded-lg shadow-lg p-3 w-75 mx-auto m-5">
                            <i class="fa fa-quote-left"></i>
                            <div class="media-body" style="text-align: justify; margin-right: 2vw;">
                                <h4 style="font-size: 1.5em">
                                    Shubh Joshi
                                </h4>
                                <small><i>Posted on September 24, 2017</i></small>
                                <p>
                                    <br />
                                    Being informed about how many people are interested in my property & the ease of
                                    scheduling home visits is the best feature of this website. As an owner it's very
                                    reassuring & helpful factor.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="media border bg-white rounded-lg shadow-lg p-3 w-75 mx-auto m-5">
                            <i class="fa fa-quote-left"></i>
                            <div class="media-body">
                                <h4 style="font-size: 1.5em">
                                    Aman Mehra
                                </h4>
                                <small><i>Posted on March 19, 2016</i></small>
                                <p>
                                    <br />
                                    Finding a home has never been simpler and so hassle-free. Switching cities for work
                                    is stressful enough but thanks to StayHub for lending a helping hand!
                                    <br />
                                    Highly recommended.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Left and right controls -->
                <a class="carousel-control-prev" href="#testCarousel" data-slide="prev"><span class="carousel-control-prev-icon">
                </span></a><a class="carousel-control-next" href="#testCarousel" data-slide="next"><span
                    class="carousel-control-next-icon"></span></a>
            </div>
        </div>
    </div>
    <br />
    <br />
</asp:Content>
