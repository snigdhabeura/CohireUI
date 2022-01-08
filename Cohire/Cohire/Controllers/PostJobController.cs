using Cohire.Model.PostJob;
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
        [Route("getjobs")]
        [HttpPost]
        public async Task<JsonResult> JobFeed()
        {
            
            return new JsonResult("");
        }

        [Route("getroles")]
        [HttpGet]
        public async Task<JsonResult> GetRoles()
        {
            var data = await PostJobDB.Instance.GetRolls();
            return new JsonResult(data);
        }

        [Route("getskills")]
        [HttpGet]
        public async Task<JsonResult> GetSkills(string prefix)
        {
            var data =await PostJobDB.Instance.GetSkills(prefix);
            return new JsonResult(data);
        }

        [Route("getquestions")]
        [HttpGet]
        public async Task<JsonResult> GetQuestions(string prefix)
        {
            var data = await PostJobDB.Instance.GetQuestion();
            return new JsonResult(data);
        }

        [Route("post")]
        [HttpPost]
        public async Task<JsonResult> PostJob([FromForm] PostJobModel postJobModel)
        {
            
            Guid jobID = System.Guid.NewGuid();
            string ChJobID = "CHJ" + jobID.ToString().Substring(0, 6);
            ViewPostJobModel postJobviewModels = new ViewPostJobModel();
            postJobviewModels.JobId = jobID;
            postJobviewModels.ChJobID = ChJobID;
            postJobviewModels.RoleId = postJobModel.RoleId;
            postJobviewModels.PostedByID = postJobModel.PostedByID;
            postJobviewModels.JobDescription = postJobModel.JobDescription;
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
                    filename= fileName
                });
            }
            postJobviewModels.JobFiles = Filesresult;
            var json = JsonConvert.SerializeObject(postJobviewModels);
            string serachInstance = postJobModel.RoleId.ToLower() + "-" + postJobModel.Skills.ToLower();
            var Is_insert =await PostJobDB.Instance.CreateJobPublic(jobID.ToString(), ChJobID, postJobModel.PostedByID, json, serachInstance);
            return new JsonResult(json);
        }
        [Route("update")]
        [HttpPost]
        public async Task<JsonResult> UpdateJob([FromForm] UpdatePostJobModel postJobModel)
        {
            ViewPostJobModel postJobviewModels = new ViewPostJobModel();
            postJobviewModels.JobId = postJobModel.JobId;
            postJobviewModels.ChJobID = postJobModel.ChJobID;
            postJobviewModels.RoleId = postJobModel.RoleId;
            postJobviewModels.PostedByID = postJobModel.PostedByID;
            postJobviewModels.JobDescription = postJobModel.JobDescription;
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
            var Is_insert = await PostJobDB.Instance.UpdateJobPublic(postJobModel.ChJobID, json, serachInstance);
            return new JsonResult(json);
        }
    }
}
