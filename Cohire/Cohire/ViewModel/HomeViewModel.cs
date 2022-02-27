using Cohire.Models;
using Cohire.Models.JobFeedListNM;
using Cohire.Models.MasterData;
using CohireAPI.PostJobs.Model;
using System.Collections.Generic;

namespace Cohire.ViewModel
{
    public class HomeViewModel
    {
        public List<JobFeedList> jobFeedList { get; set; }
        public List<Job_Category> job_Category { get; set; }
        public List<Job_EmploymentType> job_EmploymentType { get; set; }
        public List<Job_Expernice> job_Expernice { get; set; }
        public PostJobModel postJobModel { get; set; }
        public string BaseURL { get; internal set; }
    }
}
