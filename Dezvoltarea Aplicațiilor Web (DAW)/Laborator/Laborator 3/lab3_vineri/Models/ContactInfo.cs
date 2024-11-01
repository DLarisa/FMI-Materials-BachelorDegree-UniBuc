using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace lab3_vineri.Models
{
    [Table("Contacts")] // modifica denumirea tabelului din BD
    public class ContactInfo
    {
        // EF marcheaza proprietatea GenreId ca fiind o cheie primara by default deorece respecta "naming convention" 
        public int ContactInfoId { get; set; }
        public string PhoneNumber { get; set; }

        // one to one
        [Required] // OBLIGATORIU pt relatie one-to-many
        public virtual Publisher Publisher { get; set; }
    }
}