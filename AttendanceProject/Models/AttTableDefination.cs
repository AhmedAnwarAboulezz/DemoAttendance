//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AttendanceProject.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class AttTableDefination
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public AttTableDefination()
        {
            this.AttMachineTableRefrences = new HashSet<AttMachineTableRefrence>();
        }
    
        public int TableId { get; set; }
        public Nullable<int> SenarioID { get; set; }
        public string ColumnDefination { get; set; }
        public string ColumnOrder { get; set; }
        public Nullable<int> IsDeleted { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<AttMachineTableRefrence> AttMachineTableRefrences { get; set; }
        public virtual Senario Senario { get; set; }
    }
}
