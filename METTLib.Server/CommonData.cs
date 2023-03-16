using System;
using Singular.CommonData;

namespace MELib
{
    public class CommonData : CommonDataBase<MELib.CommonData.MECachedLists>
    {
        [Serializable]
        public class MECachedLists : CommonDataBase<MECachedLists>.CachedLists
        {
            /// <summary>
            /// Gets cached ROUserList
            /// </summary>
            public MELib.RO.ROUserList ROUserList
            {
                get
                {
                    return RegisterList<MELib.RO.ROUserList>(Misc.ContextType.Application, c => c.ROUserList, () => { return MELib.RO.ROUserList.GetROUserList(); });
                }
            }
            /// <summary>
            /// Gets cached ROMovieGenreList
            /// </summary>
            public RO.ROMovieGenreList ROMovieGenreList
            {
                get
                {
                    return RegisterList<MELib.RO.ROMovieGenreList>(Misc.ContextType.Application, c => c.ROMovieGenreList, () => { return MELib.RO.ROMovieGenreList.GetROMovieGenreList(); });
                }
            }
            public RO.ROProductList ROProductList
            {
                get
                {
                    return RegisterList<MELib.RO.ROProductList>(Misc.ContextType.Application, c => c.ROProductList, () => { return MELib.RO.ROProductList.GetROProductList(); });
                }
            }

            public RO.ROCategoryList ROCategoryList
            {
                get
                {
                    return RegisterList<MELib.RO.ROCategoryList>(Misc.ContextType.Application, c => c.ROCategoryList, () => { return MELib.RO.ROCategoryList.GetROCategoryList(); });
                }
            }

            public MELib.Transaction.TransactionTypeList TransactionTypeList
            {
                get
                {
                    return RegisterList<MELib.Transaction.TransactionTypeList>(Misc.ContextType.Application, c => c.TransactionTypeList, () => { return MELib.Transaction.TransactionTypeList.GetTransactionTypeList(); });
                }
            }

            public MELib.Categories.CategoryList CategoryList
            {
                get
                {
                    return RegisterList<MELib.Categories.CategoryList>(Misc.ContextType.Application, c => c.CategoryList, () => { return MELib.Categories.CategoryList.GetCategoryList(); });
                }
            }

            public MELib.Delivery.DeliveryList DeliveryList
            {
                get
                {
                    return RegisterList<MELib.Delivery.DeliveryList>(Misc.ContextType.Application, c => c.DeliveryList, () => { return MELib.Delivery.DeliveryList.GetDeliveryList(); });
                }
            }


        }
    }

    public class Enums
    {
        public enum AuditedInd
        {
            Yes = 1,
            No = 0
        }
        public enum DeletedInd
        {
            Yes = 1,
            No = 0
        }
    }
}
