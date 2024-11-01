using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace lab3_vineri.Models
{
    public class Publisher
    {
        // EF marcheaza proprietatea GenreId ca fiind o cheie primara by default deorece respecta "naming convention" 
        public int PublisherId { get; set; }
        public string Name { get; set; }

        // many to one
        public virtual ICollection<Book> books { get; set; }

        // one to one
        public virtual ContactInfo ContactInfo { get; set; }
    }
}