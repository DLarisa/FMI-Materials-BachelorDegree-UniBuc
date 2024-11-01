using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProiectDAW.Models;

namespace ProiectDAW.Controllers
{
    [Authorize(Roles = "Admin")]
    public class UserController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: User
        public ActionResult Index()
        {
            ViewBag.UsersList = db.Users.OrderBy(u => u.UserName).ToList();

            return View();
        }


        // Delete
        [HttpDelete]
        public ActionResult Delete(string id)
        {
            if (String.IsNullOrEmpty(id))
            {
                return HttpNotFound("Missing the id parameter!");
            }

            ApplicationUser user = db.Users.Find(id);

            if (user == null)
            {
                return HttpNotFound("Nu s-a găsit filmul cu id-ul " + id.ToString() + "!");
            }
            db.Users.Remove(user);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}