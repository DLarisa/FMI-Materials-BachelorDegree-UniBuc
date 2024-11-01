using lab7_vineri.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace lab7_vineri.Controllers.subfolder
{
    public class BooksController : Controller
    {
        private DbCtx db = new DbCtx();

        [HttpGet]
        public ActionResult Index()
        {
            List<Book> books = db.Books.ToList();
            ViewBag.Books = books;
            return View();
        }


        public ActionResult Details(int? id)
        {
            if (id.HasValue)
            {
                Book book = db.Books.Find(id);
                if (book != null)
                {
                    return View(book);
                }
                return HttpNotFound("Couldn't find the book with id " + id.ToString() + "!");
            }
            return HttpNotFound("Missing book id parameter!");
        }

        [HttpGet]
        public ActionResult New()
        {
            Book book = new Book();
            return View(book);
        }

        [HttpPost]
        public ActionResult New(Book bookRequest)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    db.Books.Add(bookRequest);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View(bookRequest);
            }
            catch (Exception e)
            {
                return View(bookRequest);
            }
        }

        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (id.HasValue)
            {
                Book book = db.Books.Find(id);

                if (book == null)
                {
                    return HttpNotFound("Coludn't find the book with id " + id.ToString() + "!");
                }
                return View(book);
            }
            return HttpNotFound("Missing book id parameter!");
        }

        [HttpPut]
        public ActionResult Edit(int id, Book bookRequest)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    Book book = db.Books
                        .SingleOrDefault(b => b.BookId.Equals(id));

                    if (TryUpdateModel(book))
                    {
                        book.Title = bookRequest.Title;
                        book.Author = bookRequest.Author;
                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
                return View(bookRequest);
            }
            catch (Exception)
            {
                return View(bookRequest);
            }
        }

        [HttpDelete]
        public ActionResult Delete(int id)
        {
            Book book = db.Books.Find(id);
            if (book != null)
            {
                db.Books.Remove(book);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return HttpNotFound("Couldn't find the book with id " + id.ToString() + "!");
        }
    }
}