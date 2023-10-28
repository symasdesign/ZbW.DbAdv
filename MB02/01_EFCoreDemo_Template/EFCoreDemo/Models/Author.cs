using System;
using System.Collections.Generic;
using System.Text;

namespace EFCoreDemo.Models {
    public class Author {
        public int Id { get; set; }
        public string Name { get; set; }
        public string? Phone { get; set; }
        public virtual ICollection<Course> Courses { get; set; }
    }

}
