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
    
    public partial class ADMISSIONOFFICE
    {
        public int Id { get; set; }
        public string OfficeName { get; set; }
        public int CampusId { get; set; }
    
        public virtual CAMPUSINFO CAMPUSINFO { get; set; }
    }
}
