﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="MEWeb.Products.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

  <link href="../Theme/Singular/Custom/home.css" rel="stylesheet" />
  <link href="../Theme/Singular/Custom/customstyles.css" rel="stylesheet" />
  <link href="../Theme/Singular/METTCustomCss/Maintenance/maintenance.css" rel="stylesheet" />
<style type="text/css">
  .movie-border {
      border-radius: 5px;
   
      padding: 15px;
      margin: 5px;
      width:250px;
      height:250px;
    }
</style>
    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
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
                           var HomeContainerTab = AssessmentsTab.AddTab("Products Table");
                           {
                               var Row = HomeContainerTab.Helpers.DivC("row margin0");
                               {
                                   var RowColLeft = Row.Helpers.DivC("col-md-9 ");
                                   {
                                       var AnotherCardDiv = RowColLeft.Helpers.DivC("ibox float-e-margins paddingBottom");
                                       {
                                           var CardTitleDiv = AnotherCardDiv.Helpers.DivC("ibox-title");
                                           {
                                               CardTitleDiv.Helpers.HTML("<i class='ffa-lg fa-fw pull-left'></i>");
                                               CardTitleDiv.Helpers.HTML().Heading5("Products List");
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
                                                   var ColNoContentDiv = RowContentDiv.Helpers.DivC("col-md-12 text-center");
                                                   {
                                                       ColNoContentDiv.AddBinding(Singular.Web.KnockoutBindingString.visible, c => ViewModel.ProductList.Count() == 0);
                                                       ColNoContentDiv.Helpers.HTML("<p>Could not find any Product based on your filter criteria.</p>");
                                                   }
                                                   var ColContentDiv = RowContentDiv.Helpers.DivC("col-md-12");
                                                   {
                                                       var ProductSection = ColContentDiv.Helpers.BootstrapTableFor<MELib.Products.Product>((c) => ViewModel.ProductList, false, false, "");
                                                       {

                                                           var ProductListRow = ProductSection.FirstRow;
                                                           ProductListRow.Style.BackgroundColour = "#1000";

                                                           {
                                                               var ProductTitle = ProductListRow.AddColumn("Product Name");
                                                               {
                                                                   var productNameText = ProductTitle.Helpers.Span(c => c.ProductName);
                                                                   productNameText.Style.FontSize = "15px";
                                                                   ProductTitle.Style.Width = "300px";
                                                                  ProductTitle.Style.Width = "350px";
                                                               }
                                                               var ProductDescription = ProductListRow.AddColumn("Description");
                                                               {
                                                                   var ProductDescriptionText = ProductDescription.Helpers.Span(c => c.ProductDescription);
                                                                   ProductDescriptionText.Style.FontSize = "15px";
                                                                    ProductDescriptionText.Style.Width = "1290px";
                                                                    ProductDescription.Style.Width = "1500px";
                                                               }

                                                               var ProductImage = ProductListRow.AddColumn(" ");
                                                                  {
                                                                      var ProductImageText = ProductImage.Helpers.HTML("<img data-bind=\"attr:{src: $data.ProductImage()} \" class='movie-border'/>");
                                                                       ProductImage.Style.Width = "40px";
                                                                      ProductImageText.Style.Width = "40px";
                                                                  }
                                                               var ProductQuantity = ProductListRow.AddColumn("Quantity");
                                                               ProductQuantity.Style.BackgroundColour="white";
                                                               {
                                                                   var Quantity = ProductQuantity.Helpers.EditorFor(c => c.UserQuantity);
                                                                   ProductQuantity.Style.Width = "70px";
                                                                   Quantity.Style.FontSize = "20px";                                                                  
                                                                    ProductQuantity.Style.Width = "70px";

                                                               }

                                                               var ProductPrice = ProductListRow.AddColumn("Price");
                                                               {
                                                                   var Price = ProductPrice.Helpers.Span(c => "R " + c.ProductPrice);
                                                                   Price.Style.FontSize = "15px";                                                                   
                                                                    ProductPrice.Style.Width = "550px";
                                                                    ProductPrice.AddClass("text-center");
                                                               }
                                                             
                                                                
                                                               var Action = ProductListRow.AddColumn("Purchase");
                                                               {
                                                                   var BuyBtn = Action.Helpers.Button("Add To Basket", Singular.Web.ButtonMainStyle.Success, Singular.Web.ButtonSize.Tiny, Singular.Web.FontAwesomeIcon.shopping_basket);
                                                                   {
                                                                       BuyBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "AddToBasket($data)");
                                                                       BuyBtn.AddClass("btn btn-success btn-outline margin-to-10");
                                                                       Action.Style.Width = "200px";



                                                                   }
                                                               }

                                                           }
                                                           var SaveList = RowContentDiv.Helpers.DivC("col-md-12 text-Left");
                                                           {
                                                               var btnView = SaveList.Helpers.Button("Go To Basket", Singular.Web.ButtonMainStyle.NoStyle, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.shopping_basket);
                                                               {
                                                                   btnView.AddClass("btn btn-success btn-outline");
                                                                   btnView.AddBinding(Singular.Web.KnockoutBindingString.click, "Basket($data)");
                                                               }
                                                           }
                                                           var Total = ColContentDiv.Helpers.HTML(" Sub Total = R " + Math.Round( ViewModel.TotalSum,2));
                                                           {
                                                               Total.Style.BackgroundColour = "blue";
                                                               Total.Style.FontSize = "70px";
                                                               //Total.Style.FontWeight= Singular.Web.FontWeight.bold;
                                                           }
                                                       }
                                                   }
                                               }
                                           }

                                       }
                                   }

                                   var RowColRight = Row.Helpers.DivC("col-md-3");
                                   {

                                       var AnotherCardDivL = RowColRight.Helpers.DivC("ibox float-e-margins paddingBottom");
                                       {
                                           var CardTitleDiv = AnotherCardDivL.Helpers.DivC("ibox-title");
                                           {
                                               CardTitleDiv.Helpers.HTML("<i class='ffa-lg fa-fw pull-left'></i>");
                                               CardTitleDiv.Helpers.HTML().Heading5("Products Cartegory Filter");
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
                                           var ContentDiv = AnotherCardDivL.Helpers.DivC("ibox-content");
                                           {
                                               var RowContentDiv = ContentDiv.Helpers.DivC("row");
                                               {
                                                   var MovieGenreContentDiv = RowContentDiv.Helpers.DivC("col-md-12");
                                                   {

                                                       MovieGenreContentDiv.Helpers.LabelFor(c => ViewModel.CategoryID);
                                                       var ReleaseFromDateEditor = MovieGenreContentDiv.Helpers.EditorFor(c => ViewModel.CategoryID);
                                                       ReleaseFromDateEditor.AddClass("form-control marginBottom20 ");

                                                       var FilterBtn = MovieGenreContentDiv.Helpers.Button("Filter", Singular.Web.ButtonMainStyle.Primary, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.filter);
                                                       {
                                                           FilterBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "FilterProducts($data)");
                                                           FilterBtn.AddClass("btn btn-success btn-outline");
                                                       }
                                                       var ResetBtn = MovieGenreContentDiv.Helpers.Button("Reset", Singular.Web.ButtonMainStyle.Default, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.circle);
                                                       {
                                                           ResetBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "FilterReset($data)");
                                                           ResetBtn.AddClass("btn btn-danger btn-outline");
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
 
  <script type="text/javascript">
    // Place page specific JavaScript here or in a JS file and include in the HeadContent section
    Singular.OnPageLoad(function () {
      $("#menuItem1").addClass('active');
      $("#menuItem1 > ul").addClass('in');
    });

      var AddToBasket = function (obj) {

          ViewModel.CallServerMethod('AddToBasket', { productID: obj.ProductID(), productList: ViewModel.ProductList.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  //  location.reload();
                  alert('Product Added To Basket')
                  //MEHelpers.Notification("Product Added To Basket", "Centre ", "Success", 2000);
                  ViewModel.ProductList.Set(result.Data);
                     window.location = "../Basket/Basket.aspx";           
              }
              else {
                  MEHelpers.Notification(result.ErrorText,'center', 'warning', 5000);
              }
              
          })
      };


    var FilterProducts = function (obj) {
      // alert('Movie Genre ID ' + obj.MovieGenreID());

        ViewModel.CallServerMethod('FilterProducts', { CategoryID: obj.CategoryID(), ShowLoadingBar: true }, function (result) {
            if (result.Success) {
            
            MEHelpers.Notification("Products filtered successfully.", 'center', 'success', 10000);
                ViewModel.ProductList.Set(result.Data);
               
        }
        else {
          MEHelpers.Notification(result.ErrorText, 'center', 'warning', 10000);
        }
      })
      };

      //Set dropdown to select product category

    var FilterReset = function (obj) {
      ViewModel.CallServerMethod('FilterProducts', { CategoryID: obj.CategoryID(), ResetInd: 1, ShowLoadingBar: true }, function (result) {
        if (result.Success) {
          MEHelpers.Notification("Products reset successfully.", 'center', 'success', 1000);
          ViewModel.ProductList.Set(result.Data);

        }
        else {
          MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
        }
      })
    };

      var Basket = function () {
          window.location = '../Basket/Basket.aspx';
      };

  </script>

</asp:Content>
