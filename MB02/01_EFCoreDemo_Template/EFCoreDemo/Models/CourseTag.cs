﻿using System;
using System.Collections.Generic;
using System.Text;

namespace EFCoreDemo.Models {
    public class CourseTag {
        public int CourseId{ get; set; }
        public virtual Course Course { get; set; }

        public int TagId { get; set; }
        public virtual Tag Tag { get; set; }
    }
}
