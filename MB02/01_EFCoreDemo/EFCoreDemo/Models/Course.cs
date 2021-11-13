using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace EFCoreDemo.Models {
    public class Course {
        // Id oder CourseId wird autom. zum PK oder [Key]
        public int Id { get; set; }
        [Required]
        public string Title { get; set; }
        public string Description { get; set; }
        public CourseLevel Level { get; set; }
        [Column(TypeName = "decimal(7,2)")]
        public decimal FullPrice { get; set; }
        public virtual Author Author { get; set; }
        public int AuthorId { get; set; }
        public virtual ICollection<CourseTag> CourseTags { get; set; }
        public virtual Category Category {get; set;} 

    }
}
