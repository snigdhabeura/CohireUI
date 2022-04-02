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
using System.Net.Http.Headers;
using Cohire.Models.JobFeedListNM;
using Cohire.Models.UserAuthentication;
using Cohire.Models.Response_Model;
using Cohire.Models.MasterData;
using Cohire.Models.Profile;

namespace Cohire.Controllers
{
    public class UserController : Controller
    {
        private IWebHostEnvironment Environment;
        private ILogger<PostJobController> _logger;
        private  IWebHostEnvironment _webHostEnvironment;
        private readonly IHttpContextAccessor _httpContextAccessor;
        string URL = string.Empty;
        private object hostingEnvironment;

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
            Api_Response<ViewPostJobModel> api_Response = new Api_Response<ViewPostJobModel>();

            bool isNumeric = true;
            string PostedByID = Convert.ToString(Request.Cookies["UserID"]);
            string PostedByName = Convert.ToString(Request.Cookies["Username"]);
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
            var json = JsonConvert.SerializeObject(model.applyJobQuestions);
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
                    cmd.Parameters.Add("@CHProfileID", SqlDbType.VarChar).Value = PostedByID;
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = model.Email;
                    cmd.Parameters.Add("@Mobile", SqlDbType.VarChar).Value = model.Mobile;
                    cmd.Parameters.Add("@FullName", SqlDbType.VarChar).Value = model.FullName;
                    cmd.Parameters.Add("@Is_termAccept", SqlDbType.Bit).Value = model.Is_termAccept;
                    cmd.Parameters.Add("@ResumeFileUrl", SqlDbType.VarChar).Value = ResumeFileUrl;
                    cmd.Parameters.Add("@applyJobQuestionAnswers", SqlDbType.VarChar).Value = model.applyJobQuestions;
                    cmd.Parameters.Add("@datetimeofApply", SqlDbType.VarChar).Value = DateTime.Now.ToString("0:ddd, MMM d, yyyy");
                    var skilldata = cmd.ExecuteScalar();
                    int n;
                    isNumeric = int.TryParse(skilldata.ToString(), out n);
                    if (!string.IsNullOrEmpty(isNumeric.ToString()))
                    {
                        ViewBag.ApplyID = ApllyJobID;
                    }
                    else { ViewBag.ApplyID = "Failed"; }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
            return Json(ApllyJobID);
        }

