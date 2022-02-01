using Cohire.Models;
using Cohire.Models.JobFeedList;
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

namespace Cohire.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public async Task<IActionResult> Index()
        {
            HomeViewModel homeViewModel = new HomeViewModel();


            homeViewModel.jobFeedList = await GetMasterDataAsync<JobFeedList>("api/job/getjobs");
            homeViewModel.job_Category = await GetMasterDataAsync<Job_Category>("api/job/getjobcategory");
            homeViewModel.job_EmploymentType = await GetMasterDataAsync<Job_EmploymentType>("api/job/jobemploymentType");
            homeViewModel.job_Expernice = await GetMasterDataAsync<Job_Expernice>("api/job/getjobexpernice");
            //homeViewModel.postJobModel = await GetMasterDataAsync1<PostJobModel>("api/job/getjobs");

            return View(homeViewModel);
        }
        [HttpPost]
        public async Task<IActionResult> IndexAsync(HomeViewModel model)
        {
            PostJobModel postJobModel = model.postJobModel;
            //HttpClient client = new HttpClient();
            //string json = JsonConvert.SerializeObject(postJobModel);
            //StringContent httpContent = new StringContent(json, Encoding.UTF8, "application/json");
            //HttpContent httpContent1 = new StringContent(json,  Encoding.UTF8, "application/json");
            //var response = await client.PostAsync("https://localhost:44342/api/job/post/", httpContent);

            var json = JsonConvert.SerializeObject(postJobModel);
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            var url = "https://localhost:44342/api/job/post";
            using var client = new HttpClient();
            var response = await client.PostAsync(url, data);
            string result = response.Content.ReadAsStringAsync().Result;


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
            string Baseurl = "https://localhost:44342/";
            var client = new HttpClient();
            //Passing service base url
            client.BaseAddress = new Uri(Baseurl);
            client.DefaultRequestHeaders.Clear();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));


            HttpResponseMessage response = await client.GetAsync(Url);

            var EmpResponse = response.Content.ReadAsStringAsync().Result;
            var result = JsonConvert.DeserializeObject<List<T>>(EmpResponse);
            return result;

        }
        public async Task<T> GetMasterDataAsync1<T>(string Url)
        {
            string Baseurl = "https://localhost:44342/";
            var client = new HttpClient();
            //Passing service base url
            client.BaseAddress = new Uri(Baseurl);
            client.DefaultRequestHeaders.Clear();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));


            HttpResponseMessage response = await client.GetAsync(Url);

            var EmpResponse = response.Content.ReadAsStringAsync().Result;
            var result = JsonConvert.DeserializeObject<T>(EmpResponse);
            return result;

        }
    }
}
