using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace EFCoreDemo.Models {
    public class Category {
        public int Id { get; set; }
        public string Name { get; set; }
    }

}
