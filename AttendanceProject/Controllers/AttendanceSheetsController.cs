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

        public PartialViewResult TableTypeList()
        {
            var tabless = db.AttTableDefinations.ToList();
            return PartialView(tabless);
        }

        [HttpPost]
        public void Download(int TableID)
        {
            var EmployeeList = db.Employees.ToList();
            var Tablerecord = db.AttTableDefinations.Where(a => a.TableId == TableID).FirstOrDefault();
            var tablecolumn = Tablerecord.ColumnDefination.Split(',');
            var tableorder = Tablerecord.ColumnOrder.Split(',');
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


        [HttpPost]
        public ActionResult Upload(int? TableID,HttpPostedFileBase file, string FileDescription, string FromDate, string ToDate)
        {
            if(TableID == null)
            {
                TempData["failed"] = "Please Select a table first";
                return RedirectToAction("Index");
            }
            if (file != null)
            {
                try
                {

                    string path1 = "";
                    string filetype = Path.GetExtension(file.FileName).ToLower();

                    if (filetype == ".xlsx" || filetype == ".xls")
                    {
                        if (file.ContentLength < 102400)
                        {
                            String unique = DateTime.Now.ToString("yyyyMMddHHmmssfff");
                            string filename = Path.GetFileName(file.FileName);
                            file.SaveAs(Server.MapPath("~/Content/AttendanceFiles/") + unique + filename);
                            var path = "Content/AttendanceFiles/" + unique + filename;
                            path1 = Server.MapPath("~/Content/AttendanceFiles/") + unique + filename;
                            ViewBag.FileName = filename;
                            FileRefrence fileref = new FileRefrence();
                            fileref.FilePath = path;
                            var guidid = Guid.NewGuid().ToString().Split('-')[0];
                            fileref.FileNumber = guidid;
                            fileref.CreatedDate = DateTime.Now;
                            fileref.Comment = FileDescription;
                            db.FileRefrences.Add(fileref);
                            db.SaveChanges();
                            var fileid = fileref.Id;


                            List<AttendanceLog> myList = new List<AttendanceLog>();

                            var ColOrder = db.AttTableDefinations.Where(a => a.TableId == TableID).FirstOrDefault().ColumnOrder.Split(',');
                            using (var package = new ExcelPackage(file.InputStream))
                            {
                                var currentSheet = package.Workbook.Worksheets;
                                var workSheet = currentSheet.First();
                                var noOfCol = workSheet.Dimension.End.Column;
                                var noOfRow = workSheet.Dimension.End.Row;
                                for (int rowIterator = 2; rowIterator <= noOfRow; rowIterator++)
                                {
                                    AttendanceLog FileDtls = new AttendanceLog();
                                    if (ColOrder.Length > 0)
                                    {
                                        for (var i = 1; i <= ColOrder.Length; i++)
                                        {
                                            var colelment = int.Parse(ColOrder[i-1]);
                                            FileDtls.FileID = fileid;
                                            switch (colelment)
                                            {
                                                case 1:
                                                    var olddate = workSheet.Cells[rowIterator, i].Value.ToString();
                                                    if(olddate.Contains('/'))
                                                    {
                                                        var oDate = olddate.Split('/');
                                                        var month = oDate[1];
                                                        var day = oDate[0];
                                                        var year = oDate[2].Split(new string[] { " " }, StringSplitOptions.None)[0];
                                                        if (month.Length < 2) { month = "0" + month; }
                                                        if (day.Length < 2) { day = "0" + day; }
                                                        var newdate = day + "/" + month + "/" + year;
                                                        FileDtls.Date = newdate;
                                                    }
                                                    else
                                                    {
                                                        var oDate2 = DateTime.ParseExact(olddate, "dd/MM/yyyy", null);
                                                    }
                                                    //var newdate = olddate[1] + '/' + olddate[0] + '/' + olddate[2];
                                                    //var nndate = newdate.ToString("dd/mm/yyyy");
                                                    //FileDtls.Date = workSheet.Cells[rowIterator, i].Value == null ? null : Convert.ToDateTime(workSheet.Cells[rowIterator, i].Value).ToString("dd/MM/yyyy");
                                                    break;
                                                case 2:
                                                    FileDtls.TimeIN = workSheet.Cells[rowIterator, i].Value == null ? null : Convert.ToDateTime(workSheet.Cells[rowIterator, i].Value).ToString("HH:mm:ss");
                                                    break;
                                                case 3:
                                                    FileDtls.TimeOut = workSheet.Cells[rowIterator, i].Value == null ? null : Convert.ToDateTime(workSheet.Cells[rowIterator, i].Value).ToString("HH:mm:ss"); 
                                                    break;
                                                case 4:
                                                    FileDtls.TimeFunction = workSheet.Cells[rowIterator, i].Value == null ? null : Convert.ToDateTime(workSheet.Cells[rowIterator, i].Value).ToString("HH:mm:ss");
                                                    break;
                                                case 5:
                                                    FileDtls.FunctionID = workSheet.Cells[rowIterator, i].Value.ToString();
                                                    break;
                                                case 6:
                                                    FileDtls.EmployeeID = int.Parse(workSheet.Cells[rowIterator, i].Value.ToString());
                                                    break;
                                                case 7:
                                                    var checkid = int.Parse(workSheet.Cells[rowIterator, i].Value.ToString());
                                                        var machinetableid = db.AttMachineTableRefrences.Where(a => a.MachineID == checkid && a.TableID == TableID).FirstOrDefault();
                                                        if (machinetableid != null)
                                                        {
                                                            FileDtls.MachineTableID = machinetableid.Id;
                                                            break;
                                                        }
                                                        else
                                                        {
                                                            TempData["failed"] = "MachineId "+ checkid + " doesn't define to a table in the system";
                                                            return RedirectToAction("Index");
                                                        }
                                                    break;
                                                case 8:
                                                    FileDtls.Comment = workSheet.Cells[rowIterator, i].Value.ToString();
                                                    break;
                                                default:
                                                    TempData["failed"] = "There's an error";
                                                    return RedirectToAction("Index");
                                                    break;

                                            }
                                        }
                                    }
                                    myList.Add(FileDtls);
                                }
                                foreach(var lists in myList)
                                {
                                    db.AttendanceLogs.Add(lists);
                                    db.SaveChanges();
                                }
                            }
                        }

                        TempData["success"] = "Process Done Successfully";

                    }
                    return RedirectToAction("Index");


                }
                catch (Exception e)
                {
                    TempData["failed"] = e.Message;
                    return RedirectToAction("Index");
                }
            }
            TempData["failed"] = "No file Uploaded";
            return RedirectToAction("Index");

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
