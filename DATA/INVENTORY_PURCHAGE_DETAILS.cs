//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DATA
{
    using System;
    using System.Collections.Generic;
    
    public partial class INVENTORY_PURCHAGE_DETAILS
    {
        public int Id { get; set; }
        public string InvoiceNo { get; set; }
        public Nullable<System.DateTime> PurchaseDate { get; set; }
        public string PurchaserInfo { get; set; }
        public string ProductName { get; set; }
        public Nullable<int> ProductId { get; set; }
        public Nullable<decimal> NumberOfProduct { get; set; }
        public Nullable<decimal> EveryPackQuantity { get; set; }
        public Nullable<decimal> ExtraQuantity { get; set; }
        public Nullable<decimal> SalableQuantity { get; set; }
        public Nullable<decimal> ItemPrice { get; set; }
        public Nullable<decimal> TotalPrice { get; set; }
        public string SystemSerialNo { get; set; }
    
        public virtual INVENTORY_PRODUCT_MASTER_ENTRY_INVENTORY INVENTORY_PRODUCT_MASTER_ENTRY_INVENTORY { get; set; }
    }
}
