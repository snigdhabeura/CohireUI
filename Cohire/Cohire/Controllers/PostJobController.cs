using Cohire.Model.PostJob;
using Cohire.Models.JobFeed;
using Cohire.Models.JobFeedList;
using Cohire.Models.MasterData;
using Cohire.Models.Response_Model;
using CohireAPI.PostJobs.Model;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Cohire.Controllers
{
    [Route("api/job")]
    [ApiController]
    public class PostJobController : ControllerBase
    {
        private readonly ILogger<PostJobController> _logger;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IWebHostEnvironment _webHostEnvironment;

        string URL = string.Empty;
        public PostJobController(IWebHostEnvironment webHostEnvironment, ILogger<PostJobController> logger, IHttpContextAccessor httpContextAccessor)
        {
            _webHostEnvironment = webHostEnvironment;
            _logger = logger;
            _httpContextAccessor = httpContextAccessor;
            var host = _httpContextAccessor.HttpContext.Request;
            URL=host.Scheme + "://" + host.Host.Value;
        }

        #region-----------------Job Feed-------------------------------
       
        [Route("getjobs")]
        [HttpGet]
        public async Task<JsonResult> JobFeed()
        {
            var data = JobFeeds.Instance.GetJobFeeds();
            var myDeserializedClass = JsonConvert.DeserializeObject <List<JobFeedList>>(data);
            return new JsonResult(myDeserializedClass);
        }
        #endregion

        #region------------MasterDataLoad---------------------------------
        [Route("getskills")]
        [HttpGet]
        public async Task<JsonResult> GetSkills(string prefix)//atleast 2 char
        {
            var data =await PostJobDB.Instance.GetSkills(prefix);
            return new JsonResult(data);
        }

        [Route("getquestions")]
        [HttpGet]
        public async Task<JsonResult> GetQuestions()
        {
            var data = await PostJobDB.Instance.GetQuestion();
            return new JsonResult(data);
        }

        [Route("getjobcategory")]
        [HttpGet]
        public async Task<JsonResult> GetJob_Category()
        {
            var data = await Masterdataoperation.Instance.GetMasterDataAsync<Job_Category>("GetJob_Category");
            return new JsonResult(data);
        }
        [Route("jobemploymentType")]
        [HttpGet]
        public async Task<JsonResult> Job_EmploymentType()
        {
            var data = await Masterdataoperation.Instance.GetMasterDataAsync<Job_EmploymentType>("GetJob_EmploymentType");
            return new JsonResult(data);
        }
        [Route("getjobexpernice")]
        [HttpGet]
        public async Task<JsonResult> Job_Expernice()
        {
            var data = await Masterdataoperation.Instance.GetMasterDataAsync<Job_Expernice>("GetJob_Expernice");
            return new JsonResult(data);
        }


        #endregion

        #region----------------JobPost Insert - Update - Get -----------------------
        [Route("post")]
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
                postJobviewModels.CreatedDate = DateTime.Now.ToString("dd MMMM yyyy");
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
                serachInstance = serachInstance + "-" + postJobModel.RoleId.ToLower() + "-" + postJobModel.Skills.ToLower();
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
                api_Response.data=null;
                return new JsonResult(api_Response);
            }
        }
        [Route("update")]
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
                if(!string.IsNullOrEmpty(Is_update))
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
        [Route("edit")]
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
            catch(Exception ex)
            {
                api_Response.Is_Error = true;
                api_Response.Status_Code = StatusCodes.Status400BadRequest;
                api_Response.data = null;
                return new JsonResult(api_Response);
            }
        }
        #endregion
    }
}
