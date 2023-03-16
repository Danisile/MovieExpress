using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Singular.Web;
using MELib.Transaction;
using System.ComponentModel.DataAnnotations;
using Singular;

namespace MEWeb.Profile
{
    public partial class Transactions : MEPageBase<TransactionsVM>
    {
    }
    public class TransactionsVM : MEStatelessViewModel<TransactionsVM>
    {
        public MELib.Transaction.TransactionList Transactions { get; set; }
        public MELib.Transaction.TransactionTypeList TransactionTypeList { get; set; }


        [Singular.DataAnnotations.DropDownWeb(typeof(TransactionTypeList), UnselectedText = "Select", ValueMember = "TransactionTypeID", DisplayMember = "TransactionTypeName")]
        [Display(Name = "Transaction")]

        public int? TransactionTypeID { set; get; }
       
       

        public TransactionsVM()
        {

        }
        protected override void Setup()
        {
            base.Setup();
            
            Transactions = MELib.Transaction.TransactionList.GetTransactionList();
            TransactionList temp = new TransactionList();
            Transactions.UserID = Settings.CurrentUser.UserID;

        }

        [WebCallable]
        public Result FilterTransactions(int TransactionTypeID, int ResetInd)
        {
            var i = TransactionTypeID;


            Result sr = new Result();
            try
            {
                if (ResetInd == 0)
                {
                    MELib.Transaction.TransactionList Transactions = MELib.Transaction.TransactionList.GetTransactionTypeSpecificList(TransactionTypeID);
                    sr.Data = Transactions;
                }
                else
                {
                    MELib.Transaction.TransactionList Transactions = MELib.Transaction.TransactionList.GetTransactionList();
                    sr.Data = Transactions;
                }
                sr.Success = true;
            }
            catch (Exception e)
            {
                WebError.LogError(e, "Page: Transactions.aspx | Method: FilterTransactions", $"(int TransactionTypeID, ({TransactionTypeID})");
                sr.Data = e.InnerException;
                sr.ErrorText = "Could not filter Transactions";
                sr.Success = false;
            }
            return sr;
        }

    }
}

