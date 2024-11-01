using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace lab3_vineri.Models
{
    public class Genre
    {   // EF marcheaza proprietatea GenreId ca fiind o cheie primara by default deorece respecta "naming convention" 
        public int GenreId { get; set; }

        public string Name { get; set; }

        // many to many
        public virtual ICollection<Book> books { get; set; }
    }
}