using lab7.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace lab7.Controllers
{
    public class BooksController : ApiController
    {
        private DbCtx ctx = new DbCtx();

        // asemanatoare cu actiunea Index pe care o foloseam in proiectele MVC
        public List<Book> Get()
        {
            return ctx.Books.ToList();
        }

        // asemanatoare cu actiunea Details pe care o foloseam in proiectele MVC
        public IHttpActionResult Get(int id)
        {
            Book book = ctx.Books.Find(id);
            if (book == null)
                // returneaza codul 404
                return NotFound();

            // returneaza codul de succes 200, iar in body vor fi memorate datele obiectului book 
            return Ok(book);
        }

        // asemanatoare cu actiunea New pe care o foloseam in proiectele MVC
        public IHttpActionResult Post([FromBody] Book book)
        {
            ctx.Books.Add(book);
            ctx.SaveChanges();

            // helperul Created contine, pe lânga obiectul nou-creat, si adresa la care el va fi gasit
            var uri = new Uri(Url.Link("DefaultApi", new { id = book.BookId }));
            return Created(uri, book);
        }

        // asemanatoare cu actiunea Edit pe care o foloseam in proiectele 
        public IHttpActionResult Put(int id, [FromBody] Book b)
        {
            Book book = ctx.Books.Find(id);

            if (book == null)
                return NotFound();

            book.Title = b.Title;
            book.Author = b.Author;
            ctx.SaveChanges();
            return Ok(book);
        }

        public IHttpActionResult Delete(int id)
        {
            Book book = ctx.Books.Find(id);

            if (book == null)
                return NotFound();

            ctx.Books.Remove(book);
            ctx.SaveChanges();
            return Ok(book);
        }
    }

}
