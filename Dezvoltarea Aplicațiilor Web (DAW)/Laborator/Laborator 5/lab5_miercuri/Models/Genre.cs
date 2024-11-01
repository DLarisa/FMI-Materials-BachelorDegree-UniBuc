using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace lab3_miercuri.Models
{
    public class Genre
    {
        public int GenreId { get; set; }

        [MinLength(3, ErrorMessage = "Genre name cannot be less than 3!"),
        MaxLength(20, ErrorMessage = "Genre name cannot be more than 20!")]
        public string Name { get; set; }

        // many-to-many relationship
        public virtual ICollection<Book> books { get; set; }
    }
}