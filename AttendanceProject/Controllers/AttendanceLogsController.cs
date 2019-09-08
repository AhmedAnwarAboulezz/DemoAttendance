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
    public class AttendanceLogsController : Controller
    {
        private AttendanceEntities db = new AttendanceEntities();

        // GET: AttendanceLogs
        public ActionResult Index()
        {
            var attendanceLogs = db.AttendanceLogs.Where(a=>a.FileRefrence.IsActive == 1).Include(a => a.AttMachineTableRefrence).Include(a => a.Employee);
            return View(attendanceLogs.ToList());
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
