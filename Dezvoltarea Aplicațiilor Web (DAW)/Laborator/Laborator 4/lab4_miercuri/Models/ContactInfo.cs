using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace lab3_miercuri.Models
{
    [Table("ContactsInfo")]
    public class ContactInfo
    {
        [Key]
        public int ContactInfoId { get; set; }
        public string PhoneNumber { get; set; }

        // one-to one-relationship
        public virtual Publisher Publisher { get; set; }
    }
}