        #region---------------------Refer User for Job-------------------
        public class ReferModel
        {
            public string Fullname { get; set; }
            public string mobile { get; set; }
            public string email { get; set; }
            public int Is_term { get; set; }
            public List<IFormFile> Attachments { get; set; }
            public string chJobID { get; set; }
        }
        [HttpPost]
        public async Task<JsonResult> ReferFreind(ReferModel models)
        {
            try
            {
                Guid RefID = System.Guid.NewGuid();
                string CHREF = "CHREF" + RefID.ToString().Substring(0, 6);
                string filename = string.Empty;
                foreach (IFormFile source in models.Attachments)
                {
                    filename = ContentDispositionHeaderValue.Parse(source.ContentDisposition).FileName.Trim('"');
                    filename = this.EnsureCorrectFilename(filename);
                    using (FileStream output = System.IO.File.Create(this.GetPathAndFilename(filename)))
                        source.CopyTo(output);
                }
                SqlConnection conn = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString());
                SqlCommand cmd = new SqlCommand("Insert_Ref_job", conn);
                conn.Open();
                cmd.Parameters.Add("@Ch_Refer_Id", SqlDbType.VarChar).Value = CHREF;
                cmd.Parameters.Add("@Referer_ID", SqlDbType.VarChar).Value = Request.Cookies["UserID"];
                cmd.Parameters.Add("@ChJobID", SqlDbType.VarChar).Value = models.chJobID;
                cmd.Parameters.Add("@FullName", SqlDbType.VarChar).Value = models.Fullname;
                cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = models.email;
                cmd.Parameters.Add("@Mobile", SqlDbType.VarChar).Value = models.mobile;
                cmd.Parameters.Add("@Is_Trem_Accept", SqlDbType.Bit).Value = models.Is_term;
                cmd.Parameters.Add("@Resume_File", SqlDbType.VarChar).Value = URL + "/Refer_job_Files/" + filename;
                cmd.CommandType = CommandType.StoredProcedure;
                var Is_insert = cmd.ExecuteScalar();
                var JobActionModel = JsonConvert.DeserializeObject<JobActionModel>(Is_insert.ToString());
                var jobFeedList = JsonConvert.DeserializeObject<JobFeedList>(JobActionModel.JobJson.ToString());
                int current_previouscount = 0;
                    current_previouscount = (Convert.ToInt32(jobFeedList.referCount) + 1);
                    jobFeedList.referCount = current_previouscount.ToString();
                
                var jobJson = JsonConvert.SerializeObject(jobFeedList);
                cmd = new SqlCommand("UpdatePostJob", conn);
                cmd.Parameters.Add("@updateType", SqlDbType.VarChar).Value = 'r';
                cmd.Parameters.Add("@JobJosn", SqlDbType.VarChar).Value = jobJson;
                cmd.Parameters.Add("@CountOfAction", SqlDbType.VarChar).Value = current_previouscount.ToString();
                cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["UserID"]);
                cmd.Parameters.Add("@JobId", SqlDbType.VarChar).Value = models.chJobID;
                cmd.CommandType = CommandType.StoredProcedure;
                var Is_updtaed = await cmd.ExecuteScalarAsync();
                var model = JsonConvert.DeserializeObject<SigupModel>(Is_updtaed.ToString());
                //send mail
                CommonOP.Instance.SendEmailGoDady(models.email, "Approve Refer", "Hi "+ models.Fullname + ", You refred by your friend "+ Request.Cookies["Username"] + " for a job, Please approve <a href='"+URL+ "/User/ValidRef?rd=" + CHREF + "'>Approve</a>");
                return new JsonResult(CHREF);
            }
            catch (Exception ex)
            {

                return new JsonResult("0");
            }

            
        }
        private string EnsureCorrectFilename(string filename)
        {
            if (filename.Contains("\\"))
                filename = filename.Substring(filename.LastIndexOf("\\") + 1);

            return filename;
        }

        private string GetPathAndFilename(string filename)
        {
            return _webHostEnvironment.WebRootPath + "\\Refer_job_Files\\" + filename;
        }
        [HttpGet]
        public IActionResult ValidRef(string rd)
        {
            try
            {
                SqlConnection conn = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString());
                SqlCommand cmd = new SqlCommand("Update_Ref_job_Candidate_Aprove", conn);
                conn.Open();
                cmd.Parameters.Add("@Ch_Refer_Id", SqlDbType.VarChar).Value = rd;
                cmd.CommandType = CommandType.StoredProcedure;
                var Is_insert = cmd.ExecuteScalar();
                conn.Close();
                ViewBag.Message = "Thanks for Approve your referId <b>"+ rd + "</b>";
            }
            catch (Exception ex)
            {

                ViewBag.Message = "Something went wrong Plesae try again.";
            }
            return View();
        }
        #endregion

        [HttpPost]
        public async  Task<JsonResult> InserLikeCount(string jobID, int Is_like)
        {
            SqlConnection conn = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString());
            SqlCommand cmd = new SqlCommand("Insert_Like_For_job_Post", conn);
            conn.Open();
            cmd.Parameters.Add("@jobID", SqlDbType.VarChar).Value = jobID;
            cmd.Parameters.Add("@userId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["Username"]);
            cmd.Parameters.Add("@Is_like ", SqlDbType.Int).Value = Is_like;
            cmd.CommandType = CommandType.StoredProcedure;
            var Is_inseret=cmd.ExecuteScalar();
            var JobActionModel = JsonConvert.DeserializeObject<JobActionModel>(Is_inseret.ToString());
           var jobFeedList = JsonConvert.DeserializeObject<JobFeedList>(JobActionModel.JobJson.ToString());
            int current_previouscount = 0;
            if (Is_like==1)
            {
                current_previouscount = (Convert.ToInt32(jobFeedList.likeCount) + 1);
                jobFeedList.likeCount = current_previouscount.ToString();
            }
            else
            {
                current_previouscount = (Convert.ToInt32(jobFeedList.likeCount)- 1);
                jobFeedList.likeCount = current_previouscount.ToString();
            }
            var jobJson = JsonConvert.SerializeObject(jobFeedList);
            cmd = new SqlCommand("UpdatePostJob", conn);
            cmd.Parameters.Add("@updateType", SqlDbType.VarChar).Value = 'l';
            cmd.Parameters.Add("@JobJosn", SqlDbType.VarChar).Value = jobJson;
            cmd.Parameters.Add("@CountOfAction", SqlDbType.VarChar).Value = current_previouscount.ToString();
            cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = Convert.ToString(Request.Cookies["UserID"]);
            cmd.Parameters.Add("@JobId", SqlDbType.VarChar).Value = jobID;
            cmd.Parameters.Add("@Is_like", SqlDbType.Int).Value = Is_like;
            cmd.CommandType = CommandType.StoredProcedure;
            var Is_updtaed = await cmd.ExecuteScalarAsync();
           var model = JsonConvert.DeserializeObject<SigupModel>(Is_updtaed.ToString());
            return Json(current_previouscount);
        }
        public class CommentSectionLit
        {
            public string comment { get; set; }
            public string FullName { get; set; }
            public string Profile_Image { get; set; }
        }
        [HttpPost]
        public async Task<JsonResult> GetCommentForPost(string jobID)
        {
            SqlConnection conn = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString());
            SqlCommand cmd = new SqlCommand("GetCommentForThePost", conn);
            conn.Open();
            cmd.Parameters.Add("@ChJobID", SqlDbType.VarChar).Value = jobID;
            cmd.CommandType = CommandType.StoredProcedure;
            var data = cmd.ExecuteScalar().ToString();
            var get_Comment = JsonConvert.DeserializeObject<List<CommentSectionLit>>(cmd.ExecuteScalar().ToString());
            return Json(get_Comment);
        }
        public class GetUser
        {
            public string cHProfileID { get; set; }
            public string fullName { get; set; }
            public string profile_Image { get; set; }
            public string profileBio { get; set; }
        }
        [HttpPost]
        public async Task<JsonResult> GetPeopleList()
        {
            List<GetUser> getUser = new List<GetUser>();
               SqlConnection conn = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString());
            SqlCommand cmd = new SqlCommand("getPeople", conn);
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            var data = cmd.ExecuteScalar();
            if(data!=null)
            {
                getUser = JsonConvert.DeserializeObject<List<GetUser>>(data.ToString());
                
            }
            conn.Close();
            return Json(getUser);

        }
        [HttpPost]
        public async Task<JsonResult> GetMasterData(int masterId,int is_options)
        {
            Masterdataoperation masterdataoperation = new Masterdataoperation();
            
            if (is_options==1)
            {
                var data = masterdataoperation.GetMasterDataAsync<string>(masterId, is_options).Result;
                return Json(data);
            }
            else if (is_options == 3)
            {
                var data = masterdataoperation.GetMasterDataAsync<string>(masterId, is_options).Result;
                return Json(data);
            }
            else
            {
                var data = masterdataoperation.GetMasterDataAsync<List<MasterDataList>>(masterId, is_options).Result;
                return Json(data);
            }
        }

        #region------ Search Job ------------------------
        [HttpGet]
        public async Task<IActionResult> SearchPageJob(string t,string s)
        {
            Jobcard jobcard = new Jobcard();
               SqlConnection conn = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString());
            SqlCommand cmd = new SqlCommand("serachJobCard", conn); 
            cmd.Parameters.Add("@textsearch", SqlDbType.VarChar).Value = s.ToLower();
            //cmd.Parameters.Add("@skip", SqlDbType.Int).Value = 0;
            //cmd.Parameters.Add("@take", SqlDbType.Int).Value = 10;
            if(t.ToLower()=="j")
            {
                jobcard.Searchfor = "jobs";
                jobcard.searchtype = t.ToLower();
                cmd.Parameters.Add("@Searchtype", SqlDbType.VarChar).Value = t.ToLower();
            }
            else if(t.ToLower() == "p")
            {
                jobcard.Searchfor = "posts";
                jobcard.searchtype = t.ToLower();
                cmd.Parameters.Add("@Searchtype", SqlDbType.VarChar).Value = t.ToLower();
            }
            else if (t.ToLower() == "pe")
            {
                jobcard.Searchfor = "peoples";
                jobcard.searchtype = t.ToLower();
                cmd.Parameters.Add("@Searchtype", SqlDbType.VarChar).Value = t.ToLower();
            }
            else
            {
                jobcard.Searchfor = "jobs";
                jobcard.searchtype = "j";
                cmd.Parameters.Add("@Searchtype", SqlDbType.VarChar).Value = "j";
            }
            //cmd.Parameters.Add("@is_new", SqlDbType.Bit).Value = true;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            var data = cmd.ExecuteScalar().ToString();
            if(!string.IsNullOrEmpty(data))
            {
                var jobs = JsonConvert.DeserializeObject<List<JobJsonRoot>>(data.ToString());
                var liststring = "["+string.Join(",", jobs.Select(x=>x.jsonstring))+"]";
                if(jobcard.searchtype == "pe")
                {
                    List<ProfileModel> profileModels= JsonConvert.DeserializeObject<List<ProfileModel>>(liststring).Skip(0).Take(10).ToList();
                    jobcard.profileModels = profileModels;
                    jobcard.totalresultfound = profileModels.Count().ToString();
                }
                else
                {
                    List<postjobsearch> listofjob = JsonConvert.DeserializeObject<List<postjobsearch>>(liststring).Skip(0).Take(10).ToList(); ;
                    jobcard.listofjob = listofjob;
                    jobcard.totalresultfound = listofjob.Count().ToString();
                }
                
            }
            jobcard.Searchtext = s;
            return View(jobcard);
        }

        [HttpPost]
        public async Task<JsonResult> GetsearchResult(string jobcategory, string typeofemplymemnt,
        string experineceleve, string salaryrange, string company, string skip, string take,
        string searchtext, string location,string serachtype
        )
        {
            Jobcard jobcard = new Jobcard();
            SqlConnection conn = new SqlConnection(GetConnectionString.Instance.ReturnConnectionString());
            SqlCommand cmd = new SqlCommand("serachJobCard", conn);
            cmd.Parameters.Add("@textsearch", SqlDbType.VarChar).Value = searchtext.ToLower();
            if (string.IsNullOrEmpty(skip) || string.IsNullOrEmpty(take))
            {
                skip = "0";
                take = "10";
            }
            if (serachtype.ToLower() == "j" || string.IsNullOrEmpty(serachtype))
            {
                jobcard.Searchfor = "jobs";
                jobcard.searchtype = "j";
                cmd.Parameters.Add("@Searchtype", SqlDbType.VarChar).Value = serachtype.ToLower();
            }
            else if (serachtype.ToLower() == "p")
            {
                jobcard.Searchfor = "posts";
                jobcard.searchtype = serachtype.ToLower();
                cmd.Parameters.Add("@Searchtype", SqlDbType.VarChar).Value = serachtype.ToLower();
            }
            else if (serachtype.ToLower() == "pe")
            {
                jobcard.Searchfor = "peoples";
                jobcard.searchtype = serachtype.ToLower();
                cmd.Parameters.Add("@Searchtype", SqlDbType.VarChar).Value = serachtype.ToLower();
            }
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            var data = cmd.ExecuteScalar().ToString();
            if (!string.IsNullOrEmpty(data))
            {
                var jobs = JsonConvert.DeserializeObject<List<JobJsonRoot>>(data.ToString());
                var liststring = "[" + string.Join(",", jobs.Select(x => x.jsonstring)) + "]";
                if (jobcard.searchtype == "pe")
                {
                    List<ProfileModel> profileModels = JsonConvert.DeserializeObject<List<ProfileModel>>(liststring);
                    jobcard.totalresultfound = profileModels.Count().ToString();
                    jobcard.profileModels = profileModels.Skip(Convert.ToInt32(skip)).Take(Convert.ToInt32(take)).ToList();
                }
                else
                {
                    List<postjobsearch> listofjob = JsonConvert.DeserializeObject<List<postjobsearch>>(liststring);
                    if (!string.IsNullOrEmpty(jobcategory) && jobcategory.ToLower() != "Job categories".ToLower())
                    {
                        listofjob = listofjob.Where(x => x.Category_Name == jobcategory).ToList();
                    }
                    if (!string.IsNullOrEmpty(typeofemplymemnt) && typeofemplymemnt.ToLower() != "Type of employment".ToLower())
                    {
                        listofjob = listofjob.Where(x => x.Employmenttype_Name == typeofemplymemnt).ToList();
                    }
                    if (!string.IsNullOrEmpty(experineceleve) && experineceleve.ToLower() != "Experience level".ToLower())
                    {
                        listofjob = listofjob.Where(x => x.Experience_Name == experineceleve).ToList();
                    }
                    if (!string.IsNullOrEmpty(salaryrange) && salaryrange.ToLower() != "Salary range".ToLower())
                    {
                        listofjob = listofjob.Where(x => x.Salaryrange == salaryrange).ToList();
                    }
                    jobcard.totalresultfound = listofjob.Count().ToString();
                    jobcard.listofjob = listofjob.Skip(Convert.ToInt32(skip)).Take(Convert.ToInt32(take)).ToList();
                }

            }
            return new JsonResult(jobcard);
        }
        #endregion
    }
}

