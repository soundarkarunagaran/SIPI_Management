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
    
    public partial class STUDENTFEESCOLLECTION
    {
        public int Id { get; set; }
        public Nullable<int> StudentPKId { get; set; }
        public Nullable<int> SemesterId { get; set; }
        public Nullable<int> Year { get; set; }
        public Nullable<int> ReceiveableAmount { get; set; }
        public Nullable<int> ReceiveAmount { get; set; }
        public Nullable<int> DueAmount { get; set; }
        public Nullable<System.DateTime> ReceiveDate { get; set; }
    
        public virtual ADMISSIONINFO ADMISSIONINFO { get; set; }
        public virtual SEMESTER SEMESTER { get; set; }
    }
}
