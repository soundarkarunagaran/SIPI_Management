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
    
    public partial class SCHOOL_FEES_COLLECTION
    {
        public int Id { get; set; }
        public Nullable<int> FeesItemId { get; set; }
        public string FeesItemTitel { get; set; }
        public string FeesItemTitelBangla { get; set; }
        public Nullable<System.DateTime> DateOfFeesCollection { get; set; }
        public Nullable<int> Year { get; set; }
        public Nullable<int> ClassId { get; set; }
        public string ClassName { get; set; }
        public Nullable<decimal> Amount { get; set; }
        public Nullable<decimal> TotalBySlip { get; set; }
        public Nullable<int> PaySlipNo { get; set; }
        public string Status { get; set; }
        public Nullable<int> StudentId { get; set; }
        public string StudentName { get; set; }
        public string StudentNameBangla { get; set; }
        public Nullable<decimal> TotalAmount { get; set; }
    
        public virtual ADMISSIONINFO ADMISSIONINFO { get; set; }
        public virtual FEESDETAIL FEESDETAIL { get; set; }
        public virtual SIPI_DEPARTMENT SIPI_DEPARTMENT { get; set; }
    }
}
