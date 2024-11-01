using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace lab3_miercuri.Models
{
    public class Region
    {
        public int RegionId { get; set; }

        [MinLength(2, ErrorMessage = "Region name cannot be less than 2!"),
        MaxLength(50, ErrorMessage = "Region name cannot be more than 50!")]
        public string Name { get; set; }

        // many-to-one
        public virtual ICollection<ContactInfo> ContactsInfo { get; set; }
    }
}