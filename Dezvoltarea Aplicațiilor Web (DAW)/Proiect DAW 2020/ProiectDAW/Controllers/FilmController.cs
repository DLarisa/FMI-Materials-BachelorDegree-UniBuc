using System;
using System.Collections.Generic;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProiectDAW.Models;

namespace ProiectDAW.Controllers
{
    public class FilmController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: Film
        public ActionResult Index()
        {
            List<Film> filme = db.Filme.Include("GenFilme").ToList();
            ViewBag.Filme = filme;

            return View();
        }

        // GET: Detalii
        public ActionResult Detalii(int? id)
        {
            if (id.HasValue)
            {
                Film film = db.Filme.Find(id);

                if (film != null)
                {
                    return View(film);
                }
                return HttpNotFound("Nu am putut găsi filmul id-ul " + id.ToString());
            }
            return HttpNotFound("Lipsește id-ul Filmului!");
        }



        // Create
        [HttpGet]
        public ActionResult New()
        {
            Film film = new Film();
            film.LimbaFilmList = GetAllLimbaFilme();
            film.DirectorList = GetAllDirectorList();
            film.GenFilmList = GetAllGenFilme();
            film.GenFilme = new List<GenFilm>();
            return View(film);
        }
        [HttpPost]
        public ActionResult New(Film film)
        {
            try
            {
                film.LimbaFilmList = GetAllLimbaFilme();
                film.DirectorList = GetAllDirectorList();

                // memorez într-o listă doar Genurile de Filme care au fost Selectate
                var selected = film.GenFilmList.Where(f => f.Checked).ToList();
                if (ModelState.IsValid)
                {
                    film.GenFilme = new List<GenFilm>();
                    for(int i = 0; i < selected.Count(); i++)
                    {
                        // filmului pe care vrem să-l adăugăm în bd, îi asigur genurile selectate
                        GenFilm gen = db.GenFilme.Find(selected[i].Id);
                        film.GenFilme.Add(gen);
                    }
                    film.LimbaFilm = db.LimbaFilme.FirstOrDefault(p => p.LimbaId.Equals(1));
                    film.Director = db.Directori.FirstOrDefault(p => p.DirectorId.Equals(1));
                    db.Filme.Add(film);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                return View(film);
            }
            catch (Exception e) { return View(film); }
        }
        // Iau Toate Limbile
        [NonAction]
        public IEnumerable<SelectListItem> GetAllLimbaFilme()
        {
            var selectList = new List<SelectListItem>();

            foreach (var lb in db.LimbaFilme.ToList())
            {
                selectList.Add(new SelectListItem
                {
                    Value = lb.LimbaId.ToString(),
                    Text = lb.Nume
                });
            }
            return selectList;
        }
        // Iau Toți Directorii
        [NonAction]
        public IEnumerable<SelectListItem> GetAllDirectorList()
        {
            var selectList = new List<SelectListItem>();

            foreach (var d in db.Directori.ToList())
            {
                selectList.Add(new SelectListItem
                {
                    Value = d.DirectorId.ToString(),
                    Text = d.Nume + " " + d.Prenume
                });
            }
            return selectList;
        }
        // Iau toate Genurile de Film
        [NonAction]
        public List<CheckBoxViewModel> GetAllGenFilme()
        {
            var checkboxList = new List<CheckBoxViewModel>();
            
            foreach(var gen in db.GenFilme.ToList())
            {
                checkboxList.Add(new CheckBoxViewModel
                {
                    Id = gen.GenId,
                    Nume = gen.Nume,
                    Checked = false
                });
            }
            return checkboxList;
        }



        // Delete
        [HttpDelete]
        public ActionResult Delete(int? id)
        {
            if (id.HasValue)
            {
                Film f = db.Filme.Find(id);
                if (f == null)
                {
                    return HttpNotFound("Nu s-a găsit filmul cu id-ul " + id.ToString() + "!");
                }
                db.Filme.Remove(f);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return HttpNotFound("Lipsește parametrul id al Filmului!");
        }



        // Edit
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (id.HasValue)
            {
                Film film = db.Filme.Find(id);
                if (film == null) return HttpNotFound("Nu am putut găsi filmul cu Id-ul " + id.ToString());

                film.LimbaFilmList = GetAllLimbaFilme();
                film.DirectorList = GetAllDirectorList();
                film.GenFilmList = GetAllGenFilme();

                foreach (GenFilm checkedGen in film.GenFilme)
                {    // iteram prin genurile care erau atribuite cartii inainte de momentul accesarii formularului
                    // si le selectam/bifam  in lista de checkbox-uri
                    film.GenFilmList.FirstOrDefault(g => g.Id == checkedGen.GenId).Checked = true;
                }

                return View(film);
            }
            return HttpNotFound("Lipseste parametrul Id al filmului!");
        }
        [HttpPut]
        public ActionResult Edit(int id, Film filmRequested)
        {
            try
            {
                filmRequested.LimbaFilmList = GetAllLimbaFilme();
                filmRequested.DirectorList = GetAllDirectorList();

                // preiau filmul pe care vreau să îl modific din bd (relații 1:m)
                Film film = db.Filme.Include("Director").Include("LimbaFilm").SingleOrDefault(f => f.FilmId.Equals(id));

                // memoram intr-o lista doar genurile care au fost selectate din formular
                var selected = filmRequested.GenFilmList.Where(f => f.Checked).ToList();

                if (ModelState.IsValid)
                {
                    if (TryUpdateModel(film))
                    {
                        film.Nume = filmRequested.Nume;
                        film.An = filmRequested.An;
                        film.Descriere = filmRequested.Descriere;
                        film.NrPremii = filmRequested.NrPremii;
                        film.DirectorId = filmRequested.DirectorId;
                        film.LimbaId = filmRequested.LimbaId;

                        film.GenFilme.Clear();
                        film.GenFilme = new List<GenFilm>();
                        for (int i = 0; i < selected.Count(); i++)
                        {
                            // cartii pe care vrem sa o editam ii asignam genurile selectate 
                            GenFilm gen = db.GenFilme.Find(selected[i].Id);
                            film.GenFilme.Add(gen);
                        }

                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
                return View(filmRequested);
            }
            catch (Exception e)
            {
                return View(filmRequested);
            }
        }
    }
}