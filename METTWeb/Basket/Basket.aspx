<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Basket.aspx.cs" Inherits="MEWeb.Basket.Basket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
  <link href="../Theme/Singular/Custom/home.css" rel="stylesheet" />
  <link href="../Theme/Singular/Custom/customstyles.css" rel="stylesheet" />
  <link href="../Theme/Singular/METTCustomCss/Maintenance/maintenance.css" rel="stylesheet" />
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
                        var HomeContainerTab = AssessmentsTab.AddTab("Basket");
                        {
                            var Row = HomeContainerTab.Helpers.DivC("row margin0");
                            {
                                var RowCol = Row.Helpers.DivC("col-md-12");
                                {
                                    var TransDiv = RowCol.Helpers.BootstrapTableFor<MELib.Delivery.Delivery>((c) => c.DeliveryList, false, false, "");
                                    {
                                        var FirstRow = TransDiv.FirstRow;
                                        {
                                            var RightColContentDiv = RowCol.Helpers.DivC("col-md-12");
                                            {
                                                RightColContentDiv.Helpers.LabelFor(c => ViewModel.DeliveryID);
                                                var ReleaseFromDateEditor = RightColContentDiv.Helpers.EditorFor(c => ViewModel.DeliveryID);
                                                ReleaseFromDateEditor.AddClass("form-control marginBottom20 ");
                                            }

                                            RowCol.Helpers.HTML().Heading2(" Sub Total = R " + Math.Round(ViewModel.TotalSum, 2));

                                            var BasketList = RowCol.Helpers.BootstrapTableFor<MELib.Basket.Basket>((c) => ViewModel.BasketList, false, false, "");

                                            {
                                                var MovieListRow = BasketList.FirstRow;
                                                {
                                                    var Product = MovieListRow.AddColumn("Product Name");
                                                    {
                                                        Product.Style.Width = "400px";
                                                        var ProductText = Product.Helpers.Span(c => c.ProductName);
                                                    }
                                                    var Quantity = MovieListRow.AddColumn("Basket Quantity");
                                                    {
                                                        Quantity.Style.Width = "150px";
                                                        // MovieGenre.Style.Display = 1;
                                                        var QuantityText = Quantity.Helpers.EditorFor(c => c.Quantity);
                                                    }

                                                    var TotalAmount = MovieListRow.AddColumn("Amount ");
                                                    {
                                                        TotalAmount.Style.Width = "200px";
                                                        var TotalAmountText = TotalAmount.Helpers.Span("R" + Math.Round(ViewModel.TotalSum, 2));
                                                    }
                                                    var Description = MovieListRow.AddColumn("Description ");
                                                    {
                                                        Description.Style.Width = "200px";
                                                        var DescriptionText = Description.Helpers.Span(c => c.ProductDescription);
                                                    }


                                                    var BasketAction = MovieListRow.AddColumn("Actions");
                                                    {
                                                        BasketAction.Style.Width = "400px";
                                                        var btnDelete = BasketAction.Helpers.Button("Delete", Singular.Web.ButtonMainStyle.Danger, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.remove);
                                                        {
                                                            BasketAction.Style.Width = "200px";
                                                            btnDelete.AddClass("btn btn-primary btn-outline");
                                                            btnDelete.AddBinding(Singular.Web.KnockoutBindingString.click, "DeleteItem($data)");
                                                        }
                                                        var UpdateBtn = BasketAction.Helpers.Button("Update", Singular.Web.ButtonMainStyle.Success, Singular.Web.ButtonSize.Normal, Singular.Web.FontAwesomeIcon.upload);
                                                        {
                                                            BasketAction.Style.Width = "200px";
                                                            UpdateBtn.AddClass("btn btn-primary btn-outline");
                                                            UpdateBtn.AddBinding(Singular.Web.KnockoutBindingString.click, "UpdateBasket($data)");
                                                        }
                                                    }





                                                    var SaveList = RowCol.Helpers.DivC("col-md-12 text-Centre");
                                                    {
                                                        var btnView = SaveList.Helpers.Button("Empty Basket", Singular.Web.ButtonMainStyle.Danger, Singular.Web.ButtonSize.Large, Singular.Web.FontAwesomeIcon.remove);
                                                        {
                                                            btnView.AddClass("btn btn-danger btn-outline");
                                                            btnView.AddBinding(Singular.Web.KnockoutBindingString.click, "DeleteBasket($data)");
                                                        }

                                                        var Purchase = SaveList.Helpers.Button("CheckOut", Singular.Web.ButtonMainStyle.Success, Singular.Web.ButtonSize.Large, Singular.Web.FontAwesomeIcon.shoppingBasket);
                                                        {
                                                            Purchase.AddClass("btn btn-bg-info btn-outline");
                                                            Purchase.AddBinding(Singular.Web.KnockoutBindingString.click, "Purchase($data)");
                                                        }


                                                        var DropContentDiv = RowCol.Helpers.DivC("col-md-3");
                                                        {
                                                             
                                                            DropContentDiv.Helpers.HTMLTag("br");
                                                            DropContentDiv.Helpers.HTML().Heading3("R30 for Delivery");
                                                            DropContentDiv.Helpers.HTMLTag("br");
                                                            DropContentDiv.Helpers.HTMLTag("br");
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
    }
  %>

  <script type="text/javascript">
    Singular.OnPageLoad(function () {
      $("#menuItem5").addClass("active");
        $("#menuItem5 > ul").addClass("in");

        	$("#menuItem5ChildItem3").addClass("subActive");

    });

      var Purchase = function (obj) {

          ViewModel.CallServerMethod('Purchase', { TotalSum: obj.TotalSum(),DeliveryID: ViewModel.DeliveryID(), BasketList: ViewModel.BasketList.Serialise(), ProductList: ViewModel.ProductList.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                 alert('Successfuly Purchased Product')
                  //MEHelpers.Notification("Successfuly Purchased Product", 'center ', 'info', 1000);
                   window.location = '../Profile/Transactions.aspx';
                 
                  
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
                 // window.location = '../Basket/Basket.aspx';
              }
          })
      };

         var DeleteBasket = function (obj) {

             ViewModel.CallServerMethod('DeleteBasket', { BasketList: ViewModel.BasketList.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  
                  MEHelpers.Notification("Products Cleared From Basket", 'Centre ', 'Success', 1000);
                   window.location = '../Basket/Basket.aspx';
                  
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 3000);
              }
          })
      };

          var DeleteItem = function (obj) {

              ViewModel.CallServerMethod('DeleteItem', { BasketID: obj.BasketID(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                  
                  MEHelpers.Notification("Product Removed From Basket", 'Centre ', 'Success', 1000);
                  window.location = '../Basket/Basket.aspx';
                  
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
              }
          })
      };

      var UpdateBasket = function (obj) {
          ViewModel.CallServerMethod('UpdateBasket', { ProductID: obj.ProductID(), BasketList: ViewModel.BasketList.Serialise(), productList: ViewModel.ProductList.Serialise(), ShowLoadingBar: true }, function (result) {
              if (result.Success) {
                 // MEHelpers.Notification("Successfully Saved", 'center', 'success', 3000);
                  alert('Successfully Updated');
                  window.location = '../Basket/Basket.aspx';
              }
              else {
                  MEHelpers.Notification(result.ErrorText, 'center', 'warning', 5000);
              }
          })
      };

      var Cancel = function () {
          window.location = '../Basket/Basket.aspx';
      };
  </script>
</asp:Content>