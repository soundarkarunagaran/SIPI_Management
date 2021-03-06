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
    
    public partial class CHART_ACCOUNT
    {
        public CHART_ACCOUNT()
        {
            this.BALANCE_SHEET_CONFIGURE = new HashSet<BALANCE_SHEET_CONFIGURE>();
            this.CUSTOMER_EMPLOYEE_SETUP = new HashSet<CUSTOMER_EMPLOYEE_SETUP>();
            this.DEPOSIT_PAYMENT = new HashSet<DEPOSIT_PAYMENT>();
            this.DEPRICIATION_SETUP = new HashSet<DEPRICIATION_SETUP>();
            this.INCOME_SHEET_CONFIGURE = new HashSet<INCOME_SHEET_CONFIGURE>();
            this.JOURNAL_VOUCHAR = new HashSet<JOURNAL_VOUCHAR>();
            this.MEMBER_ACC_TYPE = new HashSet<MEMBER_ACC_TYPE>();
            this.MEMBER_ASSIGN = new HashSet<MEMBER_ASSIGN>();
        }
    
        public long CHART_ACC_ID { get; set; }
        public string CHART_ACC_CODE { get; set; }
        public Nullable<long> CHART_ACC_PARENT_ID { get; set; }
        public string CHART_ACC_PARENT_TYPE { get; set; }
        public string CHART_ACC_NAME { get; set; }
        public Nullable<decimal> CHART_ACC_OPENING_BALANCE_DR { get; set; }
        public Nullable<decimal> CHART_ACC_OPENING_BALANCE_CR { get; set; }
        public string CHART_ACC_HEADER { get; set; }
        public string CHART_ACC_STATUS { get; set; }
        public Nullable<System.DateTime> CHART_ACC_CREATION_DATE { get; set; }
        public string ACCESS_BY { get; set; }
        public Nullable<System.DateTime> ACCESS_DATE { get; set; }
    
        public virtual ICollection<BALANCE_SHEET_CONFIGURE> BALANCE_SHEET_CONFIGURE { get; set; }
        public virtual ICollection<CUSTOMER_EMPLOYEE_SETUP> CUSTOMER_EMPLOYEE_SETUP { get; set; }
        public virtual ICollection<DEPOSIT_PAYMENT> DEPOSIT_PAYMENT { get; set; }
        public virtual ICollection<DEPRICIATION_SETUP> DEPRICIATION_SETUP { get; set; }
        public virtual ICollection<INCOME_SHEET_CONFIGURE> INCOME_SHEET_CONFIGURE { get; set; }
        public virtual ICollection<JOURNAL_VOUCHAR> JOURNAL_VOUCHAR { get; set; }
        public virtual ICollection<MEMBER_ACC_TYPE> MEMBER_ACC_TYPE { get; set; }
        public virtual ICollection<MEMBER_ASSIGN> MEMBER_ASSIGN { get; set; }
    }
}
