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
    
    public partial class MEMBER_ASSIGN
    {
        public long ID { get; set; }
        public Nullable<long> MEMBER_ID { get; set; }
        public Nullable<long> MEMBER_PARENT_ACC_ID { get; set; }
        public Nullable<long> ACC_ID { get; set; }
    
        public virtual CHART_ACCOUNT CHART_ACCOUNT { get; set; }
    }
}
