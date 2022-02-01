using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Cohire.Model.PostJob;
using CohireAPI.PostJobs.Model;
using System.Net;
using System.Text;
using System.Web;
using System.Net.Http;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http;
using System.Data.SqlClient;
using System.Data;
using Cohire.Models.CommonOperation;
using Newtonsoft.Json;
using System.IO;
using Microsoft.Extensions.Hosting;

namespace Cohire.Controllers
{
    public class UserController : Controller
    {
        private IWebHostEnvironment Environment;
        private ILogger<PostJobController> _logger;
        private  IWebHostEnvironment _webHostEnvironment;
        private readonly IHttpContextAccessor _httpContextAccessor;
        string URL = string.Empty;
        public UserController(IWebHostEnvironment _environment, ILogger<PostJobController> logger, IWebHostEnvironment webhttpContextAccessor, IHttpContextAccessor httpContextAccessor)
        {
            Environment = _environment;
            _logger = logger;
            _webHostEnvironment = webhttpContextAccessor;
            _httpContextAccessor = httpContextAccessor;
            var host = _httpContextAccessor.HttpContext.Request;
            URL = host.Scheme + "://" + host.Host.Value;
        }
        public IActionResult Index()
        {
            return View("UserHome");
        }

        [HttpPost]
        public IActionResult Index(PostJobModel postModel)
        {

            //var listOfFiles = new PostJobController(Environment, _logger, null).PostJob(postModel);

           
            ViewBag.Msg = "Ok";
            return View("UserHome", postModel);
        }

        public IActionResult SignIn()
        {
            ViewBag.SignIn = "SignIn";
            return View("UserHome");
        }
        [HttpGet]
        public JsonResult ApplyJobGet(string JobId, string ProfileID)
        {
            ApplyJobGetModel applyJobGetModel = new ApplyJobGetModel();
               DataTable datatable = new DataTable();
            SqlConnection conn = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString());
            SqlCommand cmd = new SqlCommand("GetJobApplyDetailsWithUserDetails", conn);

            conn.Open();
            cmd.Parameters.Add("@CHProfileID", SqlDbType.VarChar).Value = ProfileID;
            cmd.Parameters.Add("@ChJobID", SqlDbType.VarChar).Value = JobId;
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(datatable);
            conn.Close();
            da.Dispose();
            if(datatable.Rows.Count>0)
            {
                applyJobGetModel = CommonOP.Instance.ConvertDataTable<ApplyJobGetModel>(datatable).FirstOrDefault();
                var jobDetails = JsonConvert.DeserializeObject<ViewPostJobModel>(applyJobGetModel.JobJson);
                applyJobGetModel.JobQuestion = jobDetails.JobQuestions;
            }
            return Json(applyJobGetModel);
        }

        [HttpPost]
        public JsonResult ApplyJobpost(ApplyJobSubMit model)
        {
            bool isNumeric = true;
            string serachInstance = String.Empty;
            Guid jobID = System.Guid.NewGuid();
            string ApllyJobID = "CHJ" + jobID.ToString().Substring(0, 6);
            var uploadDirecotroy = "ApplyJobResume\\";
            var uploadPath = Path.Combine(_webHostEnvironment.WebRootPath, uploadDirecotroy);
            if (!Directory.Exists(uploadPath))
                Directory.CreateDirectory(uploadPath);
            var fileName = Guid.NewGuid() + Path.GetExtension(model.ResumeFile.FileName);
            var filePath = Path.Combine(uploadPath, fileName);
            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                model.ResumeFile.CopyToAsync(stream);
            }
            string ResumeFileUrl = URL + "/ApplyJobResume/" + fileName;
            var json = JsonConvert.SerializeObject(model.applyJobQuestionAnswers);
            string ins_applyJobQuestionAnswers = json.ToString();
            SqlConnection azureSQLDb = null;
            try
            {
                using (azureSQLDb = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString()))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    SqlCommand cmd = new SqlCommand("Insert_ApplyJob", azureSQLDb);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@CH_ApllyJobID", SqlDbType.VarChar).Value = ApllyJobID;
                    cmd.Parameters.Add("@ChJobID", SqlDbType.VarChar).Value = model.ChJobID;
                    cmd.Parameters.Add("@CHProfileID", SqlDbType.VarChar).Value = model.CHProfileID;
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = model.Email;
                    cmd.Parameters.Add("@Mobile", SqlDbType.VarChar).Value = model.Mobile;
                    cmd.Parameters.Add("@FullName", SqlDbType.VarChar).Value = model.FullName;
                    cmd.Parameters.Add("@Is_termAccept", SqlDbType.Bit).Value = model.Is_termAccept;
                    cmd.Parameters.Add("@ResumeFileUrl", SqlDbType.VarChar).Value = ResumeFileUrl;
                    cmd.Parameters.Add("@applyJobQuestionAnswers", SqlDbType.VarChar).Value = ins_applyJobQuestionAnswers;
                    cmd.Parameters.Add("@datetimeofApply", SqlDbType.VarChar).Value = DateTime.Now.ToString("0:ddd, MMM d, yyyy");
                    var skilldata = cmd.ExecuteScalar();
                    int n;
                    isNumeric = int.TryParse(skilldata.ToString(), out n);
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
            return Json(isNumeric);
        }
    }
}

