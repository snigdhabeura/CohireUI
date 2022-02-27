using Cohire.Models;
using Cohire.Models.JobFeedListNM;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Dynamic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Cohire.ViewModel;
using CohireAPI.PostJobs.Model;
using Cohire.Models.MasterData;
using System.Text;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Hosting;
using Cohire.Models.JobFeed;
using Cohire.Models.Response_Model;
using Cohire.Model.PostJob;
using System.IO;
using System.Data.SqlClient;
using Cohire.Models.CommonOperation;
using System.Data;
using Aspose.Words;

namespace Cohire.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<PostJobController> _logger;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private static string connectionString = string.Empty;
        string URL = string.Empty;
        private readonly IHostingEnvironment _hostingEnvironment;
        private string projectRootPath;
        public HomeController(IHostingEnvironment hostingEnvironment,IWebHostEnvironment webHostEnvironment, ILogger<PostJobController> logger, IHttpContextAccessor httpContextAccessor)
        {
            _webHostEnvironment = webHostEnvironment;
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
            var host = _httpContextAccessor.HttpContext.Request;
            URL = host.Scheme + "://" + host.Host.Value;
            connectionString = GetConnectionString.Instance.ReturnConnectionString();
            _hostingEnvironment = hostingEnvironment;
            projectRootPath = _hostingEnvironment.ContentRootPath;
        }

        public async Task<IActionResult> Index()
        {
            HomeViewModel homeViewModel = new HomeViewModel();

            homeViewModel.BaseURL = URL;
            var data = await GetMasterDataAsync<JobFeedList>("api/job/getjobs");
            if(data!=null)
            {
                data.ForEach(x => { x.BaseURL = URL; });
            }
            homeViewModel.jobFeedList = data;
            homeViewModel.job_Category = await GetMasterDataAsync<Job_Category>("api/job/getjobcategory");
            homeViewModel.job_EmploymentType = await GetMasterDataAsync<Job_EmploymentType>("api/job/jobemploymentType");
            homeViewModel.job_Expernice = await GetMasterDataAsync<Job_Expernice>("api/job/getjobexpernice");
            //homeViewModel.jobFeedList = await GetMasterDataAsync<JobFeedList>("api/job/getjobs");
            //GetPeopleList

            return View(homeViewModel);
        }
        [HttpPost]
        public async Task<IActionResult> IndexAsync(HomeViewModel model)
        {
            //PostJobModel postJobModel = model.postJobModel;
            ////HttpClient client = new HttpClient();
            ////string json = JsonConvert.SerializeObject(postJobModel);
            ////StringContent httpContent = new StringContent(json, Encoding.UTF8, "application/json");
            ////HttpContent httpContent1 = new StringContent(json,  Encoding.UTF8, "application/json");
            ////var response = await client.PostAsync("https://localhost:44342/api/job/post/", httpContent);

            //var json = JsonConvert.SerializeObject(postJobModel);
            //var data = new StringContent(json, Encoding.UTF8, "application/json");
            //var url = "https://localhost:44342/api/job/post";
            //using var client = new HttpClient();
            //var response = await client.PostAsync(url, data);
            //string result = response.Content.ReadAsStringAsync().Result;


            ViewBag.Msg = "Ok";
            return View();
        }
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public async Task<List<T>> GetMasterDataAsync<T>(string Url)
        {
            
            var client = new HttpClient();
            //Passing service base url
            client.BaseAddress = new Uri(URL);
            client.DefaultRequestHeaders.Clear();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));


            HttpResponseMessage response = await client.GetAsync(Url);

            var EmpResponse = response.Content.ReadAsStringAsync().Result;
            var result = JsonConvert.DeserializeObject<List<T>>(EmpResponse);
            return result;

        }
        public async Task<T> GetMasterDataAsync1<T>(string Url)
        {
            var client = new HttpClient();
            //Passing service base url
            client.BaseAddress = new Uri(URL);
            client.DefaultRequestHeaders.Clear();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));


            HttpResponseMessage response = await client.GetAsync(Url);

            var EmpResponse = response.Content.ReadAsStringAsync().Result;
            var result = JsonConvert.DeserializeObject<T>(EmpResponse);
            return result;

        }
        #region----------------JobPost Insert - Update - Get -----------------------
        
        [HttpPost]
        public async Task<JsonResult> PostJob(PostJobModel postJobModel)
        {
            Api_Response<ViewPostJobModel> api_Response = new Api_Response<ViewPostJobModel>();
            try
            {

                string serachInstance = String.Empty;
                Guid jobID = System.Guid.NewGuid();
                string ChJobID = "CHJ" + jobID.ToString().Substring(0, 6);
                ViewPostJobModel postJobviewModels = new ViewPostJobModel();
               
                postJobviewModels.JobId = jobID;
                postJobviewModels.ChJobID = ChJobID;
                postJobviewModels.RoleId = postJobModel.RoleId;
                postJobviewModels.PostedByID =Convert.ToString(Request.Cookies["UserID"]);
                postJobviewModels.PostedByName = Convert.ToString(Request.Cookies["Username"]);
                postJobviewModels.Jobtitle = postJobModel.Jobtitle;
                postJobviewModels.CategoryID = postJobModel.CategoryID;
                postJobviewModels.Category_Name = postJobModel.Category_Name;
                postJobviewModels.ExperienceID = postJobModel.ExperienceID;
                postJobviewModels.Experience_Name = postJobModel.Experience_Name;
                postJobviewModels.EmploymenttypeID = postJobModel.EmploymenttypeID;
                postJobviewModels.Employmenttype_Name = postJobModel.Employmenttype_Name;
                postJobviewModels.Salaryrange = postJobModel.Salaryrange;
                postJobviewModels.JobDescription = postJobModel.JobDescription;
                postJobviewModels.Is_Job = postJobModel.Is_Job;
                postJobviewModels.Device_Type = postJobModel.Device_Type;
                postJobviewModels.Ip_Address = postJobModel.Ip_Address;
                postJobviewModels.CreatedDate = DateTime.Now.ToString("dd MMMM yyyy");
                postJobviewModels.NoteTorecruiter = postJobModel.NoteTorecruiter;
                postJobviewModels.latestinfojobrequest = postJobModel.latestinfojobrequest;
                postJobviewModels.Is_masked_jobrequest = postJobModel.Is_masked_jobrequest;
                postJobviewModels.likeCount = "0";
                postJobviewModels.commentCount = "0";
                postJobviewModels.applyCount = "0";
                postJobviewModels.referCount = "0";
                List<string> result;
                if (!string.IsNullOrEmpty(postJobModel.JobQuestions))
                {
                    result = new List<string>();
                    string[] Questions = postJobModel.JobQuestions.Split(',');
                    Questions.ToList().ForEach(x =>
                    {
                        result.Add(x);
                    });
                    postJobviewModels.JobQuestions = result;
                }
                if (!string.IsNullOrEmpty(postJobModel.Skills))
                {
                    result = new List<string>();
                    string[] skills = postJobModel.Skills.Split(',');
                    skills.ToList().ForEach(x =>
                    {
                        result.Add(x);
                    });
                    postJobviewModels.Skills = result;
                }
                if (!string.IsNullOrEmpty(postJobModel.city))
                {
                    result = new List<string>();
                    string[] city = postJobModel.city.Split(',');
                    city.ToList().ForEach(x =>
                    {
                        serachInstance = serachInstance + "-" + x;
                        result.Add(x);
                    });
                    postJobviewModels.city = result;
                }
                if (postJobModel.JobFiles != null)
                {
                    List<PostJobFiles> Filesresult = new List<PostJobFiles>();
                    foreach (var file in postJobModel.JobFiles)
                    {
                        var uploadDirecotroy = "JobFiles\\";
                        var uploadPath = Path.Combine(_webHostEnvironment.WebRootPath, uploadDirecotroy);
                        if (!Directory.Exists(uploadPath))
                            Directory.CreateDirectory(uploadPath);
                        var fileName = Guid.NewGuid() + Path.GetExtension(file.FileName);
                        var filePath = Path.Combine(uploadPath, fileName);
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            await file.CopyToAsync(stream);
                        }
                        Filesresult.Add(new PostJobFiles
                        {
                            filetype = fileName.Split('.')[1],
                            fileurl = URL + "/JobFiles/" + fileName,
                            filename = fileName
                        });
                    }
                    postJobviewModels.JobFiles = Filesresult;
                }
                var json = JsonConvert.SerializeObject(postJobviewModels);
                serachInstance = serachInstance + "-" + postJobModel.Jobtitle.ToLower() + "-" + postJobModel.JobDescription.ToLower();
                var Is_insert = await PostJobDB.Instance.CreateJobPublic(postJobviewModels, json, serachInstance, postJobModel.city);
                if (!string.IsNullOrEmpty(Is_insert))
                {
                    api_Response.Is_Error = false;
                    api_Response.Status_Code = StatusCodes.Status200OK;
                    api_Response.data = postJobviewModels;
                    return new JsonResult(api_Response);
                }
                else
                {
                    api_Response.Is_Error = true;
                    api_Response.Status_Code = StatusCodes.Status500InternalServerError;
                    api_Response.data = null;
                    return new JsonResult(api_Response);
                }
            }
            catch (Exception ex)
            {
                api_Response.Is_Error = true;
                api_Response.Status_Code = StatusCodes.Status400BadRequest;
                api_Response.data = null;
                return new JsonResult(api_Response);
            }
        }
        
        [HttpPost]
        public async Task<JsonResult> UpdateJob([FromForm] UpdatePostJobModel postJobModel)
        {
            Api_Response<ViewPostJobModel> api_Response = new Api_Response<ViewPostJobModel>();
            try
            {
                ViewPostJobModel postJobviewModels = new ViewPostJobModel();
                postJobviewModels.JobId = postJobModel.JobId;
                postJobviewModels.ChJobID = postJobModel.ChJobID;
                postJobviewModels.RoleId = postJobModel.RoleId;
                postJobviewModels.PostedByID = postJobModel.PostedByID;
                postJobviewModels.PostedByName = "Shiva";
                postJobviewModels.Jobtitle = postJobModel.Jobtitle;
                postJobviewModels.CategoryID = postJobModel.CategoryID;
                postJobviewModels.Category_Name = postJobModel.Category_Name;
                postJobviewModels.ExperienceID = postJobModel.ExperienceID;
                postJobviewModels.Experience_Name = postJobModel.Experience_Name;
                postJobviewModels.EmploymenttypeID = postJobModel.EmploymenttypeID;
                postJobviewModels.Employmenttype_Name = postJobModel.Employmenttype_Name;
                postJobviewModels.Salaryrange = postJobModel.Salaryrange;
                postJobviewModels.JobDescription = postJobModel.JobDescription;
                postJobviewModels.Is_Job = postJobModel.Is_Job;
                postJobviewModels.Device_Type = postJobModel.Device_Type;
                postJobviewModels.Ip_Address = postJobModel.Ip_Address;
                postJobviewModels.NoteTorecruiter = postJobModel.NoteTorecruiter;
                postJobviewModels.latestinfojobrequest = postJobModel.latestinfojobrequest;
                postJobviewModels.Is_masked_jobrequest = postJobModel.Is_masked_jobrequest;
                List<string> result;
                if (!string.IsNullOrEmpty(postJobModel.JobQuestions))
                {
                    result = new List<string>();
                    string[] Questions = postJobModel.JobQuestions.Split(',');
                    Questions.ToList().ForEach(x =>
                    {
                        result.Add(x);
                    });
                    postJobviewModels.JobQuestions = result;
                }
                if (!string.IsNullOrEmpty(postJobModel.Skills))
                {
                    result = new List<string>();
                    string[] skills = postJobModel.Skills.Split(',');
                    skills.ToList().ForEach(x =>
                    {
                        result.Add(x);
                    });
                    postJobviewModels.Skills = result;
                }
                if (!string.IsNullOrEmpty(postJobModel.city))
                {
                    result = new List<string>();
                    string[] city = postJobModel.city.Split(',');
                    city.ToList().ForEach(x =>
                    {
                        result.Add(x);
                    });
                    postJobviewModels.city = result;
                }
                List<PostJobFiles> Filesresult = new List<PostJobFiles>();
                if (postJobModel.JobFiles != null)
                {
                    foreach (var file in postJobModel.JobFiles)
                    {
                        var uploadDirecotroy = "JobFiles\\";
                        var uploadPath = Path.Combine(_webHostEnvironment.WebRootPath, uploadDirecotroy);
                        if (!Directory.Exists(uploadPath))
                            Directory.CreateDirectory(uploadPath);
                        var fileName = Guid.NewGuid() + Path.GetExtension(file.FileName);
                        var filePath = Path.Combine(uploadPath, fileName);
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            await file.CopyToAsync(stream);
                        }
                        Filesresult.Add(new PostJobFiles
                        {
                            filetype = fileName.Split('.')[1],
                            fileurl = URL + "/JobFiles/" + fileName,
                            filename = fileName
                        });
                    }
                }
                if (!string.IsNullOrEmpty(postJobModel.presentjobfiles))
                {
                    string[] postJobModels = postJobModel.presentjobfiles.Split(',');
                    postJobModels.ToList().ForEach(x =>
                    {
                        Filesresult.Add(new PostJobFiles
                        {
                            filetype = x.Split('.')[1],
                            fileurl = URL + "/JobFiles/" + x,
                            filename = x
                        });
                    });
                }

                postJobviewModels.JobFiles = Filesresult;

                var json = JsonConvert.SerializeObject(postJobviewModels);
                string serachInstance = postJobModel.RoleId.ToLower() + "-" + postJobModel.Skills.ToLower();
                var Is_update = await PostJobDB.Instance.UpdateJobPublic(postJobModel.ChJobID, json, serachInstance, postJobModel.Ip_Address, postJobModel.Device_Type, postJobModel.Is_Job, postJobModel.PostedByID);
                if (!string.IsNullOrEmpty(Is_update))
                {
                    api_Response.Is_Error = false;
                    api_Response.Status_Code = StatusCodes.Status200OK;
                    api_Response.data = postJobviewModels;
                    return new JsonResult(api_Response);
                }
                else
                {
                    api_Response.Is_Error = true;
                    api_Response.Status_Code = StatusCodes.Status500InternalServerError;
                    api_Response.data = null;
                    return new JsonResult(api_Response);
                }

            }
            catch (Exception ex)
            {

                api_Response.Is_Error = true;
                api_Response.Status_Code = StatusCodes.Status400BadRequest;
                api_Response.data = null;
                return new JsonResult(api_Response);
            }
        }

        [HttpPost]
        
        public async Task<JsonResult> Editjob([FromForm] string jobId)
        {
            Api_Response<ViewPostJobModel> api_Response = new Api_Response<ViewPostJobModel>();
            try
            {
                var data = JobFeeds.Instance.GetJobFeeds(jobId);
                api_Response.Is_Error = false;
                api_Response.Status_Code = StatusCodes.Status200OK;
                api_Response.data = JsonConvert.DeserializeObject<ViewPostJobModel>(data);
                return new JsonResult(api_Response);
            }
            catch (Exception ex)
            {
                api_Response.Is_Error = true;
                api_Response.Status_Code = StatusCodes.Status400BadRequest;
                api_Response.data = null;
                return new JsonResult(api_Response);
            }
        }
       
        #endregion
        [HttpPost]
        public async Task<PartialViewResult> GetPostDetails(string JobID)
        {
            JobActionModel api_Response = new JobActionModel();
            try
            {
                
                SqlConnection azureSQLDb = null;
                SqlCommand cmd;
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    cmd = new SqlCommand("[dbo].[Get_Job_Post_Josn]", azureSQLDb);
                    cmd.Parameters.Add("@JobId", SqlDbType.VarChar).Value = JobID;
                    cmd.CommandType = CommandType.StoredProcedure;
                    var Is_Get = await cmd.ExecuteScalarAsync();
                    api_Response = JsonConvert.DeserializeObject<JobActionModel>(Is_Get.ToString());
                    api_Response.jobFeedList = JsonConvert.DeserializeObject<JobFeedList>(api_Response.JobJson.ToString());
                    api_Response.jobFeedList.BaseURL = URL;
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return PartialView(api_Response);
        }


        [HttpPost]
        public IActionResult OnPost(string FileName)
        {
            DocConeverter.Program pro = new DocConeverter.Program();
            
            string outputPath = Path.Combine(projectRootPath, "wwwroot/Content");
            string storagePath = Path.Combine(projectRootPath, "wwwroot/JobFiles");
            int pageCount = 0;
            string imageFilesFolder = Path.Combine(outputPath, Path.GetFileName(FileName).Replace(".", "_"));
            
            var docs = Path.Combine(storagePath, FileName);
            if (!Directory.Exists(imageFilesFolder))
            {
                pageCount = pro.GetDocumentImage(docs, outputPath, FileName);
            }
            else
            {
                System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(imageFilesFolder);
                pageCount = dir.GetFiles().Length;
            }
            return new JsonResult(pageCount);
        }

        [HttpGet]
        public async Task<IActionResult> JobDetails(string jobId)
        {
            HomeViewModel homeViewModel = new HomeViewModel();

            homeViewModel.BaseURL = URL;
            var data = await GetMasterDataAsync<JobFeedList>("api/job/getjobs");
            if(data != null)
            {
                data = data.Where(x => x.ChJobID == jobId).ToList();
                data.ForEach(x => { x.BaseURL = URL; });
            }
            homeViewModel.jobFeedList = data;
            homeViewModel.job_Category = await GetMasterDataAsync<Job_Category>("api/job/getjobcategory");
            homeViewModel.job_EmploymentType = await GetMasterDataAsync<Job_EmploymentType>("api/job/jobemploymentType");
            homeViewModel.job_Expernice = await GetMasterDataAsync<Job_Expernice>("api/job/getjobexpernice");
            return View(homeViewModel);
        }
    }
}
