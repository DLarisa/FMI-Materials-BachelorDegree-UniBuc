using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Diagnostics;
using System.Web.Routing;

namespace lab7_vineri.Models
{
    public class TheFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext) {
            Log("OnActionExecuting", filterContext.RouteData, filterContext.HttpContext.Request);
        }

        public override void OnActionExecuted(ActionExecutedContext filterContext) {
            var model = ((ViewResultBase)filterContext.Result).Model;
            
            Log("OnActionExecuted", filterContext.RouteData, filterContext.HttpContext.Request);
            Debug.WriteLine(model.ToString(), "Model Type");
        }

        public override void OnResultExecuting(ResultExecutingContext filterContext) {
            Log("OnResultExecuting", filterContext.RouteData, filterContext.HttpContext.Request);
        }

        public override void OnResultExecuted(ResultExecutedContext filterContext)
        {
            Log("OnResultExecuted", filterContext.RouteData, filterContext.HttpContext.Request);
        }

        // vom crea metoda Log care ne afiseaza in consola de debug un mesaj
        private void Log(string methodName, RouteData routeData, HttpRequestBase request)
        {
            var controllerName = routeData.Values["controller"];
            var actionName = routeData.Values["action"];

            var url = request.Url;
            var hostAddress = request.UserHostAddress;
            var agent = request.UserAgent;

            var message = String.Format("{0} host address:{1} url:{2} user agent:{3} controller:{4} action:{5} ", 
                methodName, hostAddress, url, agent,controllerName, actionName);
            
            Debug.WriteLine(message, "Action Filter Log");
        }
    }
}