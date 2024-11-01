using lab3_miercuri.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using lab3_miercuri.Models.MyDatabaseInitializer;

namespace lab3_miercuri.Controllers
{
    public class BookController : Controller
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
            book.BookTypeList = GetAllBookTypes();
            book.PublisherList = GetAllPublishers();
            book.GenresList = GetAllGenres();
            book.Genres = new List<Genre>();
            return View(book);
        }

        [HttpPost]
        public ActionResult New(Book bookRequest)
        {
            bookRequest.BookTypeList = GetAllBookTypes();
            bookRequest.PublisherList = GetAllPublishers();

            // memoram intr-o lista doar genurile care au fost selectate
            var selectedGenres = bookRequest.GenresList.Where(b => b.Checked).ToList();
            try
            {
                if (ModelState.IsValid)
                {
                    bookRequest.Genres = new List<Genre>();
                    for(int i = 0; i < selectedGenres.Count(); i++)
                    {
                        // cartii pe care vrem sa o adaugam in baza de date ii 
                        // asignam genurile selectate 
                        Genre genre = db.Genres.Find(selectedGenres[i].Id);
                        bookRequest.Genres.Add(genre);
                    }
                    db.Books.Add(bookRequest);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View(bookRequest);
            }
            catch(Exception e)
            {
                var msg = e.Message;
                return View(bookRequest);
            }
        }

        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (id.HasValue)
            {
                Book book = db.Books.Find(id);
                book.BookTypeList = GetAllBookTypes();
                book.PublisherList = GetAllPublishers();
                book.GenresList = GetAllGenres();

                foreach(Genre checkedGenre in book.Genres)
                {   // iteram prin genurile care erau atribuite cartii inainte de momentul accesarii formularului
                    // si le selectam/bifam  in lista de checkbox-uri
                    book.GenresList.FirstOrDefault(g => g.Id == checkedGenre.GenreId).Checked = true;
                }
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
            bookRequest.BookTypeList = GetAllBookTypes();
            bookRequest.PublisherList = GetAllPublishers();

            // preluam cartea pe care vrem sa o modificam din baza de date
            Book book = db.Books.Include("Publisher").Include("BookType")
                        .SingleOrDefault(b => b.BookId.Equals(id));

            // memoram intr-o lista doar genurile care au fost selectate din formular
            var selectedGenres = bookRequest.GenresList.Where(b => b.Checked).ToList();
            try
            {
                if (ModelState.IsValid)
                {
                    if (TryUpdateModel(book))
                    {
                        book.Title = bookRequest.Title;
                        book.Author = bookRequest.Author;
                        book.Summary = bookRequest.Summary;
                        book.NoOfPages = bookRequest.NoOfPages;
                        book.PublisherId = bookRequest.PublisherId;
                        book.BookTypeId = bookRequest.BookTypeId;

                        book.Genres.Clear();
                        book.Genres = new List<Genre>();

                        for (int i = 0; i < selectedGenres.Count(); i++)
                        {
                            // cartii pe care vrem sa o editam ii asignam genurile selectate 
                            Genre genre = db.Genres.Find(selectedGenres[i].Id);
                            book.Genres.Add(genre);
                        }
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

        [NonAction]
        public List<CheckBoxViewModel> GetAllGenres()
        {
            var checkboxList = new List<CheckBoxViewModel>();
            foreach (var genre in db.Genres.ToList())
            {
                checkboxList.Add(new CheckBoxViewModel
                {
                    Id = genre.GenreId,
                    Name = genre.Name,
                    Checked = false
                });
            }
            return checkboxList;
        }

        [NonAction]
        public IEnumerable<SelectListItem> GetAllBookTypes()
        {
            var selectList = new List<SelectListItem>();
            foreach(var cover in db.BookTypes.ToList())
            {
                selectList.Add(new SelectListItem
                {
                    Value = cover.BookTypeId.ToString(),
                    Text = cover.Name
                }) ; 
            }
            return selectList;
        }

        [NonAction]
        public IEnumerable<SelectListItem> GetAllPublishers()
        {
            var selectList = new List<SelectListItem>();
            foreach (var publisher in db.Publishers.ToList())
            {
                selectList.Add(new SelectListItem
                {
                    Value = publisher.PublisherId.ToString(),
                    Text = publisher.Name
                });
            }
            return selectList;
        }
    }
}