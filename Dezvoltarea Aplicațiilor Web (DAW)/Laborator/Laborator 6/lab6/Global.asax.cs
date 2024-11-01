using lab6.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace lab6
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
			// in cazul in care adaugam in baza de date si alte tabele pe langa cele specifice utilizatorilor
			// trebuie sa specificam modalitatea de initializare a bazei de date
			//Database.SetInitializer<ApplicationDbContext>(new DropCreateDatabaseIfModelChanges<ApplicationDbContext>());
            
			AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}
