using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using AttendanceProject.Models;

namespace AttendanceProject.Controllers
{
    public class SenariosController : Controller
    {
        private AttendanceEntities db = new AttendanceEntities();

        // GET: Senarios
        public ActionResult Index()
        {
            return View(db.AttTableDefinations.ToList());
        }


 





        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
