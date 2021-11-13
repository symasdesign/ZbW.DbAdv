using System;
using System.Collections.Generic;
using System.Text;

namespace EFCoreDemo.Models {
    public class Author {
#nullable enable
        public int Id { get; set; }
        public string Name { get; set; }
        public string? City { get; set; }
        public string? Phone { get; set; }
#nullable disable
        public virtual ICollection<Course> Courses { get; set; }
    }

}
