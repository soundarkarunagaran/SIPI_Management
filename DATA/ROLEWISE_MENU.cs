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
    
    public partial class ROLEWISE_MENU
    {
        public long ID { get; set; }
        public Nullable<int> MODULE_ID { get; set; }
        public long USER_GROUP_ID { get; set; }
        public string PARENT_MENU_NAME { get; set; }
        public string PARENT_MENU_CONTENT { get; set; }
        public string CHILD_MENU_NAME { get; set; }
        public string CHILD_MENU_CONTENT { get; set; }
    
        public virtual MODULE_PERMISSION MODULE_PERMISSION { get; set; }
        public virtual USER_GROUP USER_GROUP { get; set; }
    }
}
