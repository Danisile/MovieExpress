﻿<%@ Page Title="Popcorn" Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" MasterPageFile="~/Site.Master" Inherits="MEWeb.Account.Home" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
  <!-- Add your page specific styles and JavaScript classes below -->
  <link href="../Theme/Singular/Custom/home.css" rel="stylesheet" />
  <link href="../Theme/Singular/Custom/customstyles.css" rel="stylesheet" />
  <style>
      .movie-border {
      border-radius: 5px;
      border: 2px solid #0094ff;
      padding: 15px;
      margin: 5px;
      width:200px;
      height:200px;
    }
    div.item {
      vertical-align: top;
      display: inline-block;
      text-align: center;
      padding-bottom: 25px;
    }
    .caption {
      display: block;
      padding-bottom: 5px;
    }
     .movie-border {
      border-radius: 5px;
      border: 2px solid #0094ff;
      padding: 15px;
      margin: 5px;
      width:200px;
      height:200px;
    }
    div.movie-item {
      vertical-align: top;
      display: inline-block;
      text-align: center;
    }
    .caption {
      display: block;
    }
    .margin-top-10 {
      margin-top: 10px;
    }

    /* Pagination*/
  </style>
</asp:Content>
<asp:Content ID="PageTitleContent" runat="server" ContentPlaceHolderID="PageTitleContent">
  <%
    using (var h = this.Helpers)
    {
      // Not used in this example
    }
  %>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
  <%
      using (var h = this.Helpers)
      {
          var MainHDiv = h.DivC("row pad-top-10");
          {
              var PanelContainer = MainHDiv.Helpers.DivC("col-md-12 p-n-lr");
              {
                  var HomeContainer = PanelContainer.Helpers.DivC("tabs-container");
                  {
                      var AssessmentsTab = HomeContainer.Helpers.TabControl();
                      {
                          AssessmentsTab.Style.ClearBoth();
                          AssessmentsTab.AddClass("nav nav-tabs");
                          var HomeContainerTab = AssessmentsTab.AddTab("Home");
                          {
                              var Row = HomeContainerTab.Helpers.DivC("row margin0");
                              {
                                  var RowColMain = Row.Helpers.DivC("col-md-12");
                                  {
                                      RowColMain.Helpers.HTML().Heading2("Welcome to Movie Express");
                                      RowColMain.Helpers.HTMLTag("p").HTML = "On your dashboard below you will see the most recent activities performed on your account.";
                                  }
                                  var RowColLeft = Row.Helpers.DivC("col-md-9");
                                  {
                                      var AnotherCardDiv = RowColLeft.Helpers.DivC("ibox float-e-margins paddingBottom");
                                      {
                                          var CardTitleDiv = AnotherCardDiv.Helpers.DivC("ibox-title");
                                          {
                                              CardTitleDiv.Helpers.HTML("<i class='ffa-lg fa-fw pull-left'></i>");
                                              CardTitleDiv.Helpers.HTML().Heading5("Watched Recently");
                                          }
                                          var CardTitleToolsDiv = CardTitleDiv.Helpers.DivC("ibox-tools");
                                          {
                                              var aToolsTag = CardTitleToolsDiv.Helpers.HTMLTag("a");
                                              aToolsTag.AddClass("collapse-link");
                                              {
                                                  var iToolsTag = aToolsTag.Helpers.HTMLTag("i");
                                                  iToolsTag.AddClass("fa fa-chevron-up");
                                              }
                                          }
                                          var ContentDiv = AnotherCardDiv.Helpers.DivC("ibox-content");
                                          {
                                              var RowContentDiv = ContentDiv.Helpers.DivC("row");
                                              {

                                                  // Show If No Movies Watched
                                                  var ColContentDiv = RowContentDiv.Helpers.DivC("col-md-12");
                                                  {
                                                      ColContentDiv.AddBinding(Singular.Web.KnockoutBindingString.visible, c => ViewModel.FoundUserMoviesInd == false);
                                                      // Place Content Here
                                                      ColContentDiv.Helpers.HTML("<p>[ You have not watched any movies, follow the link below to browse available movies. ]</p>");

                                                      // Browse Movies Button
                                                      var BrowseBtn = ColContentDiv.Helpers.Button("Browse Movies", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                      {
                                                          BrowseBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "BrowseMovies()");
                                                          BrowseBtn.AddClass("btn btn-success btn-outline");
                                                      }
                                                  }

                                                  // Show if Movies Watched USe Knockout Binding and Property on ViewModel
                                                  var MovieColContentDiv = RowContentDiv.Helpers.DivC("col-md-12");
                                                  {
                                                      MovieColContentDiv.AddBinding(Singular.Web.KnockoutBindingString.visible, c => ViewModel.FoundUserMoviesInd == true);

                                                      var MovieColContainer = MovieColContentDiv.Helpers.DivC("movies-container");
                                                      {
                                                          var MoviesWatchedDiv = MovieColContainer.Helpers.ForEach<MELib.Movies.UserMovie>(c => c.UserMovieList);
                                                          {

                                                              // Using Knockout Binding
                                                              // <img width="16px" height="16px" data-bind="attr:{src: imagePath}" />
                                                              MoviesWatchedDiv.Helpers.HTML("<div class='movie-item'>");
                                                              MoviesWatchedDiv.Helpers.HTML("<img data-bind=\"attr:{src: $data.MovieImageURL()} \" class='movie-border'/>");
                                                              MoviesWatchedDiv.Helpers.HTML("<b><span data-bind=\"text: $data.MovieTitle() \"  class='caption'></span></b>");
                                                              // MoviesWatchedDiv.Helpers.HTML("<span data-bind=\"text: $data.MovieGenreID() \"  class='caption'></span>");

                                                          }
                                                          var WatchBtn = MoviesWatchedDiv.Helpers.Button("Watch Now", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.None);
                                                          {
                                                              WatchBtn.AddBinding(Singular.Web.KnockoutBindingString.text, c => "Watch Again");
                                                              WatchBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "RentMovie($data)");
                                                              WatchBtn.AddClass("btn btn-success btn-outline margin-top-10");
                                                          }
                                                          MoviesWatchedDiv.Helpers.HTML("</div>");
                                                      }
                                                      var MoviPaginationColContainer = MovieColContentDiv.Helpers.DivC("pagination-container");
                                                      {
                                                      }
                                                  }
                                              }

                                          }
                                      }
                                  }
                                  var RowCol = Row.Helpers.DivC("col-md-3");
                                  {

                                      var CardDiv = RowCol.Helpers.DivC("ibox float-e-margins paddingBottom");
                                      {
                                          var CardTitleDiv = CardDiv.Helpers.DivC("ibox-title");
                                          {
                                              CardTitleDiv.Helpers.HTML("<i class='fa-lg fa-fw pull-left'></i>");
                                              CardTitleDiv.Helpers.HTML().Heading5("Profile");
                                          }
                                          var CardTitleToolsDiv = CardTitleDiv.Helpers.DivC("ibox-tools");
                                          {
                                              var aToolsTag = CardTitleToolsDiv.Helpers.HTMLTag("a");
                                              aToolsTag.AddClass("collapse-link");
                                              {
                                                  var iToolsTag = aToolsTag.Helpers.HTMLTag("i");
                                                  iToolsTag.AddClass("fa fa-chevron-up");
                                              }
                                          }
                                          var ContentDiv = CardDiv.Helpers.DivC("ibox-content");
                                          {
                                              var RowContentDiv = ContentDiv.Helpers.DivC("row");
                                              {
                                                  var LeftColContentDiv = RowContentDiv.Helpers.DivC("col-md-12 text-center");
                                                  {

                                                      var ProfileDiv = LeftColContentDiv.Helpers.With<MELib.Accounts.Account>(c => c.UserAccount);
                                                      {
                                                          var Profile = ProfileDiv.Helpers.HTML("<div class='circlecenter'><div class='circlecontaineruser circlecenter'><span class='fa fa-user fa-lg fa-fw' style='font-size:64px;'></span></div></div>");
                                                          ProfileDiv.Helpers.Span("User Account: ").Style.FontSize = "20px";
                                                          ProfileDiv.Helpers.Span(c => c.AccountID).Style.FontSize = "20px";
                                                          ProfileDiv.Helpers.HTMLTag("br");
                                                          ProfileDiv.Helpers.Span("Available Balance :  R").Style.FontSize = "20px";
                                                          ProfileDiv.Helpers.Span(c => c.Balance).Style.FontSize = "20px";
                                                          ProfileDiv.Helpers.HTMLTag("br");
                                                          ProfileDiv.Helpers.Span("User Name: ").Style.FontSize = "20px";
                                                          var UserName = ProfileDiv.Helpers.Span(c => ViewModel.LoggedInUserName);
                                                          UserName.Style.FontSize = "20px";
                                                         
                                                          ProfileDiv.Helpers.HTMLTag("br");
                                                          
                                                      }
                                                  }
                                                  var RightColContentDiv = RowContentDiv.Helpers.DivC("col-md-12 text-center");
                                                  {
                                                      // Fund Account Button
                                                      var FundAccountBtn = RightColContentDiv.Helpers.Button("Deposit", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.money);
                                                      {
                                                          FundAccountBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "DepositFunds()");
                                                          FundAccountBtn.AddClass("btn btn-success btn-outline btn-outline");
                                                      }
                                                      // Edit Profile
                                                      var EditProfileBtn = RightColContentDiv.Helpers.Button("Profile", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.user);
                                                      {
                                                          EditProfileBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "EditProfile()");
                                                          EditProfileBtn.AddClass("btn btn-success btn-outline btn-outline");
                                                      }
                                                  }
                                              }
                                          }
                                      }
                                  }
                              }
                          }
                      }
                  }
              }
          }
      }
  %>
  <!-- Place your JavaScript in a file e.g. '../Scripts/home.js' and include it in the header section of each page  -->
  <script type="text/javascript">
    // On page load
    Singular.OnPageLoad(function () {
      $("#menuItem0").addClass("active");
    });

    var RentMovie = function () {
      window.location = '../Movies/Movies.aspx';
      }

      var EditProfile = function () {
          window.location = '../Profile/Profile.aspx';
      }
      var DepositFunds = function () {
          window.location = '../Profile/DepositFunds.aspx';
      }

  </script>
</asp:Content>


