using System;
using Singular.Web;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Web.UI;
using MELib.RO;
using MELib.Security;
using System.Web.UI.WebControls;
using Singular;
using MELib.Categories;
using MELib.Basket;
using MELib.Products;
using System.Linq;

namespace MEWeb.Products
{
    public partial class Products : MEPageBase<ProductsVM>
    {

    }
    public class ProductsVM : MEStatelessViewModel<ProductsVM>
    {

        public ProductList ProductList { get; set; }
        public BasketList BasketList { get; set; }
        public MELib.Security.UserList UserList { get; set; }

        //filter Criteria
        public DateTime Created { get; set; }
        public string ProductName { get; set; }

        [Singular.DataAnnotations.DropDownWeb(typeof(MELib.RO.ROCategoryList), UnselectedText = "Select", ValueMember = "CategoryID", DisplayMember = "CategoryName")]
        [Display(Name = "Category")]
        public int? CategoryID { get; set; }
        public int? ProductID { get; set; }
        public ProductList Select { get; set; }
        public int UserID { get; set; }
        public int QuantityList { get; set; }
        public decimal TotalSum { get; set; }
        public decimal TotalProducts { get; set; }
        public ProductsVM()
        {

        }
        protected override void Setup()
        {
            base.Setup();
            ProductList = ProductList.GetProductList();
            BasketList = BasketList.GetBasketList();

            TotalSum = MELib.Basket.BasketList.GetBasketList().Sum(x => x.BasketBalance);
            MELib.Products.ProductList.GetProductList();

        }

        [WebCallable]
        public Result AddToBasket(int productID, ProductList productList)
        {
            Result sr = new Result();

            try
            {
                if (productID != 0)
                {
                    MELib.Basket.Basket basket = new MELib.Basket.Basket();
                    BasketList temp = new BasketList();

                    Product product = productList.GetItem(productID);

                    var ProductCount = MELib.Products.ProductList.GetProductList();

                    basket.BasketCreatedOn = DateTime.Today;
                    basket.BasketModifiedOn = null;
                    basket.BasketDeletedOn = null;
                    basket.ProductID = (int)productID;
                    basket.UserID = Settings.CurrentUser.UserID;
                    basket.Quantity = product.UserQuantity;
                  // product.UserQuantity = 0;

                    //product.Quantity = QuantityList;

                    var count = basket.ProductID.Value;


                    if (basket.Quantity >= 1)
                    {

                        if (product.ProductQuantity >= 1)
                        {

                            if (product.ProductQuantity >= basket.Quantity)
                            {
                                basket.BasketBalance = product.ProductPrice * basket.Quantity;
                            }
                            else
                            {
                                sr.ErrorText = "Sorry Only  " + product.ProductQuantity.ToString() + " " + "Left In Stock";
                                // temp.TrySave();
                                sr.Success = false;
                                return sr;
                            }
                        }

                        else
                        {
                            sr.ErrorText = "Sorry Out of Stock....Try Other Products.";
                            // temp.TrySave();
                            sr.Success = false;
                            return sr;
                        }

                        product.ProductQuantity = product.ProductQuantity - basket.Quantity;

                        product.TrySave(typeof(MELib.Products.ProductList));
                        temp.Add(basket);

                        if (temp.IsValid)
                        {

                            var SaveResult = temp.TrySave();
                            if (SaveResult.Success)
                            {
                                sr.Data = SaveResult.SavedObject;
                                sr.Success = true;
                            }
                            else
                            {
                                sr.ErrorText = SaveResult.ErrorText;
                                sr.Success = false;
                            }
                        }
                        else
                        {
                            sr.ErrorText = "Oops! Something Went Wrong.Try Again";
                            sr.Success = false;
                        }
                    }
                    else
                    {
                        sr.ErrorText = "Enter Product Quantity ...!";
                        // temp.TrySave();
                        sr.Success = false;
                    }


                }

            }
            catch (Exception e)
            {
                sr.ErrorText = "Can't add to Basket!";
                sr.Success = false;

            }
            return sr;
        }

        [WebCallable]
        public Result FilterProducts(int CategoryID)
        {
            Result sr = new Result();
            try
            {
                //sr.Data = MELib.Categories.CategoryList.GetCategoryList();
                var Products = MELib.Products.ProductList.GetProductCategorySpecificList(CategoryID);
                sr.Data = Products;
                sr.Success = true;
            }
            catch (Exception e)
            {
                WebError.LogError(e, "Page: Products.aspx | Method: FilterProducts", $"(int CategoryID, ({CategoryID})");
                sr.Data = e.InnerException;
                sr.ErrorText = "Could not filter Products by category.";
                sr.Success = false;
            }
            return sr;
        }
    }
}

