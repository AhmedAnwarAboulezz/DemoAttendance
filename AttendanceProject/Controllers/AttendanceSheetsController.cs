using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using AttendanceProject.Models;
using System.Text;
using System.IO;
using OfficeOpenXml;
using System.Reflection;
using System.Globalization;
using System.Threading;
using Newtonsoft.Json;
using OfficeOpenXml.Style;
//using Identity;
//using OfficeOpenXml.Style;

namespace AttendanceProject.Controllers
{
    public class AttendanceSheetsController : Controller
    {
        private AttendanceEntities db = new AttendanceEntities();

        // GET: Senarios
        public ActionResult Index()
        {
            return View(db.AttTableDefinations.ToList());
        }

        [HttpPost]
        public void Download(int TableID, int noofdays)
        {
            var EmployeeList = db.Employees.ToList();
            var Tablerecord = db.AttTableDefinations.Where(a => a.TableId == TableID).FirstOrDefault();
            var tablecolumn = Tablerecord.ColumnDefination.Split(',');
            var tableorder = Tablerecord.ColumnOrder.Split(',');

            //var allmachinesforsenario = db.AttMachineTableRefrences.Where(a => a.TableID == TableID).Select(a => a.MachineID).ToList();
            //List<AttMachine> machines = new List<AttMachine>();
            //foreach(var item in allmachinesforsenario)
            //{
            //    var machid = db.AttMachines.Where(a => a.MachId == item).FirstOrDefault();
            //    machines.Add(machid);
            //}
            //var machinetableid = db.AttMachineTableRefrences.Where(a => a.TableID == TableID).Select(a => a.Id).ToList();
            //var attendancelog = db.AttendanceLogs.ToList();


            string Code =  "EN";
            DataTable data = new DataTable();
            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Buffer = true;
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=Attendance.xlsx");

            using (ExcelPackage pack = new ExcelPackage())
            {
                ExcelWorksheet ws = pack.Workbook.Worksheets.Add("Welcome");
                #region Formatting
                for(var i=0;i < tablecolumn.Count(); i++)
                {
                    ws.Cells[1, i + 1].Value = tablecolumn[i].ToString();
                }
                ws.Cells[1, 1, 1, tablecolumn.Count()].Style.Font.Bold = true;
                ws.Cells[1, 1, 1, tablecolumn.Count()].Style.Fill.PatternType = ExcelFillStyle.Solid;
                ws.Cells[1, 1, 1, tablecolumn.Count()].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(150, 150, 150));
                #endregion
                var ms = new System.IO.MemoryStream();
                pack.SaveAs(ms);
                ms.WriteTo(Response.OutputStream);
            }

            Response.Flush();
            Response.End();

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
