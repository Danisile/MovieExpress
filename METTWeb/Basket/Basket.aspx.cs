using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;
using Singular;
using System.ComponentModel.DataAnnotations;
using MELib.Basket;
using MELib.Products;
using MELib.Accounts;
using MEWeb.Profile;
using MELib.Orders;
using MELib.Transaction;
using MELib.Delivery;

namespace MEWeb.Basket
{
    public partial class Basket : MEPageBase<BasketVM>
    {
        public static int Quantity { get; set; }
        public static string ProductName { get; set; }
    }
    public class BasketVM : MEStatelessViewModel<BasketVM>
    {
        public BasketList BasketList { get; set; }
        public ProductList ProductList { get; set; }
        public AccountList AccountList { get; set; }
        public string ProductName { get; set; }
        public string ProductQuantity { get; set; }
        public decimal TotalSum { get; set; }
        public MELib.Accounts.Account Buy { get; set; }
        public MELib.Transaction.TransactionList Transactions { set; get; }
        public int UserID { get; set; }
        public MELib.Delivery.Delivery Delivery { set; get; }
        public decimal UserBalance { get; set; }
        public decimal Walletlist { get; set; }
        public MELib.Delivery.DeliveryList DeliveryList { get; set; }
        public int Quantity { get; set; }
        public int ProductID { get; set; }
        //public int BasketID { get; set; }

      [Singular.DataAnnotations.DropDownWeb(typeof(MELib.Delivery.DeliveryList), UnselectedText = "Delivey Option", ValueMember = "DeliveryID", DisplayMember = "DeliveryOption")]
       [Display(Name = "Delivery")]

       public int? DeliveryID { get; set; }


        public BasketVM()
        {
        }

        protected override void Setup()
        {
            base.Setup();
            BasketList = BasketList.GetBasketList();
            ProductList = ProductList.GetProductList();
            AccountList = AccountList.GetAccountList();
            Transactions= TransactionList.GetTransactionList();
           // DeliveryList = DeliveryList.GetDeliveryList();
            Buy = AccountList.FirstOrDefault();
            TotalSum = BasketList.GetBasketList().Sum(x => x.BasketBalance);

           Walletlist = BasketList.GetBasketList().Sum(x => x.Quantity);
           //DeliveryList = DeliveryList.GetDeliveryList().FirstOrDefault();

        }

        [WebCallable]
        public Result Purchase(decimal TotalSum, int DeliveryID, BasketList BasketList, ProductList ProductList)
        {
            Result sr = new Result();

            try
            {

                UserBalance = MELib.Accounts.AccountList.GetAccountList(UserID).Select(x => x.Balance).FirstOrDefault();
               // DeliveryID = MELib.Delivery.DeliveryList.GetDeliveryList().Select(c => c.DeliveryID).FirstOrDefault();

                //Check If Basket is Not Empty.
                if (BasketList.Count == 0)
                {
                    sr.Success = false;
                    sr.ErrorText = "The Basket is Empty Go to products!";
                    return sr;
                }


                if (UserBalance >= TotalSum)
                { 
                 //Save Basket
                        BasketList.ToList().ForEach(c => { c.IsActiveInd = false; });
                        BasketList.TrySave();
                        ProductList.TrySave();

                 // Delivery Options

                    if (DeliveryID == 2)
                    {
                   
                        TotalSum = TotalSum + 30;

                   }

                 //Balance Reduced
                    var BalanceCheckout = UserBalance - TotalSum;
                        AccountList = AccountList.GetAccountList();
                        AccountList.ToList().ForEach(f => f.Balance = BalanceCheckout);
                        AccountList.TrySave();

                  //Transactions List
                        var transaction = new MELib.Transaction.Transaction();

                        transaction.UserID = Settings.CurrentUser.UserID;
                        transaction.Amount = TotalSum;
                        transaction.TransactionTypeID = 1;
                        transaction.Description = "Purchase";
                        transaction.TrySave(typeof(TransactionList));

                        sr.Success = true;
                    }
                
                else
                {
                    sr.Success = false;
                    sr.ErrorText = "Insufficiant Funds Please Deposit  Money into your Account ..! ";
                }

            }
            catch (Exception e)
            {
                sr.Data = e.InnerException;
                sr.Success = false;

            }

            return sr;
        }

        [WebCallable]
        public Result DeleteBasket(BasketList CartList)
        {
            Result sr = new Result();
            try
            {

                BasketList = MELib.Basket.BasketList.GetBasketList();
                BasketList.Clear();
                BasketList.TrySave();
                sr.Success = true;

            }

            catch (Exception e)
            {
                sr.Data = e.InnerException;
                sr.Success = true;

            }
            return sr;
        }
        [WebCallable]
        public Result UpdateBasket(int ProductID, BasketList BasketList, ProductList productList)
        {
            Result sr = new Result();

            // Update Basket Quantity.


            var product = productList.GetItem(ProductID);

            var Basket = BasketList.Single(x => x.ProductID == ProductID);

            Basket.BasketBalance = product.ProductPrice * Basket.Quantity;

            if (Basket.Quantity > product.ProductQuantity)
            {
                sr.Success = false;
                sr.ErrorText = "Sorry only " + product.ProductQuantity.ToString() + " left In Stock";
                return sr;
            }

            if (BasketList.IsValid)
            {
                var SaveResult = BasketList.TrySave();
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
                return sr;
            }
            else
            {
                sr.ErrorText = ProductList.GetErrorsAsHTMLString();
                return sr;
            }
        }
        public Result DeleteItem(int BasketID)
        {
            Result sr = new Result();
            try
            {
                if (BasketID != 0)
                {
                    BasketList = BasketList.GetBasketList();
                    var temp = BasketList.Single(x => x.BasketID == BasketID);
                    BasketList.Remove(temp);

                    BasketList.TrySave();
                    sr.Success = true;
                }
            }

            catch (Exception e)
            {
                sr.Data = e.InnerException;
                sr.Success = true;

            }
            return sr;
        }

    }
}