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
    
    public partial class PROGRAM
    {
        public PROGRAM()
        {
            this.ROUTINEGROUPs = new HashSet<ROUTINEGROUP>();
        }
    
        public int Id { get; set; }
        public Nullable<int> DepartmentId { get; set; }
        public string ProgramName { get; set; }
        public string ProgramCode { get; set; }
        public string BanglaProgram { get; set; }
    
        public virtual DEPARTMENT DEPARTMENT { get; set; }
        public virtual ICollection<ROUTINEGROUP> ROUTINEGROUPs { get; set; }
    }
}
