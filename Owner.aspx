<%@ Page Title="" Language="C#" MasterPageFile="~/OwnerSite2.master" AutoEventWireup="true"
    CodeFile="Owner.aspx.cs" Inherits="_Default" %>

<asp:Content ID="ownerContent" ContentPlaceHolderID="ContentPage" runat="Server">
    <style>
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
        @media screen and (min-width: 992px)
        {
            #testCarousel .carousel-inner
            {
                height: 30vw;
            }
        }
        @media screen and (min-width: 601px)
        {
            body
            {
                margin: 0;
                padding: 0;
                font-size: 1.2em;
            }
            #ownerIntro
            {
                width: 100%;
            }
            #lblUser, #welcome
            {
                font-size: 2em;
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
            #ownerIntro
            {
                width: 80%;
            }
            #lblUser, #welcome
            {
                font-size: 1.5em;
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
        .bigBtnDiv
        {
            
            margin: 2em;
        }
        .bigBtn
        {
            background-image: linear-gradient(#ffb480, #ffffff);
            height: 10em;
            width: 10em;
            border: 2px outset #f66400;
            font-size: 1.3em;
           
        }
        .bigBtn:hover
        {
            background-image: linear-gradient(#f66400, #f66400);
            color: White;
            font-weight: bold;
            transition: ease-in-out 0.3s;
        }
    </style>
    <br />
    <br />
    <div id="ownerIntro" align="center" style="margin: auto;">
        <p id="lblUser">
            <asp:Label ID="lblUser" runat="server"></asp:Label></p>
        <p id="welcome">
            Welcome to <span style="color: #800300"><strong>Stay</strong></span><span style="color: #F66400"><strong>Hub</strong></span><strong>.com
            </strong>
            <br />
        </p>
        <hr width="10%" style="margin: auto; background-color: #f66400; color: #f66400;"
            size="2" />
        <br /><br />
        <p style="font-size: 1.2em; line-height: 2em;" align="center">
            Advertise your PG Homes for FREE
            <br />
            at no hidden costs!
            <br />
        </p>
    <div class="row flex-container" style="width: 100%;">
        <div class="bigBtnDiv shadow" align="center">
            <asp:Button ID="btnAdd" CssClass="bigBtn" runat="server" Text="Add new PG" 
                PostBackUrl="~/OwnAdd.aspx"/>
        </div>
        <div class="bigBtnDiv shadow" align="center">
            <asp:Button ID="btnView" CssClass="bigBtn" runat="server" Text="View My PGs" 
                PostBackUrl="~/OwnPG.aspx"/>
        </div>
        <div class="bigBtnDiv shadow" align="center">
            <asp:Button ID="btnVisits" CssClass="bigBtn" runat="server" Text="PG Visits Schedule" 
                PostBackUrl="~/OwnSchedule.aspx"/>
        </div>
    </div>
        <p style="font-size: 1em; line-height: 2em">
            Keep a track of all your PG visits with the help of our Visits Schedule
            <br />
            Update your PGs or profile with a single click!
            <br />
            You can also deactivate your PGs to temporarily stop your PGs from appearing
            in the search results.
            <br />
            Don't worry, they can be reactivated with the same no. of interests as before whenever
            you want!
        </p>
        <br />
        <br />
    </div>
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
    <br />
    <div style="width: 100%; margin: auto">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Timer ID="Timer1" runat="server" Interval="5000">
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
